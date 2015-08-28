package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.mail.MailService
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.ProcessEngineException
import org.camunda.bpm.engine.RepositoryService
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.delegate.JavaDelegate
import org.camunda.bpm.engine.impl.identity.Authentication
import org.camunda.bpm.engine.impl.repository.DeploymentBuilderImpl
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.task.DelegationState
import org.camunda.bpm.engine.task.IdentityLinkType
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.engine.identity.User
import org.camunda.bpm.model.bpmn.impl.BpmnModelInstanceImpl

class ProcessController implements JavaDelegate, ExecutionListener{
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
        runtimeService.setVariable(processId, "gameId", game.id as String)
        runtimeService.setVariable(processId, "gameName", game.name as String)
        runtimeService.setVariable(processId, "gameUri", game.uri as String)
        runtimeService.setVariable(processId, "ownerUsername", session.user.username as String)


        identityService.setAuthenticatedUserId(session.user.camunda_id)

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

        //for tests
        def debug = Environment.current == Environment.DEVELOPMENT

        if (tasks.size() == 0) {
            render(view:'finishedProcess')
        } else {
            respond "", model: [allusers: allUsers, alltasks: tasks, uri: uri, processId: params.processId, debug: debug]
        }

    }

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
            formattedTask[3] = '/' + runtimeService.getVariable(task.processInstanceId, 'gameUri')
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


    def finishedProcess() {
        println Game.findByWeb(true)
        def webVersion = Game.findByWeb(true)
        render(view: "finishedProcess", model: [web: webVersion])
    }

    def completeTask() {
//        println params.taskId
//        def processId = taskService.createTaskQuery().taskId(params.taskId).singleResult().processInstanceId
//
//        taskService.complete(params.taskId)
//        redirect(uri: "/process/tasks/overview/${processId}")
        def task = taskService.createTaskQuery().taskId(params.taskId).singleResult()

        if (task) {
            if (task.delegationState == DelegationState.RESOLVED) {
                if (task.owner == session.user.username) {
                    taskService.complete(params.taskId)

                } else {
                    render "user != owner"
                }
            } else {
                render "delegation state != resolved"
            }
        } else {
            render "task doesn't exists"
        }



    }

    def resolveTask() {
        def task = taskService.createTaskQuery().taskId(params.taskId).singleResult()
        if (task) {
            if (task.delegationState == DelegationState.PENDING) {
                if (task.assignee == session.user.username) {
                    def destination = servletContext.getRealPath("/data/users/${task.owner}/${task.processInstanceId}")
                    taskService.getVariable(params.taskId, "files").each { file ->
                        file = file as String
                        def fileName =  file.substring(file.lastIndexOf('/') + 1, file.length())
                        new AntBuilder().copy(file: file, tofile: destination + "/" + fileName)
                    }
                    taskService.resolveTask(params.taskId)
                    redirect uri: '/process/pendingTasks'
                } else {
                    render "user != assignee"
                }
            } else {
                render "delegation state != pending"
            }

        } else {
            render "task doesn't exists"
        }
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


    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        println "notify"
        println delegateExecution.processInstanceId

        if (delegateExecution.currentActivityId == 'start') {
            redirect uri: "/process/tasks/overview/${delegateExecution.processInstanceId}"
        } else if (delegateExecution.currentActivityId == 'game_versions'){
            render "versions"
        }
    }

    @Override
    void execute(DelegateExecution delegateExecution) throws Exception {
        if (delegateExecution.currentActivityId == 'game_web') {
            def ownerUsername = runtimeService.getVariable(delegateExecution.processInstanceId, 'ownerUsername') as String
            def game = Game.get(runtimeService.getVariable(delegateExecution.processInstanceId, 'gameId') as String)
            def instanceFolder = new File(servletContext.getRealPath("/data/users/${ownerUsername}/${delegateExecution.processInstanceId}"))
            def json = JSON.parse(Game.get(runtimeService.getVariable(delegateExecution.processInstanceId, 'gameId') as String).files)
            println "instanceFolder = " + instanceFolder.toString()

            new AntBuilder().copy(todir: "${instanceFolder}/${game.uri}") {
                fileset(dir: servletContext.getRealPath("/data/games/sources/${game.id}"))
            }

            json.each {file, destinationFolder ->
                new AntBuilder().copy(file: "${instanceFolder}/${file}", tofile: "${instanceFolder}/${game.uri}/${destinationFolder}/${file}")
            }
        }
    }

    def publishGame() {
        ExportedGame newGame = new ExportedGame()
        newGame.owner = br.ufscar.sead.loa.remar.User.findById(springSecurityService.getCurrentUser().getId())
        newGame.exportedAt = new Date()
        newGame.type = 'public'
        newGame.image = params.gameImage
        newGame.name = params.gameName
        println params.gameWidth.toInteger()
        newGame.width = params.int('gameWidth')
        newGame.height = params.int('gameHeight')

        if(params.Web) {
            def ownerUsername = runtimeService.getVariable(params.processId, 'ownerUsername') as String
            def game = Game.get(runtimeService.getVariable(params.processId, 'gameId') as String)
            def instanceFolder = servletContext.getRealPath("/data/users/${ownerUsername}/${params.processId}")
            newGame.webUrl = "${instanceFolder}/${game.uri}"  //Need some tests!
            newGame.addToPlatforms(Platform.findByName("Web"))
        }
        if(params.Linux) {
            newGame.linuxUrl = "linuxUrl"
            newGame.addToPlatforms(Platform.findByName("Linux"))
        }
        if(params.Moodle) {
            newGame.moodleUrl = "moodleUrl"
            newGame.addToPlatforms(Platform.findByName("Moodle"))
        }
        if(params.Android) {
            newGame.androidUrl = "androidUrl"
            newGame.addToPlatforms(Platform.findByName("Android"))
        }

        newGame.save flush:true

        if(params.Moodle) {
            redirect controller: "ExportedGame", action: "accountConfig", id: newGame.id
        }
        else {
            redirect(uri: "/dashboard")
        }
    }

    def example() {
        def file = new File(servletContext.getRealPath("/perguntas.xml"))
        def file2 = new File(servletContext.getRealPath("/perguntas2.xml"))
        taskService.setVariable(params.id, "files", [file, file2])
        redirect uri:"/process/task/resolve/${params.id}"

    }

    def test() {
        new RequestMap(url: '/data/users/admin/851/escolamagica', configAttribute: 'IS_AUTHENTICATED_FULLY').save flush: true
        springSecurityService.clearCachedRequestmaps()
    }

    def publishOptions() {
        def game = Game.get(runtimeService.getVariable(params.processId, 'gameId') as String)
        def platforms = []

        if (game.android) {
            platforms  << "Android"
        }
        if (game.moodle) {
            platforms << "Moodle"
        }
        if (game.linux) {
            platforms << "Linux"
        }
        if (game.web) {
            platforms << "Web"
        }

        render view: "publishOptions", model: [platforms: platforms, processId: params.processId]
    }


}



