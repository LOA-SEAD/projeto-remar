package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonSlurper
import groovyx.net.http.HTTPBuilder
import org.springframework.web.multipart.commons.CommonsMultipartFile

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
        def urls = [:]
        exportsTo.linux = instance.resource.linux
        exportsTo.android = instance.resource.android
        exportsTo.moodle = instance.resource.moodle

        urls.linux = instance.linuxUrl
        urls.android = instance.androidUrl
        urls.moodle = instance.moodleUrl

        def baseUrl = "/published/${instance.processId}"

        RequestMap.findOrSaveWhere(url: "${baseUrl}/**", configAttribute: 'permitAll')

        instance.webUrl = baseUrl + "/web"
        instance.save flush: true

        def moodleExport = false
        if (MoodleAccount.findByOwner(session.user)) {
            moodleExport = true
        }

        render view: 'publish', model: [resourceInstance: instance, exportsTo: exportsTo, urls: urls, baseUrl: baseUrl, moodleExport: moodleExport]
    }

    def web(ExportedResource exportedResourceInstance) {
        render exportedResourceInstance.webUrl
    }

    def android(ExportedResource instance) {
        def root = servletContext.getRealPath("/")
        root = root.substring(0, root.length() -1)

        def dir = servletContext.getRealPath("/published/${instance.processId}/android")
        def resourceDir = servletContext.getRealPath("/data/resources/sources/${instance.resource.uri}")
        def ant = new AntBuilder()
        ant.sequential {
            mkdir(dir: dir + '/tmp')
            mkdir(dir: dir + '/apk')
            copy(todir: dir + '/tmp') {
                fileset dir: dir + "/../web"
            }
            copy(file: resourceDir + "/android/manifest.json", tofile: dir + '/tmp/manifest.json')
            chmod(file: "${root}/scripts/publish_android.sh", perm: "+x")
            exec(executable: "${root}/scripts/publish_android.sh") {
                arg(value: root)
                arg(value: "br.ufscar.sead.loa.${instance.resource.uri}")
                arg(value: dir + '/tmp/manifest.json')
                arg(value: dir)
            }
            move(file: "${dir}/apks.zip",
                    tofile: "${dir}/../android.zip")
            delete(dir: dir)
        }

        ExportedResource.withNewSession {
            instance = ExportedResource.get(instance.id)
            instance.androidUrl = "/published/${instance.processId}/android.zip"
            instance.save flush: true
        }

        render instance.androidUrl
    }

    def linux(ExportedResource instance) {
        def root = servletContext.getRealPath("/")
        root = root.substring(0, root.length() -1)

        def dir = servletContext.getRealPath("/published/${instance.processId}/linux")
        def resourceDir = servletContext.getRealPath("/data/resources/sources/${instance.resource.uri}")
        def ant = new AntBuilder()
        ant.sequential {
            mkdir(dir: dir + '/tmp')
            mkdir(dir: dir + '/bin')
            mkdir(dir: dir + '/tmp/Resources')
            copy(todir: dir +  "/tmp/Resources") {
                fileset dir: dir + "/../web"
            }
            copy(file: resourceDir + "/linux/manifest", tofile: dir + '/tmp/manifest')
            copy(file: resourceDir + "/linux/tiapp.xml", tofile: dir + '/tmp/tiapp.xml')
            chmod(file: "${root}/scripts/publish_linux.sh", perm: "+x")
            exec(executable: "${root}/scripts/publish_linux.sh") {
                arg(value: root)
                arg(value: dir + '/tmp')
                arg(value: dir + '/bin')
            }
            move(file: "${dir}/bin/resource.zip",
                    tofile: "${dir}/../linux.zip")
            delete(dir: dir)
        }

        instance.linuxUrl = "/published/${instance.processId}/linux.zip"
        instance.save flush: true

        render instance.linuxUrl
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
        def destination = new File("${servletContext.getRealPath("/published/${instance.processId}")}/banner.png")

        def photo = params.banner as CommonsMultipartFile
        if (photo != null && !photo.isEmpty()) {
            photo.transferTo(destination)
        }

        def i = ExportedResource.findByName(params.name)
        if(i) {
            if(i == instance) {
//                instance.name = params.name
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

        render instance.webUrl
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def publicGames(){
        def model = [:]

        def threshold = 8

        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold
        model.publicExportedResourcesList = ExportedResource.findAllByType('public', params)
        model.pageCount = Math.ceil(ExportedResource.count / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        model.categories = Category.list(sort:"name")

        println model.pageCount

        render view: "publicGames", model: model
    }

    def myGames(){
        def model = [:]

        model.myExportedResourcesList = ExportedResource.findAllByTypeAndOwner('public', User.get(session.user.id))
        model.categories = Category.list(sort:"name")

        render view: "myGames", model: model
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

    def stats() {
        def myMoodleGames = []

        ExportedResource.findAllByOwnerAndMoodleUrlIsNotNull(session.user).each { exportedResource ->
            def model = [:]

            model.name = exportedResource.name
            model.image = "${exportedResource.processId}/banner.png"

            myMoodleGames.add(model)
        }

        println myMoodleGames

        render view: "stats", model: [moodleList: myMoodleGames]
    }
}
