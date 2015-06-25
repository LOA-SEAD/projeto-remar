package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import grails.util.GrailsUtil
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.RepositoryService
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.impl.RepositoryServiceImpl
import org.camunda.bpm.engine.impl.identity.Authentication
import org.camunda.bpm.engine.repository.DeploymentBuilder
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.IdentityLinkType
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.model.bpmn.BpmnModelInstance
import org.camunda.bpm.model.bpmn.builder.ProcessBuilder
import org.camunda.bpm.model.bpmn.instance.FlowNode
import org.camunda.bpm.model.bpmn.instance.SequenceFlow
import org.camunda.bpm.model.bpmn.instance.ServiceTask
import org.camunda.bpm.model.bpmn.instance.UserTask
import org.camunda.bpm.model.xml.instance.ModelElementInstance
import org.camunda.bpm.model.xml.type.ModelElementType
import org.camunda.bpm.engine.identity.User
import org.hibernate.SessionFactory
import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.repository.*
import org.camunda.bpm.model.bpmn.*


@Secured(["ROLE_PROF"])
class ProcessController {
    IdentityService identityService
    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService
    Authentication authentication
    def redisService
    User user
    Task task
    def springSecurityService
    RepositoryService repositoryService



    def startNewProcess(){


        def name = params.name;
        session.processId =  runtimeService.startProcessInstanceByKey(name + "Process").getId()
        session.userId = springSecurityService.getCurrentUser().getId()

        String currentUser = springSecurityService.getCurrentUser().camunda_id
        println "camunda id: " + currentUser

        identityService.setAuthenticatedUserId(currentUser)

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

    def test() {

        BpmnModelInstance b = Bpmn.readModelFromFile(new File("/home/loa/Denis/remar-production/remar-production/tomcat/server/apache-tomcat-7.0.50/webapps/ROOT/process/Teste2.bpmn"))
        DeploymentBuilder db = repositoryService.createDeployment()
        db.addModelInstance("Teste2.bpmn", b)
        Deployment depl = db.deploy()
        println depl.getName()


        println repositoryService.createDeploymentQuery().list()
        
        //repositoryService.getProcessDefinition("ForceProcess")

        //ProcessBuilder pB = Bpmn.createProcess(b.getDefinitions().getId());

        //DeploymentBuilder dB = RepositoryService.createDeployment()
        //dB.addModelInstance("ArrozProcess", b);

        //session.processId =  runtimeService.startProcessInstanceByKey("ArrozProcess").getId()

       // println session.processId;



    }

    def doTask(){
        render 'TASK DO JOGO'

    }

    def chooseUsersTasks(){

        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> allTasks = taskService.createTaskQuery().processInstanceId(session.processId).list()
        //println taskService.createTaskQuery().processInstanceId(session.processId).list()

       // println allTasks.size()

        respond "",model:[allusers: allUsers, alltasks: allTasks]

    }

    /*
    def beforeInterceptor = [action: this.&auth]
    private auth() {
        println params;
    }
*/

    def resolveTask(){


    }

    def completeTask(){
        //println params.id

        def task =  taskService.createTaskQuery().processInstanceId(session.processId).taskId(params.id).singleResult()
        taskService.complete(task.id)
        redirect(action: "chooseUsersTasks" ,controller: "process")

    }

    def assignTasks(){

        //Authentication auth = identityService.getCurrentAuthentication()
        //println auth.getUserId()
        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> allTasks2 = taskService.createTaskQuery().processInstanceId(session.processId).list()
        allTasks2[2]
        //taskService.addUserIdentityLink("6841","lala", IdentityLinkType.ASSIGNEE)
        params.remove("action")
        params.remove("format")
        params.remove("controller")
        //println identityService.getCurrentAuthentication().userId

          params.each{
            key, value -> println key + "->" + value

                if(br.ufscar.sead.loa.remar.User.findByCamunda_id(value)) {
                    taskService.setOwner(key, "Denis")
                    taskService.delegateTask(key, value)

                }
                else{
                    //TODO
                }

          }


        redirect action: 'chooseUsersTasks'
        //println params


    }

    def test2(){
        List<Task> allTasks2 = taskService.createTaskQuery().processInstanceId(session.processId).list()

        println "---- owners abaixo"
        println allTasks2[0].owner
        println allTasks2[1].owner
        println allTasks2[2].owner

        println "---- Assignes abaixo"
        println allTasks2[0].assignee
        println allTasks2[1].assignee
        println allTasks2[2].assignee
        println "---- delegations state abaixo"
        println allTasks2[0].delegationState
        println allTasks2[1].delegationState
        println allTasks2[2].delegationState
        println params
    }

    def tasksOverview(){

        List<Task> activeTasks = taskService.createTaskQuery().processInstanceId(session.processId).active().list()
        respond "", model:[list: activeTasks]

    }

     private String parseBpmn(Task task){

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
