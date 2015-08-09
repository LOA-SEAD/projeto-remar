package br.ufscar.sead.loa.remar

import grails.plugin.mail.MailService
import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.RepositoryService
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.impl.identity.Authentication
import org.camunda.bpm.engine.impl.repository.DeploymentBuilderImpl
import org.camunda.bpm.engine.repository.DeploymentBuilder
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.IdentityLinkType
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.model.bpmn.BpmnModelInstance
import org.camunda.bpm.engine.identity.User
import org.camunda.bpm.engine.repository.*
import org.camunda.bpm.model.bpmn.impl.BpmnModelInstanceImpl


@Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])
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
    MailService mailService



    @Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])
    def start(){
        println params.id
        def processId = runtimeService.startProcessInstanceByKey(params.id).getId()
        session.processId = processId
        def userId = springSecurityService.getCurrentUser().getId()
        def userUserName =  br.ufscar.sead.loa.remar.User.findById(userId).getUsername()
        runtimeService.setVariable(processId, "ownerId", userId as String)
        runtimeService.setVariable(processId, "gameName", params.id as String)
        runtimeService.setVariable(processId, "username", userUserName as String )
        session.userId = userId

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
    @Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])

    def startbeta() {
        Map<String, String> map = new HashMap<>()
        map.put("owner", "admin")
        map.owner = "admin"

        def proc = runtimeService.startProcessInstanceByKey("ForcaProcess", map)
        session.processId = proc.getId()
        println session.processId

        runtimeService.setVariable(session.processId, "owner", "admin")
    }




    @Secured(['ROLE_ADMIN'])
    def deploy() {
        def rootPath = servletContext.getRealPath("/")
        def name = params.id
        def deployment = repositoryService.createDeploymentQuery().deploymentName(name).list()
        Date date
        if(deployment) {
            repositoryService.deleteDeployment(deployment[0].id, true)
        }

        BpmnModelInstanceImpl bmi =  Bpmn.readModelFromFile(new File("$rootPath/processes/$name" + ".bpmn"));

        DeploymentBuilderImpl db = repositoryService.createDeployment();
        db.addModelInstance("${name}.bpmn", bmi);
        db.name(name)

        db.deploy();
        db.activateProcessDefinitionsOn(date)

        //println repositoryService.getProcessDefinition(params.id)


        //repositoryService.getProcessDefinition("ForceProcess")

        //ProcessBuilder pB = Bpmn.createProcess(b.getDefinitions().getId());

        //DeploymentBuilder dB = RepositoryService.createDeployment()
        //dB.addModelInstance("ArrozProcess", b);

        //session.processId =  runtimeService.startProcessInstanceByKey("ArrozProcess").getId()

       // println session.processId;


        render "ok"


    }

    @Secured(['ROLE_ADMIN'])
    def undeploy() {
        println params.id
        repositoryService.deleteDeployment(params.id + "Process", true)

        render "ok"
    }

    def doTask(){
        render 'TASK DO JOGO'

    }

    def chooseUsersTasks(){

        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> allTasks = taskService.createTaskQuery().processInstanceId(session.processId).list()
        //println taskService.createTaskQuery().processInstanceId(session.processId).list()

        if(allTasks.size()==0){
            render "Processo finalizado"
        }
        else {
            respond "", model: [allusers: allUsers, alltasks: allTasks]
            println allTasks.size()
        }

    }

    @Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])
    def userProcesses(){
        String userId = springSecurityService.getCurrentUser().getId()
        List<ProcessInstance> processesList = runtimeService.createProcessInstanceQuery().list()
        if(processesList.size()!=0) {
            HashMap<ProcessInstance, List<Task>> myProcessesAndTasks = new HashMap<>()
            for (processes in processesList) {
                def var = runtimeService.getVariable(processes.id, "ownerId")
                if (userId == var) {
                    List<Task> taskList = taskService.createTaskQuery().processInstanceId(processes.id).list()
                    myProcessesAndTasks.put(processes, taskList)
                }
            }
            if(myProcessesAndTasks.size()!=0) {
                render(view: "userProcesses", model: [myProcessesAndTasks: myProcessesAndTasks])
            }
            else{
                render(view: "noProcesses")
            }

        }
        else{
            render(view: "noProcesses")
        }

    }

    def pendingTasks() {
        def currentUser = springSecurityService.getCurrentUser().id
        def username = br.ufscar.sead.loa.remar.User.findById(currentUser).getUsername()
        println username
        List<ProcessInstance> processesList = runtimeService.createProcessInstanceQuery().list()
        HashMap<List<Task>,br.ufscar.sead.loa.remar.User> myProcessesAndTasks = new HashMap<>()
            if (processesList.size() != 0) {
                for (processes in processesList) {
                    List<Task>  taskListPerProcess = taskService.createTaskQuery().processInstanceId(processes.id).taskAssignee(username).list()
                    println taskListPerProcess.size()
                    if(taskListPerProcess.size()!=0){
                        def ownerId = runtimeService.getVariable(processes.id,"ownerId")
                        def ownerUsername = br.ufscar.sead.loa.remar.User.findById(ownerId)
//                        allTasks.add(taskListPerProcess)
                        myProcessesAndTasks.put(taskListPerProcess, ownerUsername)
                    }
                }
                if (myProcessesAndTasks.size() != 0) {
                    println myProcessesAndTasks.size()
                    render(view: "pendingTasks", model: [myProcessesAndTasks: myProcessesAndTasks])
                }
                else{
                    render (view:"noTasks")
                }

            }else{
                render (view:"noTasks")
            }

        }


    def publishGame(){
        println params.web
        redirect(action: "finishedProcess")

    }

    def finishedProcess(){
        println Game.findByWeb(true)
        def webVersion = Game.findByWeb(true)
        render(view: "finishedProcess",model:[web: webVersion])
    }

    def completeTask(){
        //println params.id

        def task =  taskService.createTaskQuery().processInstanceId(session.processId).taskId(params.id).singleResult()
        taskService.complete(task.id)
        if(taskService.createTaskQuery().processInstanceId(session.processId).list().size()==0){
            redirect(action: "finishedProcess")
        }
    }

    def resolveTask(){
        println params.process
        println params.id

        def task =  taskService.createTaskQuery().processInstanceId(params.process).taskId(params.id).singleResult()
        taskService.resolveTask(task.id)
    }


    def delegateTasks(){

        //Authentication auth = identityService.getCurrentAuthentication()
        //println auth.getUserId()
        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> allTasks = taskService.createTaskQuery().processInstanceId(session.processId).list()

        //taskService.addUserIdentityLink("6841","lala", IdentityLinkType.ASSIGNEE)
        params.remove("action")
        params.remove("format")
        params.remove("controller")
        //println identityService.getCurrentAuthentication().userId
        List<ProcessInstance> instancesList = runtimeService.createProcessInstanceQuery().processInstanceId(session.processId).list()
        def proc = instancesList[0].processDefinitionId
        proc = proc.substring(0,proc.indexOf(":"))
        taskService.createTaskQuery().processInstanceId(session.processId).list()
        int i=0;
          params.each{
            key, value ->
            def user = br.ufscar.sead.loa.remar.User.findByUsername(value)
                if(user) {
                    //taskService.setOwner(key, "Denis")
                    String Key = key
                    taskService.addUserIdentityLink(Key,value,IdentityLinkType.CANDIDATE)
                    taskService.delegateTask(key, value)
                    println "chave:"+ key
                    println "valor:"+value
                    mailService.sendMail {
                        async true
                        to user.getEmail()
                        subject "Nova Tarefa no REMAR"
                        html '<h3>Você recebeu uma nova tarefa na plataforma REMAR</h3> <br>' +
                                '<br>' +
                                "Nome do processo: ${proc} " + "<br>" +
                                "Nome da Tarefa: ${allTasks[i].name} " + "<br>" +
                                "Quem delegou: ${allTasks[i].owner}" + "<br>"


                    }

                }
                else{
                    //TODO
                }
                i++

          }


        redirect action: 'chooseUsersTasks'
        //println params


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
