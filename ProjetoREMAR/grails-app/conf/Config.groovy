// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
//grails.scaffolding.templates.domainSuffix = 'Instance'    

// twitter bootstrap
grails.plugins.twitterbootstrap.fixtaglib = true
grails.plugins.twitterbootstrap.defaultBundle = 'false'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false




environments {
    development {
        grails.logging.jul.usebridge = true
//        grails.serverURL = "http://localhost:8080"
        grails.app.context = "/"
        camundaWebapps = '/home/dexterorion/Desktop/camunda/server/apache-tomcat-7.0.50/webapps/'
	camunda {
        deployment.scenario = 'embedded'
            engine {
                configuration {
                    databaseSchemaUpdate = true
                    jobExecutorActivate = false
                    deploymentResources = ['classpath:/**/*.bpmn']
                    history = 'full'
                }
            }
        }
        grails {
            mail {
                host = "smtp.gmail.com"
                port = 465
                username = "loa.remar@gmail.com"
                password = "L04_Remar!"
                props = ["mail.smtp.auth":"true",
                         "mail.smtp.socketFactory.port":"465",
                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                         "mail.smtp.socketFactory.fallback":"false"]

            }
        }
//        grails{
//            plugin{
//                springsecurity{
//                    facebook{
//                        domain.classname = 'FacebookUser'
//                        filter.types='redirect'
//                        //filter.redirect.failureHandler='redirectFailureHandlerExample'
//                        autoCreate.roles=['ROLE_USER', 'ROLE_FACEBOOK', 'ROLE_STUD']
//                    }
//                }
//            }
//        }
    }
    production {
        grails.logging.jul.usebridge = false
//        grails.serverURL = "http://localhost:8080"
        grails.app.context = "/"
        camunda {
            deployment.autoreload = true
            deployment.scenario = 'embedded'
            engine {
                configuration {
                    databaseSchemaUpdate = true
                    deploymentResources = ['classpath:/**/*.bpmn']
                    jobExecutorActivate = false
                    history = 'full'

                }
            }
        }
    }
}

// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

log4j = {
    debug 'com.the6hours', 'grails.app.taglib.com.the6hours'
}
// Added by the Spring Security Core plugin:

grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.userLookup.userDomainClassName = 'br.ufscar.sead.loa.remar.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'br.ufscar.sead.loa.remar.UserRole'
grails.plugin.springsecurity.authority.className = 'br.ufscar.sead.loa.remar.Role'
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/index'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
    '/':                              ['permitAll'],
    '/index':                         ['permitAll'],
    '/doc':                           ['permitAll'],
    '/assets/**':                     ['permitAll'],
    '/**/js/**':                      ['permitAll'],
    '/**/css/**':                     ['permitAll'],
    '/**/images/**':                  ['permitAll'],
    '/**/favicon.ico':                ['permitAll'],
    '/data/**':                       ['permitAll'],
    '/**/scss/**':                    ['permitAll'],
    '/**/less/**':                    ['permitAll'],
    '/**/fonts/**':                   ['permitAll'],
    '/password/**':                   ['permitAll'],
    '/moodle/**':                     ['permitAll'],
    '/static/**':                     ['permitAll']
]



grails.plugin.springsecurity.facebook.autoCreate.enabled=true
grails.plugin.springsecurity.facebook.autoCreate.roles=['ROLE_USER', 'ROLE_FACEBOOK','ROLE_STUD']


grails.plugin.springsecurity.facebook.domain.classname='br.ufscar.sead.loa.remar.FacebookUser'
grails.plugin.springsecurity.facebook.appId='1621035434837394'
grails.plugin.springsecurity.facebook.secret='0a70357ea42707a19d7fa38e080d20e1'
