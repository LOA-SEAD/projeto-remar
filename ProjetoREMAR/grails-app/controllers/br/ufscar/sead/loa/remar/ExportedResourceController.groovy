package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonSlurper
import groovyx.net.http.HTTPBuilder

@Secured(['ROLE_ADMIN'])
class ExportedResourceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "GET"]
    def springSecurityService

    def save(ExportedResource exportedResourceInstance) {
        /*if (exportedResourceInstance.hasErrors()) {
            println("Someone tried to register a new moodlegame but it doesn't worked:")
            println(exportedResourceInstance.errors)
        }
        else {
            println exportedResourceInstance as JSON
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

    def _moodles() {

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

                def account = MoodleAccount.find({accountName == accName && owner.domain == moo.domain})

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

        render view:'publish', model: [resourceName: exportedResourceInstance.name, resourceId: exportedResourceInstance.id,
                                       platforms: platforms]
    }

    def web(ExportedResource exportedResourceInstance) {
        def user = springSecurityService.currentUser as User
        def url = "/published/${exportedResourceInstance.id}/web"
        if (params.type == 'public') {
            new RequestMap(url: url + '/**', configAttribute: 'permitAll').save flush: true
            springSecurityService.clearCachedRequestmaps()
        }

        exportedResourceInstance.webUrl = url
        exportedResourceInstance.save flush: true

        render url
    }

    def android(ExportedResource exportedResourceInstance) {
        def dir = servletContext.getRealPath("/published/${exportedResourceInstance.id}/android")
        def resourceDir = servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}")
        def ant = new AntBuilder()
        ant.sequential {
            mkdir(dir: dir + '/tmp')
            copy(todir: dir + '/tmp') {
                fileset dir: resourceDir + "/base"
            }
            copy(file: resourceDir + "/android/manifest.json", tofile: dir + '/tmp/manifest.json')

        }
    }

    def moodle(ExportedResource exportedResourceInstance) {

        //pega os dados de como será a tabela no moodle
        def file = new File(servletContext.getRealPath("/data/resources/sources/${exportedResourceInstance.resource.uri}/moodle/moodleBD.json"))
        def inputJson = new JsonSlurper().parseText(file.text)

        exportedResourceInstance.moodleTableName = inputJson.table_name

        /*inputJson.structure.each {
            def i = 0
            def field = [:]

            it.value.each {
                field.put(it.key, it.value)
            }

            println field
        }*/


        //criar a tabela dentro do moodle
        def http

        if(Environment.current == Environment.DEVELOPMENT) {
            http = new HTTPBuilder("http://localhost")  //it SHALL be dynamic ******
        }
        else {
            http = new HTTPBuilder("http://${Moodle.list().first()}")  //it SHALL be dynamic ******
        }

        def parameters = [:]
        parameters.table_name = exportedResourceInstance.moodleTableName as String
        parameters.structure = inputJson.structure

        def resp = http.post(path: "/moodle/webservice/rest/server.php",
                query: [wstoken: exportedResourceInstance.accounts.first().token,
                        wsfunction: "mod_remarmoodle_create_table",
                        json: file.text])
        println resp

        /*new AntBuilder().copy(todir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}")) {
            fileset(dir: servletContext.getRealPath("/published/${exportedResourceInstance.id}/moodle"))
        }

        //criar tabela dentro do moodle


        def file = new File(servletContext.getRealPath("/wars/${user.username}/${fileName}/WEB-INF"))

        //criar a tabela dentro do moodle
        //salvar o nome da tabela na classe
        //copiar os arquivos
        //salvar url
        //redirecionar para as outras páginas*/

        println exportedResourceInstance
        //redirect uri: "exported-resource/accountConfig/${exportedResourceInstance.id}"
        println "........"
        render "asdasd!!"
    }
}
