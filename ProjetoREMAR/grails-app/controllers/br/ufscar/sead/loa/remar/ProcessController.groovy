package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.propeller.domain.ProcessInstance
import br.ufscar.sead.loa.propeller.domain.TaskInstance

class ProcessController {
    def start() {
        def process
        params.uri = params.id
        def logMsg = "pi-${session.user.username}"
        log.debug "${logMsg} STARTED; uri: ${params.uri}"

        process = Propeller.instance.instantiate(params.uri, session.user.id)

        if (process == Propeller.Errors.PROCESS_NOT_FOUND) {
            log.debug "${logMsg} ENDED; process with uri '${params.uri}' not found"
            render 404
            return response.status = 404
        } else {
            process = process as ProcessInstance
        }

        def resource = Resource.findByUri(params.uri)

        process.putVariable("resourceId", resource.id as String, true)

        redirect uri: "/process/overview/${process.id}"
        log.debug "${logMsg} ENDED; success – redirecting to overview"
    }

    def delete() {
        def process

        if (!params.id) {
            render 400
            return response.status = 400
        }

        try {
            process = Propeller.instance.getProcessInstanceById(params.id, session.user.id)
        } catch (IllegalArgumentException ignored) {
            render 400
            return response.status = 400
        }

        if (!process) {
            render 404
            return response.status = 404
        }

        process.putVariable('inactive', "1", true) // TEMPORARY

        redirect uri: '/process/list' // TEMPORARY
    }

    // Can be called with resource id or name
    def deploy(Resource resource) {
        def file
        def logMsg = "pd-${session.user.username}"
        log.debug "${logMsg} STARTED; id/uri: ${params.id}"

        if (!resource) {
            resource = Resource.findByUri(params.id)

            if (!resource) {
                render 404
                log.debug "${logMsg} ENDED: resource not found either by id or uri"
                return response.status = 404
            }
        }

        file = new File("${servletContext.getRealPath('propeller')}/${resource.uri}/process.json")

        if (!file.exists()) {
            render 404
            log.debug "${logMsg} ENDED: propeller/${resource.uri}/process.json not found"
            return response.status = 404
        }

        def process = Propeller.instance.deploy(file, resource.owner.id)

        if (process.deployed) {
            log.debug "${logMsg} ENDED: success – 201"
            response.status = 201
            render 201
        } else {
            log.debug "${logMsg} ENDED: error – 409: a process with '${resource.uri}' as uri already exists"
            response.status = 409
            render 409
        }
    }

    def undeploy(Resource resource) {
        if (!resource) {
            resource = Resource.findByUri(params.id)

            if (!resource) {
                render 404
                return response.status = 404
            }
        }

        Propeller.instance.undeploy(resource.uri)

        render 205
        response.status = 205
    }

    def overview() {
        def process
        try {
            process = Propeller.instance.getProcessInstanceById(params.id as String, session.user.id as long)
        } catch (IllegalArgumentException ignored) { // invalid processId
            render 400
            return response.status = 400
        }

        if (!process) { // process not found or session.user != process.owner
            render 404
            return response.status = 404
        }

        render view: "overview", model: [process: process]
    }

    def list() {
        def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)
        def temporary = []

        for (process in processes) {
            if (process.getVariable('inactive') != "1") {
                temporary.add(process)
            }
        }

        render(view: "list", model: [processes: temporary])
    }

    def finishedProcess() {
        log.debug Resource.findByWeb(true)
        def webVersion = Resource.findByWeb(true)
        render(view: "finishedProcess", model: [web: webVersion])
    }

    def completeTask() {
        def task

        try {
            task = Propeller.instance.getTaskInstance(params.taskId as String, session.user.id as long)
        } catch (IllegalArgumentException ignored) { // invalid taskId
            render 404
            return response.status = 404
        }

        if (!task) { // task not found or task.process.owner != session.user
            render 404
            return response.status = 404
        }

        if (task.status != TaskInstance.STATUS_PENDING) {
            render 400
            return response.status = 400
        }

        def paths = MongoHelper.instance.getFilePaths(params.files)

        if (task.complete(paths)) {
            if (task.process.status == ProcessInstance.STATUS_ALL_TASKS_COMPLETED) {
                finish(task.process)
            } else {
                redirect uri: "/process/overview/${task.process.id}?toast=1"
            }

        } else {
            render "500 – ${params.taskId}"
            response.status = 500
        }
    }

    private void finish(ProcessInstance process) {
        def resource = Resource.get(process.getVariable('resourceId'))
        def now = new Date()
        def exportedResourceInstance = new ExportedResource()
        def instanceFolder = servletContext.getRealPath("/published/${process.id}")
        def ant = new AntBuilder()

        exportedResourceInstance.owner = session.user
        exportedResourceInstance.resource = resource
        exportedResourceInstance.exportedAt = now
        exportedResourceInstance.type = 'public' // TODO
        exportedResourceInstance.name = resource.name
        exportedResourceInstance.width = resource.width
        exportedResourceInstance.height = resource.height
        exportedResourceInstance.processId = process.id
        exportedResourceInstance.save flush: true

        process.putVariable('exportedResourceId', exportedResourceInstance.id as String, true)

        if (exportedResourceInstance.hasErrors()) {
            render exportedResourceInstance.errors
            return
        }

        ant.copy(todir: "${instanceFolder}/web") {
            fileset(dir: servletContext.getRealPath("/data/resources/sources/${resource.uri}/base"))
        }

        ant.copy(file: "${servletContext.getRealPath("/images")}/" +
                "${exportedResourceInstance.resource.uri}-banner.png",
                tofile: "${instanceFolder}/banner.png", overwrite: true)

        process.completedTasks.outputs.each { outputs ->
            outputs.each { output ->
                println output.path
                ant.copy(
                        file: output.path,
                        tofile: "${instanceFolder}/web/${output.definition.path}/${output.definition.name}",
                        overwrite: true
                )
            }
        }

        redirect uri: "/exported-resource/publish/${exportedResourceInstance.id}"
    }
}