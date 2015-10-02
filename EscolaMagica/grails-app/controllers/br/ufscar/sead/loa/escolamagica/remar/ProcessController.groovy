package br.ufscar.sead.loa.escolamagica.remar
//
//import grails.plugin.springsecurity.annotation.Secured
//import org.camunda.bpm.engine.RuntimeService
//import org.camunda.bpm.engine.TaskService
//import org.camunda.bpm.engine.delegate.DelegateExecution
//import org.camunda.bpm.engine.delegate.ExecutionListener
//import org.camunda.bpm.engine.runtime.ProcessInstance
//
//@Secured(["ROLE_PROF", "ROLE_ADMIN"])
class ProcessController {
}
//
//    RuntimeService runtimeService
//    ProcessInstance processInstance
//    TaskService taskService
//    def springSecurityService
//    int i = 0;
//
//
//    def index() {}
//
//    def startProcess() {
//        session.processId = runtimeService.startProcessInstanceByKey("EscolaMagicaProcess").getId()
//        session.userId = springSecurityService.getCurrentUser().getId()
//
//    }
//
//    def newVersionsTask(){
//        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
//        log.debug params.id
//        log.debug task
//        if((task != null)&&(params.id == "newVersions")){
//            redirect(controller:"game", action: "newVersion")
//        }
//        else{
//            render "deu merda"
//        }
//    }
//
//
//    def questionTask() {
//
//        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
//        log.debug params.id
//        log.debug task
//        if ((task != null) && (params.id == "createQuestions")) {
//            redirect(controller: "question", action: "index")
//        } else {
//            render "deu merda"
//        }
//
//    }
//
//    def completeTask() {
//
//        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()
//        taskService.complete(task.id)
//        log.debug session.processId
//        if (params.id == "publishService") {
//            redirect(controller: "")
//        }
//
//    }
//
//
//    @Override
//    void notify(DelegateExecution delegateExecution) throws Exception {
//        if (delegateExecution.eventName == EVENTNAME_START && delegateExecution.currentActivityId != "EndEvent") {
//            log.debug "Notify!"
//            if (delegateExecution.currentActivityId == "createQuestions") {
//                redirect action: "questionTask", id: delegateExecution.currentActivityId
//            } else if (delegateExecution.currentActivityId == "newVersions") {
//                redirect action: "newVersionsTask", id: delegateExecution.currentActivityId
//            }
//        } //else if (delegateExecution.currentActivityId == "webVersion") {
//           // redirect(uri:"")
//        //}
//    }
//}
