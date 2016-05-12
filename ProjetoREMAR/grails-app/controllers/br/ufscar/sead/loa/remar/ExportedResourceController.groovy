package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import groovy.json.JsonSlurper
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.commons.CommonsMultipartFile

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

@Secured(['ROLE_ADMIN'])
class ExportedResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def springSecurityService

    def save(ExportedResource exportedResourceInstance) {
        /*if (exportedResourceInstance.hasErrors()) {
            log.debug("Someone tried to register a new moodlegame but it doesn't worked:")
            log.debug(exportedResourceInstance.errors)
        }
        else {
            log.debug exportedResourceInstance as JSON
            //moodlegame.save flush:true
            //redirect controller: "MoodleGame", action: "accountPublishConfig", id: moodlegame.id
        }*/

        //need to improve that
        exportedResourceInstance.owner = User.findById(springSecurityService.getCurrentUser().getId())
        exportedResourceInstance.exportedAt = new Date()
        exportedResourceInstance.type = 'public'
        exportedResourceInstance.addToPlatforms(Platform.findByName("Moodle"))

        exportedResourceInstance.save flush:true
        redirect controller: "ExportedResource", action: "accountConfig", id: exportedResourceInstance.id
    }

    def delete(ExportedResource instance) {
        instance.delete flush: true
        redirect uri: "/"
    }

    /* to test the moodle list */
    def loadMoodleList() {
        def moodleList = Moodle.where {
            active == true
        }.list()
        render(view: '/exportedResource/_moodles', model: [moodleList: moodleList, id: params.local])
    }

    def accountConfig(ExportedResource exportedResource) {
        Moodle m = Moodle.findWhere(id: Long.parseLong("1"))

        render(view:"accountConfig", model:['exportedResourceInstance': exportedResource]);
    }

    def accountSave() {
        def arr = []

        def exportedResourceId = Long.parseLong(params.find({it.key == "exportedResourceId"}).value)

        ExportedResource exportedResourceInstance = ExportedResource.findById(exportedResourceId)

        params?.each{
            def name = it.key
            if (name.startsWith("moodlename")) {
                def splitted = name.split("moodlename")
                def id = Long.parseLong(it.value)
                def moo = Moodle.findWhere(id: id)

                def accName = params.find({it.key == "account"+splitted[1]}).value
                def token = params.find({it.key == "token"+splitted[1]}).value

                //def account = MoodleAccount.find({accountName == accName && owner.domain == moo.domain})

                /* check if the account already exists */
                if (account == null) {
                    account = new MoodleAccount()
                    account.accountName = accName
                    account.owner = moo
                    account.token = token
                    account.save flush:true
                }

                exportedResourceInstance.addToAccounts(account)
                exportedResourceInstance.save flush:true
            }
        }

        redirect uri: "/exported-resource/moodle/${exportedResourceInstance.id}"
    }

    def publish(ExportedResource instance) {
        def exportsTo = [:]
        exportsTo.desktop = instance.resource.desktop
        exportsTo.android = instance.resource.android
        exportsTo.moodle = instance.resource.moodle

        def baseUrl = "/published/${instance.processId}"
        def process = Propeller.instance.getProcessInstanceById(instance.processId as String, session.user.id as long)

        instance.name = process.name

        RequestMap.findOrSaveWhere(url: "${baseUrl}/**", configAttribute: 'permitAll')

        render view: 'publish', model: [resourceInstance: instance, exportsTo: exportsTo, baseUrl: baseUrl,
                                            exportedResourceInstance: instance,createdAt: process.createdAt]
    }

    def export(ExportedResource instance) {
        def urls = [:]
        def resourceName = instance.resource.name
        def desktop = instance.resource.desktop
        def android = instance.resource.android

        urls.web = "/published/${instance.processId}/web"
        if (desktop) {
            urls.windows = "/published/${instance.processId}/desktop/${resourceName}-windows.zip"
            urls.linux = "/published/${instance.processId}/desktop/${resourceName}-linux.zip"
            urls.mac = "/published/${instance.processId}/desktop/${resourceName}-mac.zip"
        }
        if (android) {
            urls.android = "/published/${instance.processId}/mobile/${resourceName}-android.zip"
        }

        if (!instance.exported) {
            def root = servletContext.getRealPath("/")
            def sourceFolder = "${root}/data/resources/sources/${instance.resource.uri}/"
            def desktopFolder = "${root}/published/${instance.processId}/desktop"
            def mobileFolder = "${root}/published/${instance.processId}/mobile"
            def ant = new AntBuilder()
            def process = Propeller.instance.getProcessInstanceById(instance.processId, session.user.id as long)
            def folders = []
            def scriptUpdateElectron = "${root}/scripts/electron/update.sh"
            def scriptUpdateCrosswalk = "${root}/scripts/crosswalk/update.sh"

            folders << "${desktopFolder}/windows/resources/app"
            folders << "${desktopFolder}/linux/resources/app"
            folders << "${desktopFolder}/mac/${resourceName}.app/Contents/Resources/app"
            folders << "${mobileFolder}/assets/www"

            ant.sequential {
                mkdir(dir: desktopFolder)
                mkdir(dir: mobileFolder)
                copy(file: "${sourceFolder}/windows.zip", tofile: "${desktopFolder}/windows.zip", failonerror: false)
                copy(file: "${sourceFolder}/linux.zip", tofile: "${desktopFolder}/linux.zip", failonerror: false)
                copy(file: "${sourceFolder}/mac.zip", tofile: "${desktopFolder}/mac.zip", failonerror: false)
                copy(file: "${sourceFolder}/android/${resourceName}-arm.apk", tofile: "${mobileFolder}/${resourceName}-arm.apk", failonerror: false)
                copy(file: "${sourceFolder}/android/${resourceName}-x86.apk", tofile: "${mobileFolder}/${resourceName}-x86.apk", failonerror: false)

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
            if (desktop) {
                ant.sequential {
                    chmod(perm: "+x", file: scriptUpdateElectron)
                    exec(executable: scriptUpdateElectron) {
                        arg(value: desktopFolder)
                        arg(value: resourceName)
                    }
                }
            }

            if (android) {
                ant.sequential {
                    chmod(perm: "+x", file: scriptUpdateCrosswalk)
                    exec(executable: scriptUpdateCrosswalk) {
                        arg(value: root)
                        arg(value: mobileFolder)
                        arg(value: resourceName)
                    }
                }
            }


            if (instance.resource.moodle) {
                instance.moodleUrl = urls.web
            }

            instance.exported = true
            instance.save flush: true

        }

        render urls as JSON
    }

    def moodle(ExportedResource exportedResourceInstance) {

        //pega os dados de como será a tabela no moodle
        def file = new File(servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}/bd.json"))
        def inputJson = new JsonSlurper().parseText(file.text)

        //Save the moodleUrl (same as webWurl)
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
        if(i) {
            if(i == instance) {
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


        //TODO faltou gerar o jogo para as plataformas com o novo nome e a "nova foto"

        render ' '
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def publicGames(){
        def model = [:]

        def threshold = 12

        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold
        params.order = "desc"
        params.sort = "id"
        model.publicExportedResourcesList = ExportedResource.findAllByType('public', params)
        model.pageCount = Math.ceil(ExportedResource.count / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        model.categories = Category.list(sort:"name")

        println model.pageCount

//        println("lista de exp-resource");
//        model.publicExportedResourcesList.each{
//            println("id: ${it.id}");
//        }


        render view: "publicGames", model: model
    }

    def myGames(){
        def model = [:]

        def threshold = 12

        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold
        params.order = "desc"
        params.sort = "id"

        //retorna os jogos do usuario corrente exportados exportados
        model.myExportedResourcesList = ExportedResource.findAllByTypeAndOwner('public', User.get(session.user.id),params)

        model.pageCount = Math.ceil(ExportedResource.count / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        model.categories = Category.list(sort:"name")

        println model.pageCount


        //retorna o processo
        def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)
        def temporary = []

        for(def i = processes.size()-1;i>=0;i--){
            if (processes.get(i).getVariable('inactive') != "1") {
                temporary.add(processes.get(i))
            }
        }
        model.processes =  temporary

        render view: "myGames", model: model
    }

    def saveGameInfo() {
        def data = request.JSON

        /* auto generate required data */
        data.user = session.user.id
        def exportedResource = ExportedResource.findByMoodleUrl(data.moodle_url)
        data.game = exportedResource.id
        data.timestamp = new Date().toTimestamp()

        log.debug "----"
        log.debug data
        log.debug "----"

        def json = JSON.parse(new File(servletContext.getRealPath("/data/resources/sources/${Resource.findById(exportedResource.resourceId).uri}/bd.json")).text)
        MongoHelper.instance.insertData(json['collection_name'] as String, data)
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
    def searchGame(){
        def model = [:]

        def threshold = 12
        def maxInstances = 0

        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold

        log.debug("type: " + params.typeSearch)
        log.debug("text: " +params.text)

        model.publicExportedResourcesList = null

        if(params.typeSearch.equals("name")){ //busca pelo nome
            model.publicExportedResourcesList = ExportedResource.findAllByTypeAndNameIlike('public', "%${params.text}%",params)
            maxInstances = ExportedResource.findAllByTypeAndNameIlike('public', "%${params.text}%").size()

        }else{
            if(params.typeSearch.equals("category")){                 //busca pela categoria

                if(params.text.equals("-1")){// exibe os jogos de todas as categorias
                    model.publicExportedResourcesList = ExportedResource.findAllByType('public', params)
                    maxInstances = ExportedResource.findAllByType('public').size()

                }else{
                    Category c = Category.findById(params.text)
                    Resource r = Resource.findByCategory(c)
                    model.publicExportedResourcesList = ExportedResource.findAllByTypeAndResource('public',r, params)
                    maxInstances = ExportedResource.findAllByTypeAndResource('public',r).size()
                }
            }
        }

        model.pageCount = Math.ceil(maxInstances / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        log.debug(model.publicExportedResourcesList.size())

        render view: "_cardGames", model: model
    }
}
