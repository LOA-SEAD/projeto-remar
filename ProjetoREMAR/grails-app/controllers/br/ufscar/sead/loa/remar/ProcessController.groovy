package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.model.bpmn.BpmnModelInstance
import org.camunda.bpm.model.bpmn.instance.FlowNode
import org.camunda.bpm.model.bpmn.instance.SequenceFlow
import org.camunda.bpm.model.bpmn.instance.ServiceTask
import org.camunda.bpm.model.bpmn.instance.UserTask
import org.camunda.bpm.model.xml.instance.ModelElementInstance
import org.camunda.bpm.model.xml.type.ModelElementType
import org.camunda.bpm.engine.identity.User


@Secured(["ROLE_PROF"])
class ProcessController {
    IdentityService identityService
    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService
    def redisService
    User user
    Task task
    def springSecurityService

    def startNewProcess(){
        session.processId =  runtimeService.startProcessInstanceByKey("TesteProcess").getId()
        session.userId = springSecurityService.getCurrentUser().getId()

        def currentUser = springSecurityService.getCurrentUser().camunda_id
        redirect action: "chooseUsersTasks"

            //redirect(action: "tasksOverview")
        /*
            if(activeTasks.first().assignee==currentUser){
                def parsedURI = parseBpmn(activeTasks[i])
                redirect(uri: "http://localhost:8080/"+parsedURI) // REDIRECT PARA O JOGO (ÚNICO)
            }
            else{
                redirect(uri: "http://localhost:8080/")
            }
        */

    }

    def chooseUsersTasks(){

        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> allTasks = taskService.createTaskQuery().processInstanceId(session.processId).list()
        allUsers[0]

        respond "",model:[allusers: allUsers, alltasks: allTasks]

    }

    def assignTasks(){

    }

    def tasksOverview(){

        List<Task> activeTasks = taskService.createTaskQuery().processInstanceId(session.processId).active().list()
        respond "", model:[list: activeTasks]

    }

    def parseBpmn(Task task){

            def toParseURI = task.taskDefinitionKey
            String parsedURI = toParseURI.replace(".","/")
            return parsedURI

    }

    def bpmnManagement(){

        def currentUser = springSecurityService.getCurrentUser().camunda_id


        List<Task> activeTasks = taskService.createTaskQuery().processInstanceId(session.processId).active().list()


        for(int i=0; i<activeTasks.size(); i++){
            if(currentUser == activeTasks[i].assignee){
                def parsedURI = parseBpmn(activeTasks[i])
                redirect(uri: "http://localhost:8080/"+parsedURI)   //todo REDIS (Matheus)
            }
        }


       // def modelPath = servletContext.getRealPath("/process/Teste2Process.bpmn")
        //def currentUser = springSecurityService.getCurrentUser().camunda_id
        //println identityService.createUserQuery().userEmail("admin@gmail.com")

       // BpmnModelInstance modelInstance = Bpmn.readModelFromFile(new File(modelPath))

        //Collection<ModelElementInstance> tasks = modelInstance.getModelElementsByType(UserTask.class);
/*
        for(int i=0; i<tasks.size(); i++){
            if(tasks[i].camundaAssignee == currentUser){
                println "tarefa " + tasks[i].name + "é do usuario: " + currentUser
            }
        }
*/


    }


}
