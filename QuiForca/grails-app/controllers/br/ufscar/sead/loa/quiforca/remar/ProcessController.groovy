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
    def springSecurityService


    def start(){
        session.processId = runtimeService.startProcessInstanceByKey("ForcaProcess").getId()
        session.userId = springSecurityService.getCurrentUser().getId()
        println "process started"
    }

    def complete() {
        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()

        if (task != null) {
            taskService.complete(task.id)
            println params.id + " completed "
        }
    }

    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        if(delegateExecution.currentActivityId == "Gateway_1") {
            redirect controller: "theme"
        } else if(delegateExecution.currentActivityId == "ChooseTheme") {
            redirect controller: "question"
        } else if(delegateExecution.currentActivityId == "ChooseQuestions") {
            if(taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey("ChooseTheme").singleResult() != null) {
                redirect controller: "theme"
            }
        } else if(delegateExecution.currentActivityId == "RefactorTask") {
            redirect controller: "refactor"
        }
    }
}
