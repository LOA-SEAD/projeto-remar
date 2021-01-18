package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import grails.converters.JSON
import br.ufscar.sead.loa.remar.statistics.StatisticFactory
import br.ufscar.sead.loa.remar.statistics.Statistics
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.commons.CommonsMultipartFile
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import static br.ufscar.sead.loa.remar.Util.THRESHOLD

@Secured(['ROLE_ADMIN'])
class ExportedResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def springSecurityService
    def beforeInterceptor = [action: this.&check, only: ['publish', 'myGames', 'publicGames']]

    private check() {
        if (!session.user) {
            log.debug "Logout: session.user is NULL !"
            redirect controller: "logout", action: "index"
            return false
        }
    }

    def save(ExportedResource exportedResourceInstance) {
        // need to improve that
        exportedResourceInstance.owner = User.findById(springSecurityService.getCurrentUser().getId())
        exportedResourceInstance.exportedAt = new Date()
        exportedResourceInstance.type = 'public'
        exportedResourceInstance.addToPlatforms(Platform.findByName("Moodle"))
        exportedResourceInstance.save flush: true
        redirect controller: "ExportedResource", action: "accountConfig", id: exportedResourceInstance.id
    }

    def delete(int id) {
        //Deleta a instância do Exported Resource e o diretório criado também
        ExportedResource instance = ExportedResource.findById(id)
        instance.delete flush: true
        def root = servletContext.getRealPath("/")
        def mainDir = new File(root + '/published/' + instance.processId)
        mainDir.deleteDir()

        redirect uri: '/exported-resource/myGames'
    }

    // to test the moodle list
    def loadMoodleList() {
        def moodleList = Moodle.where {
            active == true
        }.list()
        render(view: '/exportedResource/_moodles', model: [moodleList: moodleList, id: params.local])
    }

    def accountConfig(ExportedResource exportedResource) {
        Moodle m = Moodle.findWhere(id: Long.parseLong("1"))

        render(view: "accountConfig", model: ['exportedResourceInstance': exportedResource]);
    }

    def accountSave() {
        def arr = []
        def exportedResourceId = Long.parseLong(params.find({ it.key == "exportedResourceId" }).value)
        ExportedResource exportedResourceInstance = ExportedResource.findById(exportedResourceId)
        params?.each {
            def name = it.key
            if (name.startsWith("moodlename")) {
                def splitted = name.split("moodlename")
                def id = Long.parseLong(it.value)
                def moo = Moodle.findWhere(id: id)
                def accName = params.find({ it.key == "account" + splitted[1] }).value
                def token = params.find({ it.key == "token" + splitted[1] }).value
                /* check if the account already exists */
                if (account == null) {
                    account = new MoodleAccount()
                    account.accountName = accName
                    account.owner = moo
                    account.token = token
                    account.save flush: true
                }
                exportedResourceInstance.addToAccounts(account)
                exportedResourceInstance.save flush: true
            }
        }
        redirect uri: "/exported-resource/moodle/${exportedResourceInstance.id}"
    }

    def saveStats() {

        log.debug "params: " + params

        StatisticFactory factory = StatisticFactory.instance;
        Statistics statistics = factory.createStatistics(params.gameType as String)

        def data = statistics.getData(params)
        data.userId = session.user.id as long

        log.debug "data: " + data

        try {
            MongoHelper.instance.createCollection("stats")
            MongoHelper.instance.insertStats("stats", data)

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        render status: 200
    }

    def showDamageStats() {
        def lista = MongoHelper.instance.getData("damageStats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showTimeStats() {
        def lista = MongoHelper.instance.getData("timeStats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showStats() {
        def lista = MongoHelper.instance.getData("stats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showRanking() {
        def lista = MongoHelper.instance.getData("ranking")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def savePlayStats() {

        if (GroupExportedResources.findAllByExportedResource(ExportedResource.get(params.exportedResourceId)).size != 0) {
            // Game exportado para um grupo
            def data = [:]
            data.timestamp = new Date().toTimestamp()
            data.userId = session.user.id as long
            data.exportedResourceId = params.exportedResourceId as int

            if (params.damage) {

                data.level = params.level as int
                data.sector = params.sector as int
                data.damage = params.damage as int
                data.gameType = params.gameType
                try {
                    MongoHelper.instance.createCollection("damageStats")
                    MongoHelper.instance.insertDamageStats("damageStats", data)
                } catch (Exception e) {
                    System.err.println(e.getClass().getName() + ": " + e.getMessage());
                }
            } else if (params.time) {

                // TODO: salvar os parâmetros com o tipo correto (int, long, float, etc)
                // OBS: Antes de ser feito, o alfa.remar.online está com dados salvos de maneira errada,
                // tome cuidado para não perder os dados anteriores.

                data.time = params.time
                data.type = params.type
                data.gameId = params.gameId
                if (params.gameLevel)
                    data.gameLevel = params.gameLevel
                if (params.challengeId)
                    data.challengeId = params.challengeId
                data.gameType = params.gameType
                try {
                    MongoHelper.instance.createCollection("timeStats")
                    MongoHelper.instance.insertTimeStats("timeStats", data)
                } catch (Exception e) {
                    System.err.println(e.getClass().getName() + ": " + e.getMessage());
                }
            }
        } else {
            log.debug "Stats skipped. Game was not published to a group."
        }
        render status: 200
    }

    def publish(ExportedResource instance) {
        def exportsTo = [:]
        def handle = [:]
        def groupsIOwn = Group.findAllByOwner(session.user)
        exportsTo.web = instance.resource.web
        exportsTo.desktop = instance.resource.desktop
        exportsTo.android = instance.resource.android
        exportsTo.moodle = instance.resource.moodle
        def groupsIAdmin = UserGroup.findAllByUserAndAdmin(session.user, true).group
        def baseUrl = "/published/${instance.processId}"
        def process = Propeller.instance.getProcessInstanceById(instance.processId as String, session.user.id as long)
        instance.name = process.name
        RequestMap.findOrSaveWhere(url: "${baseUrl}/**", configAttribute: 'permitAll')
        process.completedTasks.each { task ->
            if (task.getVariable('handle') != null) {
                handle.put(task.definition.name, task.getVariable('handle'))
            }
        }
        render view: 'publish', model: [resourceInstance        : instance, exportsTo: exportsTo, baseUrl: baseUrl, groupsIAdmin: groupsIAdmin,
                                        exportedResourceInstance: instance, createdAt: process.createdAt, groupsIOwn: groupsIOwn, handle: handle]
    }

    def export(ExportedResource instance) {
        def urls = [:]
        def root = servletContext.getRealPath("/")
        def resourceURI = instance.resource.uri         // get uri because blank spaces in name
        def desktop = instance.resource.desktop
        def android = instance.resource.android
        def moodle = instance.resource.moodle
        def web = instance.resource.web
        urls.web = "/published/${instance.processId}/web"
        if (desktop) {
            urls.windows = "/published/${instance.processId}/desktop/${resourceURI}-windows.zip"
            urls.linux = "/published/${instance.processId}/desktop/${resourceURI}-linux.zip"
            urls.mac = "/published/${instance.processId}/desktop/${resourceURI}-mac.zip"
        }
        if (android) {
            urls.android = "/published/${instance.processId}/mobile/${resourceURI}-android.zip"
        }
        if (!instance.exported) {
            def sourceFolder = "${root}/data/resources/sources/${instance.resource.uri}/"
            def desktopFolder = "${root}/published/${instance.processId}/desktop"
            def mobileFolder = "${root}/published/${instance.processId}/mobile"
            def webFolder = "${root}/published/${instance.processId}/web"
            def ant = new AntBuilder()
            def process = Propeller.instance.getProcessInstanceById(instance.processId, session.user.id as long)
            def processType = process.definition.type

            def folders = []
            folders << "${desktopFolder}/windows/resources/app"
            folders << "${desktopFolder}/linux/resources/app"
            folders << "${desktopFolder}/mac/${resourceURI}.app/Contents/Resources/app"
            folders << "${mobileFolder}/assets/www"

            ant.sequential {
                mkdir(dir: desktopFolder)
                mkdir(dir: mobileFolder)
                copy(file: "${sourceFolder}/windows.zip", tofile: "${desktopFolder}/windows.zip", failonerror: false)
                copy(file: "${sourceFolder}/linux.zip", tofile: "${desktopFolder}/linux.zip", failonerror: false)
                copy(file: "${sourceFolder}/mac.zip", tofile: "${desktopFolder}/mac.zip", failonerror: false)
                copy(file: "${sourceFolder}/android/${resourceURI}-arm.apk", tofile: "${mobileFolder}/${resourceURI}-arm.apk", failonerror: false)
                copy(file: "${sourceFolder}/android/${resourceURI}-x86.apk", tofile: "${mobileFolder}/${resourceURI}-x86.apk", failonerror: false)
                mkdir(dir: folders[0])
                mkdir(dir: folders[1])
                mkdir(dir: folders[2])
                mkdir(dir: folders[3])
            }

            process.completedTasks.outputs.each { outputs ->
                outputs.each { output ->
                    ant.sequential {
                        copy(
                                file: output.path,
                                tofile: "${folders[0]}/${output.definition.path}/${output.definition.name}",
                        )
                        copy(
                                file: output.path,
                                tofile: "${folders[1]}/${output.definition.path}/${output.definition.name}"
                        )
                        copy(
                                file: output.path,
                                tofile: "${folders[2]}/${output.definition.path}/${output.definition.name}",
                        )
                        copy(
                                file: output.path,
                                tofile: "${folders[3]}/${output.definition.path}/${output.definition.name}",
                        )
                    }
                }
            }

            def builder = new JsonBuilder()
            def remarJson = builder {
                exportedResourceId instance.id
            }
            def jsonName = "remar.json"
            folders.each { folder ->
                File file = new File("$folder/$jsonName")
                PrintWriter pw = new PrintWriter(file)
                pw.write(builder)
                pw.close()
            }
            // Lista de plataformas para as quais o jogo será exportado
            def platformList = []
            if (desktop) platformList.add("desktop")
            if (android) platformList.add("android")
            if (moodle) platformList.add("moodle")
            if (web) platformList.add("web")

            //if ([plataforma]) platformList.add("[plataforma]")
            def params = [
                    /* 0 */ processType,
                    /* 1 */ root,
                    /* 2 */ instance.resource.id,
                    /* 3 */ instance.id,
                    /* 4 */ desktopFolder,
                    /* 5 */ mobileFolder,
                    /* 6 */ webFolder
            ]
            render([platforms: platformList, params: params, urls: urls] as JSON)
            return
        }
        render urls as JSON
    }

    /*
     * Tratamento de publicação do jogo para plataformas Desktop
     */

    def exportDesktop(params) {
        def exp = params.get("params[]");
        def resource = Resource.findById(exp[2])
        def instance = ExportedResource.findById(exp[3])
        def ant = new AntBuilder()
        def processType = exp[0]
        def root = exp[1]
        def desktopFolder = exp[4]
        def scriptUpdateUnity = "${root}/scripts/unity/update.sh"
        def scriptUpdateElectron = "${root}/scripts/electron/update.sh"
        switch (processType) {
            case "unity":
                log.debug "Started Unity Desktop Script"
                ant.sequential {
                    chmod(perm: "+x", file: scriptUpdateUnity)
                    exec(executable: scriptUpdateUnity) {
                        arg(value: root)
                        arg(value: resource.uri)
                        arg(value: instance.processId)
                        arg(value: resource.name)
                    }
                }
                log.debug "Finished exporting Unity Desktop project"
                break
            default /* HTML */:
                log.debug "Started Electron Script"
                ant.sequential {
                    chmod(perm: "+x", file: scriptUpdateElectron)
                    exec(executable: scriptUpdateElectron) {
                        arg(value: desktopFolder)
                        arg(value: resource.uri)
                    }
                }
                log.debug "Finished exporting HTML Desktop project"
                break
        }

        render "OK"
    }
    /*
     * Tratamento de publicação do jogo para Android
     */

    def exportAndroid(params) {
        def exp = params.get("params[]");
        def resource = Resource.findById(exp[2])
        def instance = ExportedResource.findById(exp[3])
        def ant = new AntBuilder()
        def processType = exp[0]
        def root = exp[1]
        def mobileFolder = exp[5]
        def scriptBuildCrosswalk = "${root}/scripts/crosswalk/build.sh"
        def scriptApkTool = "${root}/scripts/apktool/buildapk.sh"

        switch (processType) {
            case "unity":
                log.debug "Started ApkTool Script"
                ant.sequential {
                    chmod(perm: "+x", file: scriptApkTool)
                    exec(executable: scriptApkTool) {
                        arg(value: root)
                        arg(value: resource.uri)
                        arg(value: instance.processId)
                    }
                }
                log.debug "Finished exporting Unity Android project"
                break

            default /* HTML */:
                log.debug "Started Crosswalk Script"
                ant.sequential {
                    chmod(perm: "+x", file: scriptBuildCrosswalk)
                    exec(executable: scriptBuildCrosswalk) {
                        arg(value: root)
                        arg(value: mobileFolder)
                        arg(value: resource.uri)
                        arg(value: instance.name)
                        arg(value: instance.processId)
                    }
                }
                log.debug "Finished exporting HTML Android project"
                break

        }
        render "OK"
    }

    def exportWeb() {
        def exp = params.get("params[]");
        def resource = Resource.findById(exp[2])
        def instance = ExportedResource.findById(exp[3])
        def ant = new AntBuilder()
        def processType = exp[0]
        def root = exp[1]
        def webFolder = exp[5]
        switch (processType) {
            case "unity":
                log.debug "Started Unity Web Script"
                def scriptBuildWeb = "${root}/scripts/unity/buildweb.sh"
                ant.sequential {
                    chmod(perm: "+x", file: scriptBuildWeb)
                    exec(executable: scriptBuildWeb) {
                        arg(value: root)
                        arg(value: resource.uri)
                        arg(value: instance.processId)
                    }
                }
                log.debug "Finished exporting Unity Web project"
                break
            default /* HTML */:
                def jsonPathWeb = "${root}/published/${instance.processId}/web"
                def builder = new JsonBuilder()
                def remarJson = builder {
                    exportedResourceId instance.id
                }
                def jsonName = "remar.json"
                File file = new File("$jsonPathWeb/$jsonName")
                PrintWriter pw = new PrintWriter(file)
                pw.write(builder)
                pw.close()
                instance.exported = true
                instance.save flush: true
                log.debug "Finished exporting HTML Web project"
                break
        }
        render "OK"
    }

    def moodle(ExportedResource exportedResourceInstance) {
        // pega os dados de como será a tabela no moodle
        def file = new File(servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}/bd.json"))
        def inputJson = new JsonSlurper().parseText(file.text)
        // Save the moodleUrl (same as webWurl)
        exportedResourceInstance.moodleUrl = exportedResourceInstance.webUrl
        exportedResourceInstance.save flush: true
        render true
    }

    def update(ExportedResource instance) {
        def path = new File("${servletContext.getRealPath("/published/${instance.processId}")}/")
        if (params.img1 != null && params.img1 != "") {
            def img1 = new File(servletContext.getRealPath("${params.img1}"))
            img1.renameTo(new File(path, "banner.png"))
        }
        def i = ExportedResource.findByName(params.name)
        if (i) {
            if (i == instance) {
                instance.save(flush: true)
                response.status = 200
            } else {
                response.status = 409 // conflited error
            }
        } else {
            log.debug(params.name)
            instance.name = params.name
            instance.save(flush: true)
            response.status = 200
        }
        render ' '
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def publicGames() {
        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : THRESHOLD
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        params.type = "public"
        def pageCount = Math.ceil(ExportedResource.count / params.max) as int
        def publicGamesList = ExportedResource.list(params)
        def currentPage = (params.offset + THRESHOLD) / THRESHOLD

        //Colocando todos os atributos necessários para fazer a paginação/aparecer os cards em "model"
        def model = [:]
        model.publicExportedResourcesList = publicGamesList
        model.totalCount = publicGamesList.totalCount
        model.categories = Category.list(sort:"name")
        model.pageCount = pageCount
        model.currentPage = currentPage
        model.threshold = THRESHOLD

        render view: "publicGames", model: model
    }

    def myGames() {
        def model = [:]
        def myExportedResourcesList
        User user = session.user
        model.myGroups = Group.findAllByOwner(user)
        model.groupsIAdmin = UserGroup.findAllByUserAndAdmin(user,true).group
        def threshold = THRESHOLD
        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        if (session.user.username.equals("admin")) {
            model.myExportedResourcesList = ExportedResource.list(params)
        } else {
            model.myExportedResourcesList = ExportedResource.findAllByTypeAndOwner('public', session.user, params)
        }
        model.max = params.max
        model.threshold = threshold
        model.pageCount = Math.ceil(ExportedResource.findAllByOwner(user).size() / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < ExportedResource.count
        model.hasPreviousPage = params.offset > 0
        model.categories = Category.list(sort: "name")
        render view: "myGames", model: model
    }

    def myProcesses(){
      def model = [:]
      User user = session.user
      def threshold = THRESHOLD
      // Retorna o processo
      params.sort="id"
      params.order="desc"
      params.max = params.max ? Integer.valueOf(params.max) : threshold
      params.offset = params.offset ? Integer.valueOf(params.offset) : 0
      def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)
      def temporary = []
      for (def i = processes.size() - 1; i>= 0; i--) {
          // lista todos os processos que estiver ativo e existir tarefas pendentes
          if (processes.get(i).getVariable('inactive') != "1"
                  && (processes.get(i).getVariable("exportedResourceId") == null)) {

              temporary.add(processes.get(i))
          }
      }
      model.max = params.max
      model.threshold = threshold
      model.processes = temporary
      model.pageCount = Math.ceil(temporary.size() / params.max) as int
      model.currentPage = (params.offset + threshold) / threshold
      model.hasNextPage = params.offset + threshold < temporary.size()
      model.hasPreviousPage = params.offset > 0

      render view:"myProcesses", model: model
    }

    def saveGameInfo() {
        def data = request.JSON
        /* auto generate required data */
        data.user = session.user.id
        def exportedResource = ExportedResource.findByWebUrl(data.moodle_url)
        data.game = exportedResource.id
        data.timestamp = new Date().toTimestamp()
        log.debug "----"
        log.debug data
        log.debug "----"

        def json = JSON.parse(new File(servletContext.getRealPath("/data/resources/sources/${Resource.findById(exportedResource.resourceId).uri}/bd.json")).text)
        MongoHelper.instance.insertData(json['collection_name'] as String, data)
    }

    def _table() {
        if (params.resourceId) {
            def data = MongoHelper.instance.getData("escola_magica", params.resourceId as Integer)
            if (data.first() != null) {
                def userCount = 0
                def users = [:]
                def data3 = [:]
                data.collect {
                    def currentUser = it.user
                    if (users[currentUser] == null) {
                        def userModel = [:]
                        def user = User.get(currentUser)
                        userModel['name'] = user.firstName + " " + user.lastName
                        userModel['hits'] = 0
                        userModel['errors'] = 0
                        userModel['id'] = currentUser
                        userModel['resourceId'] = params.resourceId
                        users[currentUser] = userModel
                    }

                    if (it.resposta == it.respostacerta) {
                        users[currentUser]["hits"]++
                    } else {
                        users[currentUser]['errors']++
                    }
                }
                render view: "_table", model: [users: users]
            } else {
                render "no information found in our records."
            }
        } else {
            render "no information found in our records."
        }
    }

    def _data() {
        def data = MongoHelper.instance.getData("escola_magica", params.exportedResourceId as Integer, params.userId as Integer)
        if (data.first() != null) {
            data.collect {
                println it
            }
            render view: "_data", model: [userId: params.userId, dataCollection: data]
        } else {
            render "no information found in our records."
        }
    }

    @Transactional
    def croppicture() {
        def root = servletContext.getRealPath("/")
        def f = new File("${root}data/tmp")
        f.mkdirs()
        def destination = new File(f, RandomStringUtils.random(50, true, true))
        def photo = params.photo as CommonsMultipartFile
        photo.transferTo(destination)
        def x = Math.round(params.float('x'))
        def y = Math.round(params.float('y'))
        def w = Math.round(params.float('w'))
        def h = Math.round(params.float('h'))
        BufferedImage img = ImageIO.read(destination)
        ImageIO.write(img.getSubimage(x, y, w, h),
                photo.contentType.contains('png') ? 'png' : 'jpg', destination)
        println destination.name
        render destination.name
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def searchGameByCategoryAndName() {
        def model = [:]
        User user = session.user
        model.myGroups = Group.findAllByOwner(user)
        model.groupsIAdmin = UserGroup.findAllByUserAndAdmin(user,true).group
        def threshold = THRESHOLD
        def maxInstances = 0
        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        model.max = params.max
        model.threshold = threshold
        log.debug("category: " + params.category)
        model.publicExportedResourcesList = null
        if (params.category.equals("-1")) {
            // exibe os jogos de todas as categorias

            model.publicExportedResourcesList = ExportedResource.findAllByTypeAndNameIlike('public', "%${params.text}%", params)
            maxInstances = ExportedResource.findAllByTypeAndNameIlike('public', "%${params.text}%").size()
        } else {
            Category c = Category.findById(params.category)
            model.publicExportedResourcesList = []
            maxInstances = 0

            for (r in Resource.findAllByCategory(c)) {
                // get all resources belong
                model.publicExportedResourcesList.addAll(
                        ExportedResource.findAllByTypeAndResourceAndNameIlike('public', r, "%${params.text}%", params))
                maxInstances += ExportedResource.findAllByTypeAndResourceAndNameIlike('public', r, "%${params.text}%").size()
            }
        }
        model.pageCount = Math.ceil(maxInstances / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0
        log.debug(maxInstances)
        render view: "_customizedGameCard", model: model
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def searchProcesses() {
        def model = [:]
        def threshold = THRESHOLD
        def maxInstances = 0
        params.order = "desc"
        params.sort = "id"
        params.tMax = params.tMax ? Integer.valueOf(params.tMax) : threshold
        params.tOffset = params.tOffset ? Integer.valueOf(params.tOffset) : 0
        log.debug("type: " + params.typeSearch)
        log.debug("text: " + params.text)
        model.processes = null
        def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)
        def temporary = []
        for (def i = processes.size() - 1; i >= 0; i--) {
            if (processes.get(i).getVariable('inactive') != "1"
                    && (processes.get(i).getVariable("exportedResourceId") == null)
                    && processes.get(i).name.toLowerCase().contains(params.text.toString().toLowerCase())) {
                temporary.add(processes.get(i))
                maxInstances++
            }
        }
        model.tMax = params.tMax
        model.tThreshold = threshold
        model.processes = temporary
        model.tPageCount = Math.ceil(temporary.size() / params.tMax) as int
        model.tCurrentPage = (params.tOffset + threshold) / threshold
        model.tHasNextPage = params.tOffset + threshold < model.instanceCount
        model.tHasPreviousPage = params.tOffset > 0
        log.debug("amount process: " + model.processes.size())
        render view: "/process/_process", model: model
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def searchMyGames() {
        def model = [:]
        User user = session.user
        model.myGroups = Group.findAllByOwner(user)
        model.groupsIAdmin = UserGroup.findAllByUserAndAdmin(user,true).group
        def threshold = THRESHOLD
        def maxInstances = 0
        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        model.max = params.max
        model.threshold = threshold
        log.debug("category: " + params.category)
        def myExportedResourcesList = null
        if(params.category.equals("-1")){
            // exibe os jogos de todas as categorias
            myExportedResourcesList = ExportedResource.findAllByTypeAndOwnerAndNameIlike('public', user, "%${params.text}%", params)
            maxInstances = ExportedResource.findAllByTypeAndOwnerAndNameIlike('public', user, "%${params.text}%").size()
        } else {
            Category c = Category.findById(params.category)
            myExportedResourcesList = []
            maxInstances = 0
          for (r in Resource.findAllByCategory(c)) {
                // get all resources belong
                myExportedResourcesList.addAll(
                        ExportedResource.findAllByTypeAndResourceAndOwnerAndNameIlike('public', r, user, "%${params.text}%", params))
                maxInstances += ExportedResource.countByTypeAndResourceAndOwnerAndNameIlike('public', r, user, "%${params.text}%")
            }
        }
        model.publicExportedResourcesList = myExportedResourcesList
        model.pageCount = Math.ceil(maxInstances / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0
        log.debug("maxInstances final: "+maxInstances)
        render view: "_customizedGameCard", model:model
    }

    def info(ExportedResource instance) {
        def exportsTo = [:]
        def handle = [:]
        def groupsOwnedByMe = Group.findAllByOwner(session.user)
        exportsTo.desktop = instance.resource.desktop
        exportsTo.android = instance.resource.android
        exportsTo.moodle = instance.resource.moodle
        exportsTo.web = instance.resource.web
        def groupsAdministeredByMe = UserGroup.findAllByUserAndAdmin(session.user, true).group
        def baseUrl = "/published/${instance.processId}"
        def process = Propeller.instance.getProcessInstanceById(instance.processId as String, instance.ownerId as long)
        instance.name = process.name
        RequestMap.findOrSaveWhere(url: "${baseUrl}/**", configAttribute: 'permitAll')
        process.completedTasks.each { task ->
            if (task.getVariable('handle') != null) {
                handle.put(task.definition.name, task.getVariable('handle'))
            }
        }
        render view: 'info', model: [resourceInstance        : instance, exportsTo: exportsTo, baseUrl: baseUrl, groupsIAdmin: groupsAdministeredByMe,
                                     exportedResourceInstance: instance, createdAt: process.createdAt, groupsIOwn: groupsOwnedByMe, handle: handle]
    }

    def reportAbuse() {
        def userIP = request.getRemoteAddr()
        def recaptchaResponse = params.get("g-recaptcha-response")
        def rest = new RestBuilder()
        def resp = rest.get("https://www.google.com/recaptcha/api/siteverify?" +
                "secret=${grailsApplication.config.recaptchaSecret}&response=${recaptchaResponse}&remoteip=${userIP}")
        if (resp.json.success) {
            if (params.exportedResourceId != null) {
                ExportedResource exportedResource = ExportedResource.findById(Integer.parseInt(params.exportedResourceId))
                User user = session.user
                String text = params.text
                def link = "http://${request.serverName}:${request.serverPort}/exported-resource/info/${params.exportedResourceId}"
                Util.sendEmail(
                        "remar@sead.ufscar.br",
                        "Reportando abuso - Remar - ${exportedResource.name}",
                        "<h3>Reportado por: ${user.username} (${user.email}) </h3> <p> Mensagem: ${text} </p> <p> Link para o recurso reportado: ${link}</p>")
                render view: 'confirmSendAbuse'

            }
        }

    }

    // Funções para testar ranqueamento
    def saveScore() {
        def data = [:]
        data.timestamp = new Date().toTimestamp()
        data.userId = session.user.id as long
        data.exportedResourceId = params.exportedResourceId as long
        data.score = params.score

        println "SaveScore : " + data

        try {
            MongoHelper.instance.createCollection("ranking")
            MongoHelper.instance.insertScoreToRanking(data)

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        render status: 200
    }

    def getRanking() {
        def lista = MongoHelper.instance.getRanking(params.exportedResourceId as Long)

        render lista as JSON
    }

    def cardInfos() {
        ExportedResource card = ExportedResource.get(params.id);
        User user = session.user
        def group1 = Group.findAllByOwner(user)
        def group2 = UserGroup.findAllByUserAndAdmin(user, true).group
        render view: "_cardGamesModal", model: [instance: card, myGroups: group1, groupsIAdmin: group2]
    }
}
