package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.mail.MailService
import grails.plugin.springsecurity.SpringSecurityUtils
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
    TaskService taskService
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

        if(!Resource.findByBpmn(params.id)) {
            response.status = 404
            render 'The process ' + params.id + ' doesn\'t exists!'
            return
        }

        session.user = springSecurityService.getCurrentUser()

        def resource = Resource.findByBpmn(params.id)

        runtimeService.setVariable(processId, "ownerId", session.user.id as String)
        runtimeService.setVariable(processId, "ownerName", session.user.name as String)
        runtimeService.setVariable(processId, "resourceId", resource.id as String)
        runtimeService.setVariable(processId, "resourceName", resource.name as String)
        runtimeService.setVariable(processId, "resourceUri", resource.uri as String)
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

    def delete() {
        runtimeService.deleteProcessInstance(params.id, "")
        redirect action: "userProcesses"
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


        render "success"


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

        def uri = runtimeService.getVariable(params.processId, "resourceUri")

        for (task in tasks) {
            task.taskDefinitionKey = "${task.taskDefinitionKey.replace('.', '/')}?p=${task.processInstanceId}&t=${task.id}"
        }

        if (tasks.size() == 0) {
            render(view:'finishedProcess')
        } else {
            respond "", model: [allusers: allUsers, alltasks: tasks, uri: uri, processId: params.processId, currentUser: session.user]
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
                formattedProcesses[0] = runtimeService.getVariable(processes.id, "resourceName")
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
            formattedTask[0] = runtimeService.getVariable(task.processInstanceId, 'resourceName')
            formattedTask[1] = task.getName()
            formattedTask[2] = runtimeService.getVariable(task.processInstanceId, 'ownerName')
            formattedTask[3] = '/' + runtimeService.getVariable(task.processInstanceId, 'resourceUri')
            formattedTask[3] += "/${task.taskDefinitionKey.replace('.', '/')}?p=${task.processInstanceId}&t=${task.id}"
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
        println Resource.findByWeb(true)
        def webVersion = Resource.findByWeb(true)
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
                    if(!session.processFinished) {
                        redirect uri: "/process/tasks/overview/${task.processInstanceId}"
                    } else {
                        session.processFinished = null
                    }

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
        def json
        try {
            json = JSON.parse(new File(params.json).text)
        } catch (Exception ignored) {
            json = JSON.parse("{files:[]}")
        }

        println json
        def task = taskService.createTaskQuery().taskId(params.taskId).singleResult()
        if (task) {
            if (task.delegationState == DelegationState.PENDING) {
                if (task.assignee == session.user.username) {
                    def destination = servletContext.getRealPath("/data/users/${task.owner}/${task.processInstanceId}")
                    json.files.each { file ->
                        file = file as String
                        println file
                        def fileName =  file.substring(file.lastIndexOf('/') + 1, file.length())
                        new AntBuilder().copy(file: file, tofile: destination + "/" + fileName)
                    }
                    taskService.resolveTask(params.taskId)
                    if (task.owner == session.user.username) {
                        redirect uri: "/process/tasks/overview/${task.processInstanceId}"
                    } else {
                        redirect uri: '/process/pendingTasks'
                    }
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
        }
    }

    @Override
    void execute(DelegateExecution delegateExecution) throws Exception {
        if (delegateExecution.currentActivityId == 'resource_reuse') {
            def resource = Resource.get(runtimeService.getVariable(delegateExecution.processInstanceId, 'resourceId') as String)
            def ownerUsername = runtimeService.getVariable(delegateExecution.processInstanceId, 'ownerUsername') as String

            def exportedResourceInstance = new ExportedResource()
            exportedResourceInstance.owner = br.ufscar.sead.loa.remar.User.get(runtimeService.getVariable(delegateExecution.processInstanceId, 'ownerId') as int)
            exportedResourceInstance.resource = resource
            exportedResourceInstance.exportedAt = new Date()
            exportedResourceInstance.type = 'public' // TODO
            exportedResourceInstance.image = resource.uri + '-banner.png'
            exportedResourceInstance.name = resource.name
            exportedResourceInstance.width = resource.width
            exportedResourceInstance.height = resource.height
            exportedResourceInstance.save flush:true

            def resourceFolder = new File(servletContext.getRealPath("/data/users/${ownerUsername}/${delegateExecution.processInstanceId}"))
            def instanceFolder = new File(servletContext.getRealPath("/published/${exportedResourceInstance.id}"))
            def json = JSON.parse(Resource.get(runtimeService.getVariable(delegateExecution.processInstanceId, 'resourceId') as String).files)
            println json

            new AntBuilder().copy(todir: "${instanceFolder}/web") {
                fileset(dir: servletContext.getRealPath("/data/resources/sources/${resource.uri}/base"))
            }
            println "^~^"

            json.each {file, destinationFolder ->
                new AntBuilder().copy(file: "${resourceFolder}/${file}", tofile: "${instanceFolder}/web/${destinationFolder}/${file}", overwrite: true)
                println "each"
            }

            session.processFinished = true
            redirect uri:"/exported-resource/publish/${exportedResourceInstance.id}"
        }
    }


    def abc() {
        render "euaheuahea!!!!!!!!"
    }

    @Deprecated
    def publishGame() {
        ExportedResource newResource = new ExportedResource()
        newResource.owner = br.ufscar.sead.loa.remar.User.findById(springSecurityService.getCurrentUser().getId())
        newResource.exportedAt = new Date()
        newResource.type = 'public'
        newResource.image = params.resourceImage
        newResource.name = params.resourceName
        println params.resourceWidth.toInteger()
        newResource.width = params.int('resourceWidth')
        newResource.height = params.int('resourceHeight')

        if(params.Web) {
            def ownerUsername = runtimeService.getVariable(params.processId, 'ownerUsername') as String
            def resource = Resource.get(runtimeService.getVariable(params.processId, 'resourceId') as String)
            def instanceFolder = servletContext.getRealPath("/data/users/${ownerUsername}/${params.processId}")
            newResource.webUrl = "${instanceFolder}/${resource.uri}"  //Need some tests!
            newResource.addToPlatforms(Platform.findByName("Web"))
        }
        if(params.Linux) {
            newResource.linuxUrl = "linuxUrl"
            newResource.addToPlatforms(Platform.findByName("Linux"))
        }
        if(params.Moodle) {
            newResource.moodleUrl = "moodleUrl"
            newResource.addToPlatforms(Platform.findByName("Moodle"))
        }
        if(params.Android) {
            newResource.androidUrl = "androidUrl"
            newResource.addToPlatforms(Platform.findByName("Android"))
        }

        newResource.save flush:true

        if(params.Moodle) {
            redirect controller: "ExportedGame", action: "accountConfig", id: newResource.id
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


}



