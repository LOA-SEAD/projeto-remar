package br.ufscar.sead.loa.escolamagica.remar
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.Task

class ProcessController implements ExecutionListener{

    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService

    def index() { }

    def startProcess(){
     session.processId = runtimeService.startProcessInstanceByKey("EscolaMagicaProcess").getId()

    }


    def questionTask(){

        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        println params.id
        println task
        if((task != null)&&(params.id == "createQuestions")){
            redirect(controller: "question", action: "create")
        }
        else{
            render "deu merda"
        }

    }

    def confirmingTask(){
        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        println params.id
        println task
        if((task != null)&&(params.id == "confirming")){
           redirect(controller:"question", action: "confirming" )
        }
        else{
            render "deu merda"
        }
    }

    def completeTask(){

        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
        taskService.complete(task.id)

    }


    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        if(delegateExecution.eventName == EVENTNAME_START && delegateExecution.currentActivityId != "EndEvent") {
            println "Notify!"
            if(delegateExecution.currentActivityId=="createQuestions")
                redirect action: "questionTask", id: delegateExecution.currentActivityId
            else if(delegateExecution.currentActivityId=="confirming")
                    redirect action: "confirmingTask", id: delegateExecution.currentActivityId
        } else if(delegateExecution.currentActivityId == "EndEvent") {
            render "Acabou o processo"
        }
    }
}
