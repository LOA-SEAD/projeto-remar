package grails.plugin.camunda

import grails.util.Environment
import grails.util.Holders
import org.camunda.bpm.application.AbstractProcessApplication
import org.camunda.bpm.engine.spring.SpringProcessEngineConfiguration
import org.camunda.bpm.engine.spring.application.SpringServletProcessApplication
import org.springframework.beans.BeanUtils

import javax.xml.bind.DatatypeConverter

/**
 * @author Martin Schimak <martin.schimak@plexiti.com>
 * @since 0.4.0
 */
class Configuration {
  
  private static def defaults = [
    /* By default works with an 'embedded' engine in case an engine configuration exists. 
     * This in turn is by default the case for the dev and test environments, see below. */
    'camunda.deployment.scenario' : {
        config('camunda.engine.configuration') ? 'embedded' : 'shared'
    },
    /* By default use org.camunda.bpm.engine.spring.application.SpringServletProcessApplication
     * (relevant for shared scenarios only). */
    'camunda.deployment.application' : SpringServletProcessApplication,
    /* By default auto reload bpmn deployment in 'dev' and 'test' environments, for all
     * others disable it. */
    'camunda.deployment.autoreload' : {
      Environment.current in [ Environment.DEVELOPMENT, Environment.TEST ]
    },
    /* By default assume 'tomcat' to be the target servlet container (relevant for shared 
     * scenarios only). */ 
    'camunda.deployment.shared.container' : 'tomcat',
    /* By default exclude - or not - some jars when building a shared container war. */
    'camunda.deployment.shared.war.excludes' : ['camunda-*.jar', 'groovy-all-*.jar'],
    'camunda.deployment.shared.war.includes' : ['camunda-engine-spring-*.jar'],
  ]
  
  static {
    if (Environment.current in [ Environment.DEVELOPMENT, Environment.TEST ]) {
      /* By default update database schema for environments 'dev' and 'test', for all 
       * other environments don't touch camunda's default. 
       */
      defaults['camunda.engine.configuration.databaseSchemaUpdate'] = true
      /* By default enable the job executor for environments 'dev' and 'test',
       * for all other environments don't touch camunda's default. 
       */
      defaults['camunda.engine.configuration.jobExecutorActivate'] = true
      /* By default deploy bpmn resources in classpath for environments 'dev' and 'test', 
       * for all other environments don't touch camunda's default. 
       */
      defaults['camunda.engine.configuration.deploymentResources'] = ['classpath:/**/*.bpmn', 'classpath:/**/*.bpmn20.xml']
    }
    if (exists('grails.test.phase') && config('grails.test.phase') != 'functional') {
      /* By default turn off job executor during test phases (except functional) for
       * all environments to enable single threaded testing 
       */
      defaults['camunda.engine.configuration.jobExecutorActivate'] = false
    }
  }

  /*
   * Validators exist for plugin specific configuration only, not for 
   * configuration dynamically used for camunda provided configuration beans.
   */
  private static def validators = [
    'camunda.deployment.scenario' : { property, value ->
      def allowed = ['embedded', 'shared', 'none']
      assert value in allowed :
        "Config property $property must be one of $allowed, instead it was: '$value'"
    },
    'camunda.deployment.application' : { property, value ->
      assert AbstractProcessApplication.isAssignableFrom(value as Class) :
        "Config property $property must be assignable from ${AbstractProcessApplication.name}, instead it was: '$value'"
    },
    'camunda.deployment.autoreload' : { property, value ->
      assert value instanceof Boolean :
        "Config property $property must be instance of ${Boolean.class.name}, instead it was: ${value?.class?.name}"
    },
    'camunda.deployment.shared.container' : { property, value ->
      def allowed = ['tomcat']
      assert value in allowed :
      "Config property $property must be one of $allowed, instead it was: '$value'"
    },
    'camunda.deployment.shared.war.excludes' : { property, value ->
      assert value ? value instanceof List : true
        "Config property $property must be instance of ${List.class.name}, instead it was: '${value?.class?.name}'"
    },
    'camunda.deployment.shared.war.includes' : { property, value ->
      assert value ? value instanceof Collection && !value.find{!(it instanceof String)} : true
      "Config property $property must be instance of ${Collection.class.name}, and its items must be instances of " +
        "${String.class.name} instead it was: '${value}'"
    },
  ]

