package br.ufscar.sead.loa.quiforca.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.runtime.ProcessInstance
@Secured(['ROLE_PROF'])
class ProcessController implements ExecutionListener {

    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService

   def startProcess(){

    session.processId = runtimeService.startProcessInstanceByKey("ForcaProcess").getId()

   }

    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        //delegateExecution.eventName == EVENTNAME_START &&
       // println delegateExecution.getBpmnModelInstance()
        println "Ola"
    }
}
