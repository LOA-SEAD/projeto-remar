package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.propeller.domain.ProcessInstance
import br.ufscar.sead.loa.propeller.domain.TaskInstance

class ProcessController {
    def grailsApplication
    def beforeInterceptor = [action: this.&check, only: ['start', 'overview', 'list']]

    private check() {
        if (!session.user) {
            log.debug "Logout: session.user is NULL !"
            redirect controller: "logout", action: "index"
            return false
        }
    }

    def start() {
        def process
        def ant = new AntBuilder()

        //params.uri = params.id
        def logMsg = "pi-${session.user.username}"
        log.debug "${logMsg} STARTED; uri: ${params.uri}"

        process = Propeller.instance.instantiate(params.uri, session.user.id)

        if (process == Propeller.Errors.PROCESS_NOT_FOUND) {
            log.debug "${logMsg} ENDED; process with uri '${params.uri}' not found"
            render 404
            return response.status = 404
        } else {
            process = process as ProcessInstance

            // salva uma imagem para o processo
            def path = new File("${servletContext.getRealPath("/data/processes/${process.id}")}/")
            path.mkdirs()

            ant.copy(file: servletContext.getRealPath("/images/${params.uri}-banner.png"),
                    tofile: "${path}/banner.png", overwrite: true)
        }

        def resource = Resource.findByUri(params.uri)

        process.putVariable("resourceId", resource.id as String, true)
        process.putVariable("tasksSendToDspace", null, true)

        render text: "/process/overview/${process.id}"

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

        redirect uri: '/exported-resource/myProcesses'
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
            //salvar resource_dspace para o resource submetido
            if (grailsApplication.config.dspace.restUrl) { //se existir dspace
                redirect uri: "/dspace/createStructure/${resource.id}"
            } else {
                log.debug "${logMsg} ENDED: success – 201"
                response.status = 201
                render 201
            }
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

        render view: "overview", model: [process: process, tasks: process.completedTasks + process.pendingTasks]
    }


    def update() {

        def process = Propeller.instance.getProcessInstanceById(params.id as String, session.user.id as long)
        def hasOptionalTasks = (process.completedTasks + process.pendingTasks).any { task -> task.definition.optional }
        def path = new File("${servletContext.getRealPath("/data/processes/${process.id}")}/")

        // se a imagem foi atualizada
        if (params.img1 != null && params.img1 != "") {
            def img1 = new File(servletContext.getRealPath("${params.img1}"))
            img1.renameTo(new File(path, "banner.png"))
        }

        response.status = 200

        // Checa jogo publicado com mesmo nome

        def res = ExportedResource.findByNameAndOwner(params.name, session.user)
        if (res) {
            response.status = 409 // conflited error
        } else {

            // Checa jogo em customização com mesmo nome

            boolean ok = true;
            def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)
            for (def i = processes.size() - 1; i >= 0 && ok; i--) {

                def p = processes.get(i)

                // verifica repetição nome: processos ativos e tarefas pendentes

                if ((p.getId().toString() != params.id) && (p.getName().equals(params.name)) &&
                        (p.getVariable('inactive') != "1") && (p.getVariable("exportedResourceId") == null)) {

                    ok = false;
                }
            }

            if (ok) {
                process.name = params.name

                process.putVariable("updated", "true", true)
                process.putVariable("showTasks", "true", true)
                process.putVariable("hasOptionalTasks", "${hasOptionalTasks}", true)

                redirect controller: "process", action: "overview"
            } else {
                response.status = 409 // conflited error
            }
        }
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

            redirect uri: "/process/overview/${task.process.id}?toast=1"

        } else {
            render "500 – ${params.taskId}"
            response.status = 500
        }
    }

    def finish() {
        println(params)
        def process = Propeller.instance.getProcessInstanceById(params.id, session.user.id as long)
        def resource = Resource.get(process.getVariable('resourceId'))

        process.putVariable('contentArea', params.contentArea, true)
        process.putVariable('specificContent', params.specificContent, true)

        if (grailsApplication.config.dspace.restUrl && resource.repository) { //se existir dspace
            redirect uri: "/dspace/overview?id=${params.id}"
        } else {
            publishProcess()
        }
    }


    def publishProcess() {
        def exportsTo = [:]
        log.debug("ID DO PROCESSO --->" + params.id)
        def process = Propeller.instance.getProcessInstanceById(params.id, session.user.id as long)
        log.debug("NOME DO PROCESSO --->" + process.name)
        log.debug(process.getVariable("resourceId"))

        def resource = Resource.get(process.getVariable('resourceId'))
        def now = new Date()
        def exportedResourceInstance = new ExportedResource()
        def instanceFolder = servletContext.getRealPath("/published/${process.id}")
        def ant = new AntBuilder()

        exportedResourceInstance.owner = session.user
        exportedResourceInstance.resource = resource
        exportedResourceInstance.exportedAt = now
        exportedResourceInstance.type = 'public' // TODO
        exportedResourceInstance.name = process.name // o jogo recebe o nome do processo
        exportedResourceInstance.width = resource.width
        exportedResourceInstance.height = resource.height
        exportedResourceInstance.processId = process.id
        exportedResourceInstance.license = resource.license
        exportedResourceInstance.contentArea = process.getVariable('contentArea')
        exportedResourceInstance.specificContent = process.getVariable('specificContent')

        exportedResourceInstance.save flush: true

        process.putVariable('exportedResourceId', exportedResourceInstance.id as String, true)

        if (exportedResourceInstance.hasErrors()) {
            render exportedResourceInstance.errors
            return
        }

        // LEGACY: Jogos feitos em HTML/CSS/JS seguem o seguinte comportamento. Mudar esse código pode
        // quebrar o sistema de exportação posterior. Atualmente, jogos feitos em Unity seguem outro
        // workflow que não precisa da cópia de todos os arquivos de código-fonte para a pasta web
        // do jogo exportado.
        if (process.definition.type == "html") {
            ant.copy(todir: "${instanceFolder}/web") {
                fileset(dir: servletContext.getRealPath("/data/resources/sources/${resource.uri}/base"),
                        excludes: "*.zip")
            }
        }

        def pathImgPrev = servletContext.getRealPath("/data/processes/${process.id}")

        ant.copy(file: pathImgPrev + "/banner.png",
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

        exportsTo.desktop = exportedResourceInstance.resource.desktop
        exportsTo.android = exportedResourceInstance.resource.android
        exportsTo.moodle = exportedResourceInstance.resource.moodle

        redirect uri: "/exported-resource/publish/${exportedResourceInstance.id}?toast=1"
    }
}
