package br.ufscar.sead.loa.remar

import grails.plugin.mail.MailService
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.ProcessEngineException
import org.camunda.bpm.engine.RepositoryService
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.impl.identity.Authentication
import org.camunda.bpm.engine.impl.repository.DeploymentBuilderImpl
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.IdentityLinkType
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.engine.identity.User
import org.camunda.bpm.model.bpmn.impl.BpmnModelInstanceImpl
import grails.converters.JSON


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


    @Secured(["ROLE_ADMIN", "ROLE_STUD", "ROLE_USER"])
    def start() {
        println params.id
        def processId
        try {
            processId = runtimeService.startProcessInstanceByKey(params.id).getId()
        } catch (ProcessEngineException ignored) {
            response.status = 404
            render 'The process ' + params.id + ' doesn\'t exists!'
            return
        }

        if(!Game.findByBpmn(params.id)) {
            response.status = 404
            render 'The process ' + params.id + ' doesn\'t exists!'
            return
        }

        session.user = springSecurityService.getCurrentUser()

        def game = Game.findByBpmn(params.id)

        runtimeService.setVariable(processId, "ownerId", session.user.id as String)
        runtimeService.setVariable(processId, "ownerName", session.user.name as String)
        runtimeService.setVariable(processId, "gameName", game.name as String)
        runtimeService.setVariable(processId, "gameUri", game.uri as String)
        runtimeService.setVariable(processId, "username", session.user.username as String)


        identityService.setAuthenticatedUserId(session.user.camunda_id)

        redirect uri: "/process/tasks/overview/$processId"

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
//

    @Secured(['ROLE_ADMIN'])
    def deploy() {
        def rootPath = servletContext.getRealPath("/")
        def name = params.id
        def deployment = repositoryService.createDeploymentQuery().deploymentName(name).list()
        Date date
        if (deployment) {
            repositoryService.deleteDeployment(deployment[0].id, true)
        }

        BpmnModelInstanceImpl bmi = Bpmn.readModelFromFile(new File("$rootPath/processes/$name" + ".bpmn"));

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
        repositoryService.deleteDeployment(params.id, true)

        render "ok"
    }

    private String parseBpmn(Task task) {

        def toParseURI = task.taskDefinitionKey
        String parsedURI = toParseURI.replace(".", "/")
        return parsedURI

    }
    @Secured(["ROLE_ADMIN", "ROLE_STUD", "ROLE_USER"])
    def chooseUsersTasks() {
        if (runtimeService.getVariable(params.processId, 'ownerId') as int != springSecurityService.currentUser.id && !SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            response.status = 404
            render "You shouldn't be here"
            return
        }

        List<User> allUsers = identityService.createUserQuery().list()
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(params.processId).list()

        def uri = runtimeService.getVariable(params.processId, "gameUri")

        for (task in tasks) {
            task.taskDefinitionKey = task.taskDefinitionKey.replace('.', '/')
        }

        if (tasks.size() == 0) {
            render "Processo finalizado"
        } else {
            respond "", model: [allusers: allUsers, alltasks: tasks, uri: uri, processId: params.processId]
        }

    }


    @Secured(["ROLE_ADMIN", "ROLE_STUD", "ROLE_USER"])
    def userProcesses() {
        String userId = springSecurityService.getCurrentUser().getId()
        List<ProcessInstance> processesList = runtimeService.createProcessInstanceQuery().list()
        def list = []
        for (processes in processesList) {
            def var = runtimeService.getVariable(processes.id, "ownerId")
            if (userId == var) {
                def formattedProcesses = []
                formattedProcesses[0] = runtimeService.getVariable(processes.id, "gameName")
                formattedProcesses[1] = taskService.createTaskQuery().processInstanceId(processes.id).list().size()
                formattedProcesses[2] = runtimeService.createProcessInstanceQuery().processInstanceId(processes.id).list()[0].suspended
                formattedProcesses[3] = processes.id
                list.add(formattedProcesses)
            }
        }
        if(list){
            println list[0][3]
            render(view: "userProcesses", model:[processes: list])
        }
        else{
            render(view: "noProcesses")
        }
    }

    def pendingTasks() {
        def user = springSecurityService.currentUser as br.ufscar.sead.loa.remar.User
        def tasks = taskService.createTaskQuery().taskAssignee(user.username).list()
        def list = []
        for (task in tasks) {
            def formattedTask = []
            formattedTask[0] = runtimeService.getVariable(task.processInstanceId, 'gameName')
            formattedTask[1] = task.getName()
            formattedTask[2] = runtimeService.getVariable(task.processInstanceId, 'ownerName')
            formattedTask[3] = runtimeService.getVariable(task.processInstanceId, 'gameUri')
            formattedTask[3] += '/' + task.taskDefinitionKey.replace('.', '/')
            list.add(formattedTask)
        }
        if (list) {
            render(view: "pendingTasks", model: [tasks: list])
        }
        else {
            render(view: "noTasks")
        }
    }


    def publishGame() {
        println params.web
        redirect(action: "finishedProcess")

    }

    def finishedProcess() {
        println Game.findByWeb(true)
        def webVersion = Game.findByWeb(true)
        render(view: "finishedProcess", model: [web: webVersion])
    }

    def completeTask() {
        println params.id

        taskService.complete(params.id)
//        if (taskService.createTaskQuery().processInstanceId(session.processId).list().size() == 0) {
//            redirect(action: "finishedProcess")
//        } else {
//            redirect(action: "chooseUsersTasks")
//        }
    }

    def resolveTask() {
        println params.process
        println params.id

        def task = taskService.createTaskQuery().processInstanceId(params.process).taskId(params.id).singleResult()
        taskService.resolveTask(task.id)

        render "resolved"
    }


    def delegateTasks() {
        def userId = springSecurityService.getCurrentUser().getId()
        def ownerUsername = br.ufscar.sead.loa.remar.User.findById(userId).username
        def processId = params.processId
        List<Task> allTasks = taskService.createTaskQuery().processInstanceId(session.processId).list()
        println params
        params.remove("action")
        params.remove("format")
        params.remove("controller")
        params.remove("processId")
        println params
        def proc = runtimeService.createProcessInstanceQuery().processInstanceId(processId).singleResult()
        def processName = proc.processDefinitionId.substring(0, proc.processDefinitionId.indexOf(":"))
        taskService.createTaskQuery().processInstanceId(processId).list()
        int i = 0;

        params.each {
            taskId, username ->
                taskId   = taskId as String
                username = username as String
                def user = br.ufscar.sead.loa.remar.User.findByUsername(username)
                if (user) {
                    taskService.addUserIdentityLink(taskId, ownerUsername as String, IdentityLinkType.OWNER)
                    taskService.delegateTask(taskId, username)
                    mailService.sendMail {
                        async true
                        to user.getEmail()
                        subject "Nova Tarefa no REMAR"
                        html '<h3>Você recebeu uma nova tarefa na plataforma REMAR</h3> <br>' +
                                '<br>' +
                                "Nome do processo: ${processName} " + "<br>" +
                                "Nome da Tarefa: ${allTasks[i].name} " + "<br>" +
                                "Quem delegou: ${ownerUsername}" + "<br>"
                    }

                } else {
                    //TODO
                    println "else uehauhea!!!"
                }
                i++
        }


        redirect uri:"/process/tasks/overview/$processId"
        //println params


    }

    // @Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])
//
//    def startbeta() {
//        Map<String, String> map = new HashMap<>()
//        map.put("owner", "admin")
//        map.owner = "admin"
//
//        def proc = runtimeService.startProcessInstanceByKey("ForcaProcess", map)
//        session.processId = proc.getId()
//        println session.processId
//
//        runtimeService.setVariable(session.processId, "owner", "admin")
//    }

//    def bpmnManagement(){
//
//        def currentUser = springSecurityService.getCurrentUser().camunda_id
//
//
//        List<Task> activeTasks = taskService.createTaskQuery().processInstanceId(session.processId).active().list()
//
//
//        for(int i=0; i<activeTasks.size(); i++){
//            if(currentUser == activeTasks[i].assignee){
//                def parsedURI = parseBpmn(activeTasks[i])
//                redirect(uri: "http://localhost:8080/"+parsedURI)   //todo REDIS (Matheus)
//            }
//        }

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



