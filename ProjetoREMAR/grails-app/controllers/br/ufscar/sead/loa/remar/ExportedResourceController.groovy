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

    def publish(ExportedResource exportedResourceInstance) {
        def resource = exportedResourceInstance.resource
        def platforms = []

        if(exportedResourceInstance.webUrl) {
            platforms << 'Web:' +  exportedResourceInstance.webUrl
        } else if(resource.web) {
            platforms << 'Web'
        }
        if(exportedResourceInstance.androidUrl) {
            platforms << 'Android:' +  exportedResourceInstance.androidUrl
        } else if(resource.android) {
            platforms << 'Android'
        }
        if(exportedResourceInstance.linuxUrl) {
            platforms << 'Linux:' +  exportedResourceInstance.linuxUrl
        } else if(resource.linux) {
            platforms << 'Linux'
        }
        if(exportedResourceInstance.moodleUrl) {
            platforms << 'Moodle:' +  exportedResourceInstance.moodleUrl
        } else if(resource.moodle) {
            platforms << 'Moodle'
        }

        def time = exportedResourceInstance.exportedAt.getTime() as String
        def url = "/published/${time.substring(0, time.length() - 4)}"
        log.debug "Url: " + url

        new RequestMap(url: url + '/**', configAttribute: 'permitAll').save flush: true
        springSecurityService.clearCachedRequestmaps()

        exportedResourceInstance.webUrl = url + "/web"
        platforms[0] = "Web:"+ exportedResourceInstance.webUrl
        exportedResourceInstance.save flush: true

        render view:'publish', model: [resourceName: exportedResourceInstance.name, resourceId: exportedResourceInstance.id,
                                       platforms: platforms, resourceUri: exportedResourceInstance.resource.uri, resourceInstanceUrl: url ]
    }

    def web(ExportedResource exportedResourceInstance) {
        render exportedResourceInstance.webUrl
    }

    def android(ExportedResource exportedResourceInstance) {
        def root = servletContext.getRealPath("/")
        root = root.substring(0, root.length() -1)

        def time = exportedResourceInstance.exportedAt.getTime() as String
        def dir = servletContext.getRealPath("/published/${time.substring(0, time.length() - 4)}/android")
        def resourceDir = servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}")
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
                arg(value: "br.ufscar.sead.loa.${exportedResourceInstance.resource.uri}")
                arg(value: dir + '/tmp/manifest.json')
                arg(value: dir)
            }
        }

        exportedResourceInstance.androidUrl = "/published/${time.substring(0, time.length() - 4)}/android/apks.zip"
        exportedResourceInstance.save flush: true

        render exportedResourceInstance.androidUrl
    }

    def linux(ExportedResource exportedResourceInstance) {
        def root = servletContext.getRealPath("/")
        root = root.substring(0, root.length() -1)

        def time = exportedResourceInstance.exportedAt.getTime() as String
        def dir = servletContext.getRealPath("/published/${time.substring(0, time.length() - 4)}/linux")
        def resourceDir = servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}")
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
        }

        exportedResourceInstance.linuxUrl = "/published/${time.substring(0, time.length() - 4)}/linux/bin/resource.zip"
        exportedResourceInstance.save flush: true

        render exportedResourceInstance.linuxUrl
    }

    def moodle(ExportedResource exportedResourceInstance) {

        //pega os dados de como será a tabela no moodle
        def file = new File(servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}/bd.json"))
        def inputJson = new JsonSlurper().parseText(file.text)

        //Save the moodleUrl (same as webWurl)
        exportedResourceInstance.moodleUrl = exportedResourceInstance.webUrl
        exportedResourceInstance.save flush: true

        render "Vá ao moodle e adicione seu jogo como atividade"
    }

    def update(ExportedResource instance) {
        def time = instance.exportedAt.getTime() as String
        def destination = new File("${servletContext.getRealPath("/published/${time.substring(0, time.length() - 4)}")}/banner.png")
//        log.debug(params)
        def photo = params.banner as CommonsMultipartFile
        if (photo != null && !photo.isEmpty()) {
            photo.transferTo(destination)
        } else {
            log.debug "gfhghgc"
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

        println model.pageCount

        render view: "publicGames", model: model
    }

    def myGames(){
        def model = [:]

        model.myExportedResourcesList = ExportedResource.findAllByTypeAndOwner('public', User.get(session.user.id))

        render view: "myGames", model: model
    }

    def saveGameInfo() {
        log.debug "lol"
        log.debug params

        def gameData
        gameData.user = session.user.id
        gameData.game = params.remar_resource_id
        gameData.timestamp = new Date().toTimestamp()
        log.debug "----"
        log.debug gameData
    }
}
