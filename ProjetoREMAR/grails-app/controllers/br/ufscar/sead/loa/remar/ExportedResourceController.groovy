package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.io.support.GrailsIOUtils

@Secured(['ROLE_ADMIN'])
class ExportedResourceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def save(ExportedResource exportedGame) {
        /*if (exportedGame.hasErrors()) {
            println("Someone tried to register a new moodlegame but it doesn't worked:")
            println(exportedGame.errors)
        }
        else {
            println exportedGame as JSON
            //moodlegame.save flush:true
            //redirect controller: "MoodleGame", action: "accountPublishConfig", id: moodlegame.id
        }*/

        //need to improve that
        exportedGame.owner = User.findById(springSecurityService.getCurrentUser().getId())
        exportedGame.exportedAt = new Date()
        exportedGame.type = 'public'
        exportedGame.addToPlatforms(Platform.findByName("Moodle"))

        exportedGame.save flush:true
        redirect controller: "ExportedGame", action: "accountConfig", id: exportedGame.id
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

    def publishOld(ExportedResource exportedGame) {
        def moodleList = Moodle.list()
        respond moodleList, model:[moodleList: moodleList]
    }

    def accountConfig(ExportedResource exportedGame) {
        println "sadas"
        Moodle m = Moodle.findWhere(id: Long.parseLong("1"))

        render(view:"accountConfig", model:['exportedGameInstance': exportedGame]);
    }

    def accountSave() {
        def arr = []

        def exportedGameId = Long.parseLong(params.find({it.key == "exportedGameId"}).value)

        ExportedResource exportedGame = ExportedResource.findById(exportedGameId)

        params?.each{
            def name = it.key
            if (name.startsWith("moodlename")) {
                def splitted = name.split("moodlename")
                def id = Long.parseLong(it.value)
                def moo = Moodle.findWhere(id: id)

                def accName = params.find({it.key == "account"+splitted[1]}).value

                def account = MoodleAccount.find({accountName == accName && owner.domain == moo.domain})

                /* check if the account already exists */
                if (account == null) {
                    account = new MoodleAccount()
                    account.accountName = accName
                    account.owner = moo
                    account.save flush:true
                }

                println account as JSON
                exportedGame.addToAccounts(account)
                exportedGame.save flush:true
            }
        }
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

    def moodle(ExportedResource exportedResourceInstance) {

        //criar a tabela dentro do moodle

        /*new AntBuilder().copy(todir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}")) {
            fileset(dir: servletContext.getRealPath("/published/${exportedResourceInstance.id}/moodle"))
        }

        //criar tabela dentro do moodle
        def http = new HTTPBuilder('http://''@localhost:8080')
        def resp = http.get(path: '/manager/text/deploy',
                query: [path: "/${resourceInstance.uri}",
                        war: servletContext.getRealPath("/wars/${springSecurityService.currentUser.username}/${resourceInstance.uri}.war") ])
        resp = GrailsIOUtils.toString(resp)


        def file = new File(servletContext.getRealPath("/wars/${user.username}/${fileName}/WEB-INF"))

        //criar a tabela dentro do moodle
        //salvar o nome da tabela na classe
        //copiar os arquivos
        //salvar url
        //redirecionar para as outras páginas*/

        //render "asdasd!!"
        println exportedResourceInstance
        redirect uri: "exported-resource/accountConfig/${exportedResourceInstance.id}"
        println "........"
    }
}
