package br.ufscar.sead.loa.escolamagica.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.Task

@Secured(["ROLE_PROF"])
class ProcessController implements ExecutionListener {

    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService
    def springSecurityService
    int i = 0;

    def index() {}

    def startProcess() {
        session.processId = runtimeService.startProcessInstanceByKey("EscolaMagicaProcess").getId()
        session.userId = springSecurityService.getCurrentUser().getId()

    }

    def newVersionsTask(){
        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        println params.id
        println task
        if((task != null)&&(params.id == "newVersions")){
            redirect(controller:"game", action: "newVersion")
        }
        else{
            render "deu merda"
        }
    }


    def questionTask() {

        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        println params.id
        println task
        if ((task != null) && (params.id == "createQuestions")) {
            redirect(controller: "questionEscola", action: "index")
        } else {
            render "deu merda"
        }

    }

    def completeTask() {

        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        taskService.complete(task.id)
        println session.processId
        if (params.id == "publishService") {
            redirect(controller: "")
        }

    }


    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        if (delegateExecution.eventName == EVENTNAME_START && delegateExecution.currentActivityId != "EndEvent") {
            println "Notify!"
            if (delegateExecution.currentActivityId == "createQuestions") {
                redirect action: "questionTask", id: delegateExecution.currentActivityId
            } else if (delegateExecution.currentActivityId == "newVersions") {
                redirect action: "newVersionsTask", id: delegateExecution.currentActivityId
            }
        } //else if (delegateExecution.currentActivityId == "webVersion") {
           // redirect(uri:"")
        //}
    }
}