  /**
   * Type conversion for string values exists for (non-string) configuration only
   */
  private static def converters = [
    'camunda.deployment.application' : { String p, String v -> 
      Class.forName(v) 
    },
    'camunda.deployment.autoreload' : { String p, String v ->
      v == 'true' ? true : (v == 'false' ? false : v) 
    },
    'camunda.engine.configuration' : { String p, String v ->
      def name = BeanUtils.findPropertyType(p, SpringProcessEngineConfiguration).simpleName
      name = name.substring(0, 1).toUpperCase() + name.substring(1)
      return DatatypeConverter."parse$name"(v)
    }
  ]
  
  private static def convert(String key, String value, String prop = null) {
    if (converters.containsKey(key)) {
      return converters.get(key).call(prop, value)
    } else if (key.contains('.')) {
      def idx = key.lastIndexOf('.')
      return convert(key.substring(0, idx), value, key.substring(idx + 1))
    } else {
      return value
    }
  }

  /**
   * @param property configuration property which should be tested
   * @return true, in case at least one configuration source (being: system properties, 
   * grails configuration and plugin defaults) explicitly knows a value for that property
   */
  static def exists(String property) {
    System.properties.containsKey(property) || containsKey(property) || defaults.containsKey(property)
  }

  /**
   * Method to retrieve configuration value from three configuration sources system 
   * properties overrides Config.groovy grails configuration properties, which override 
   * any plugin defaults) directly set in this class
   * @param property configuration property which should be retrieved
   * @return property value 
   */
  static def config(String property) {
    def value
    if (System.properties.containsKey(property)) {
      // First look, whether a system property exists
      value = System.getProperty(property) ?: null
    } else if (containsKey(property)) {
      // If not, look, whether a grails configuration property exists
      value = getProperty(property)
    } else {
      // If not, look, whether a default value exists
      value = defaults.get(property)
    }
    // In case the value we found is a closure, we evaluate it now
    value = value instanceof Closure ? value.call() : value
    try { // In case we deal with a string value we try to convert it now
      value = value instanceof String ? convert(property, value) : value
    } catch (RuntimeException e) {}
    if (exists(property)) {
    // In case we have a value and know a validator, we use it now
      validators.get(property)?.call(property, value)
    } else {
      // In case we still don't have a value, it could be that we were looking for a 
      // parent configuration property of many children, so we try to build it
      // First we put all keys into a collection
      def keys = defaults.keySet().toList()
      keys.addAll(System.properties.stringPropertyNames())
      keys.addAll(Holders.getGrailsApplication().config.flatten().keySet().collect { it.toString() })
      // then we recursively evaluate the config value of all matching keys, but just 
      // use those which 'exist' in at least one configuration source
      value = [:]
      keys.toSet().findAll { it.startsWith("${property}.") }.each { prop -> 
        if (exists(prop)) 
          value[prop] = config(prop) 
      }
      // In case we found such values, we were looking for a parent, in case we did 
      // not, we were looking for a configuration value which evaluates to null (either 
      // parent or child)
      value = value ?: null
    }
    return value
  }

  static ConfigObject getConfigObject(String property, ConfigObject configObject = Holders.getGrailsApplication().config) {
    int idx = property.indexOf('.')
    configObject != null && idx > 0 ? 
      getConfigObject(property.substring(idx + 1), configObject.getProperty(property.substring(0, idx)) as ConfigObject) 
      : configObject
  }

  /*
   * Helper method to retrieve a property style key from grails configuration
   */
  static Object getProperty(String property) {
    getConfigObject(property)?.get(property.substring(property.lastIndexOf('.') + 1))
  }

  /*
   * Helper method to change a property style key in grails configuration
   */
  static void setProperty(String property, Object value) {
    getConfigObject(property)?.put(property.substring(property.lastIndexOf('.') + 1), value)
  }

  /*
   * Helper method to remove a property style key from grails configuration
   */
  static void clearProperty(String property) {
    getConfigObject(property)?.remove(property.substring(property.lastIndexOf('.') + 1))
  }

  /*
   * Helper method to test whether a property style key exists in grails configuration
   */
  static boolean containsKey(String property) {
    def configObject = getConfigObject(property)
    def option = property.substring(property.lastIndexOf('.') + 1)
    if (configObject.containsKey(option)) {
      Object entry = configObject.get(option)
      if (!(entry instanceof ConfigObject)) {
        return true
      }
    }
    return false
  }

}
