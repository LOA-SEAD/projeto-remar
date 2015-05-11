/*
 * Copyright 2014 Martin Schimak - plexiti GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package grails.plugin.camunda

import grails.util.Metadata
import org.camunda.bpm.BpmPlatform
import org.camunda.bpm.ProcessApplicationService
import org.camunda.bpm.ProcessEngineService
import org.camunda.bpm.engine.ProcessEngineException
import org.camunda.bpm.engine.RepositoryService
import org.camunda.bpm.engine.repository.DeploymentBuilder
import org.camunda.bpm.engine.spring.SpringProcessEngineConfiguration
import org.camunda.bpm.engine.spring.ProcessEngineFactoryBean
import org.camunda.bpm.engine.spring.application.SpringServletProcessApplication
import org.camunda.bpm.engine.test.mock.MockExpressionManager
import org.slf4j.bridge.SLF4JBridgeHandler
import org.springframework.beans.BeanUtils

import static grails.plugin.camunda.Configuration.*

/**
 * @author Martin Schimak <martin.schimak@plexiti.com>
 */
class CamundaPluginSupport {

    static doWithSpring = {
        if (config('camunda.deployment.scenario') == 'embedded') {
            camundaProcessEngineBean(ProcessEngineFactoryBean) {
                processEngineConfiguration = ref('camundaProcessEngineConfigurationBean')
            }
            camundaProcessEngineConfigurationBean(SpringProcessEngineConfiguration) { beanDefinition ->
                dataSource = ref('dataSource')
                transactionManager = ref('transactionManager')
                if (config('grails.test.phase')) {
                    // During test phases, use jul bridge in case no explicit user configuration exists
                    if (!SLF4JBridgeHandler.installed && !config('grails.logging.jul.usebridge')) {
                        SLF4JBridgeHandler.removeHandlersForRootLogger();
                        SLF4JBridgeHandler.install();
                    }
                    // During test phases (except functional), use MockExpressionManager
                    if (config('grails.test.phase') != 'functional') {
                        expressionManager = bean(MockExpressionManager)
                    }
                }
                // Now set configuration 
                (config('camunda.engine.configuration') as Map<String, Object>).each {
                    def prop = it.key.substring('camunda.engine.configuration'.length() + 1)
                    beanDefinition.setPropertyValue(prop, 
                        it.value instanceof String 
                                && !(String.class.isAssignableFrom(BeanUtils.findPropertyType(prop, SpringProcessEngineConfiguration))) 
                            ? ref(it.value) : it.value
                    )
                }
            }
        } else if (config('camunda.deployment.scenario') == 'shared') {
            camundaProcessEngineServiceBean(BpmPlatform) { beanDefinition ->
                beanDefinition.factoryMethod = 'getProcessEngineService'
            }
            camundaProcessEngineBean(camundaProcessEngineServiceBean: 'getDefaultProcessEngine')
            def processApplicationName = "${Metadata.current.'app.name'}"
            if (SpringServletProcessApplication.isAssignableFrom(config('camunda.deployment.application') as Class)) {
                "${processApplicationName}"(config('camunda.deployment.application'))
            }
            if (springConfig.beanNames.find { it == processApplicationName }) {
                springConfig.addAlias 'camundaProcessApplicationBean', processApplicationName
                springConfig.addAlias Identifiers.beanName('camundaProcessApplicationBean'), processApplicationName
            }
        }
        if (springConfig.beanNames.find { it == 'camundaProcessEngineBean' }) {
            // Instantiate camunda service API beans
            camundaRuntimeServiceBean(camundaProcessEngineBean: 'getRuntimeService')
            camundaRepositoryServiceBean(camundaProcessEngineBean: 'getRepositoryService')
            camundaTaskServiceBean(camundaProcessEngineBean: 'getTaskService')
            camundaManagementServiceBean(camundaProcessEngineBean: 'getManagementService')
            camundaIdentityServiceBean(camundaProcessEngineBean: 'getIdentityService')
            camundaAuthorizationServiceBean(camundaProcessEngineBean: 'getAuthorizationService')
            camundaHistoryServiceBean(camundaProcessEngineBean: 'getHistoryService')
            camundaFormServiceBean(camundaProcessEngineBean: 'getFormService')
            // Finally, register all camunda beans under their default or user configured aliases
            springConfig.beanNames.findAll { it.startsWith("camunda") && it.endsWith("Bean") }.each {
                springConfig.addAlias Identifiers.beanName(it), it
            }
        }
    }
    
    static doWithWebDescriptor = { webXml ->
        // for tomcat, declare resource links in web xml
        if (config('camunda.deployment.scenario') == 'shared'
            && (config('camunda.deployment.shared.container') == 'tomcat')) {
            def element = webXml.'context-param'
            element[element.size() - 1] + {
                'resource-ref' {
                    'description'('Process Engine Service')
                    'res-ref-name'('ProcessEngineService')
                    'res-type'(ProcessEngineService.name)
                    'res-auth'('Container')
                }
            }
            element = webXml.'resource-ref'
            element[element.size() - 1] + {
                'resource-ref' {
                    'description'('Process Application Service')
                    'res-ref-name'('ProcessApplicationService')
                    'res-type'(ProcessApplicationService.name)
                    'res-auth'('Container')
                }
            }
        }
    }
    
    static onchange = { event ->
        if (event.source && event.source.file) { // ./grails-app/processes/**/*.bpmn resource changed
            if (config('camunda.deployment.scenario') != 'none' 
              && config('camunda.deployment.autoreload')) {
                RepositoryService repositoryService = event.ctx.getBean("camundaRepositoryServiceBean")
                DeploymentBuilder deploymentBuilder = repositoryService
                    .createDeployment()
                    .enableDuplicateFiltering()
                    .name("GrailsHotDeployment")
                File resource = event.source.file
                String resourceName
                try {
                    resourceName = resource.absolutePath
                } catch (IOException e) {
                    resourceName = resource.name
                }
                try {
                    deploymentBuilder.addInputStream(resourceName, resource.newInputStream())
                } catch (IOException e) {
                    throw new ProcessEngineException("couldn't auto deploy resource $resource: $e.message", e)
                }
                deploymentBuilder.deploy()
            }
        }
    }

}
