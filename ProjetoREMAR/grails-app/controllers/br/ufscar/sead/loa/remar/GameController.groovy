package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.mail.MailService
import org.springframework.web.multipart.MultipartFile

import java.security.MessageDigest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_DESENVOLVEDOR'])
class GameController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    MailService mailService

    def index(Integer max) {

        if (request.isUserInRole("ROLE_ADMIN")) {
            render view: 'index', model:[gameInstanceList: Game.list(), gameInstanceCount: Game.count()]
        } else {
            render view: 'index', model:[gameInstanceList: Game.findAllByOwner(springSecurityService.currentUser as User), gameInstanceCount: Game.count()]
        }

    }

    @Secured(['ROLE_ADMIN'])
    def edit(Game gameInstance) {
        render view: 'edit', model:[deployInstance: deployInstance]
    }

    def create() {
        respond new Deploy(params)
    }

    @Transactional
    def save(Game gameInstance) { // saves and verifies WAR file
        MultipartFile war = params.war
        def fileName = MessageDigest.getInstance("MD5").digest(war.bytes).encodeHex().toString()
        gameInstance.submittedAt = new Date()
        gameInstance.owner       = springSecurityService.currentUser as User
        gameInstance.status      = "pending"
        gameInstance.valid       = true
//        gameInstance.name        = name TODO

        println war.contentType
//        if (war.contentType != "application/octet-stream") { // file is a WAR?
//            gameInstance.valid = false
//            gameInstance.name = war.originalFilename
//            gameInstance.uri = ""
//            gameInstance.status  = "rejected"
//            gameInstance.comment = war.originalFilename + " isn't a war!"
//            gameInstance.save flush: true
//            redirect action: "index"
//            println "not war"
//            return
//        }


        // move to wars folder
        def file = new File(servletContext.getRealPath("/wars/${session.userId}"), fileName + ".war")
        file.mkdirs()
        war.transferTo(file)

        // unzip

        def unzip = "${servletContext.getRealPath("/scripts")}/unzip.sh ${servletContext.getRealPath("/wars/${session.userId}")} ${fileName}"
        unzip.execute().waitFor()

        file = new File(servletContext.getRealPath("/wars/${session.userId}/${fileName}/manifest.json"))
        if (!file.exists()) { // WAR has a manifest.json?
            gameInstance.valid = false
            gameInstance.name = war.originalFilename
            gameInstance.uri = ""
            gameInstance.status  = "rejected"
            gameInstance.comment = war.originalFilename + " doesn't contain a manifest.json."
            gameInstance.save flush: true
            redirect action: "index"
            println "missng manifest"
            return
        }

        def manifest = JSON.parse(file.getText('UTF-8'))

        // manifest is valid?
        if (manifest.name  == null || manifest.android  == null || manifest.linux  == null || manifest.moodle  == null
            || manifest.bpmn  == null || manifest.uri == null) {
            gameInstance.valid = false
            gameInstance.name = war.originalFilename
            gameInstance.uri = ""
            gameInstance.status  = "rejected"
            gameInstance.comment = war.originalFilename + " doesn't contain a valid manifest.json."
            gameInstance.save flush: true
            redirect action: "index"
            println "invalid manifest"
            return
        }

        gameInstance.name = manifest.name
        gameInstance.uri = manifest.uri

        def cmd = servletContext.getRealPath("/scripts") + "/verify-banner.sh ${servletContext.getRealPath("/wars/${session.userId}")}/${fileName} ${manifest.uri}-banner"
        def foundBanner = cmd.execute().text.toInteger()

        // has banner?
        if (!foundBanner) {
            gameInstance.valid = false
            gameInstance.name = war.originalFilename
            gameInstance.uri = ""
            gameInstance.status  = "rejected"
            gameInstance.comment = "${manifest.uri}-banner.png not found!"
            gameInstance.save flush: true
            redirect action: "index"
            println gameInstance.errors
            return
        }

        // copy banner to /assets

        cmd = servletContext.getRealPath("/scripts") + "/verify-bpmn.sh ${servletContext.getRealPath("/wars/${session.userId}")}/${fileName} ${manifest.bpmn}"
        def foundBpmn = cmd.execute().text.toInteger()

        // has bpmn?
        if (!foundBpmn) {
            gameInstance.valid = false
            gameInstance.name = war.originalFilename
            gameInstance.uri = ""
            gameInstance.status  = "rejected"
            gameInstance.comment = "${manifest.bpmn}.bpmn not found!"
            gameInstance.save flush: true
            redirect action: "index"
            return

        }

        gameInstance.bpmn = manifest.bpmn
        gameInstance.comment = "Awaiting review"

        gameInstance.save flush:true


        if(gameInstance.hasErrors()) {
            println gameInstance.errors
            respond gameInstance.errors, view:"create"
        } else {
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), gameInstance.id])
            redirect action: "index"
        }

    }

    def review() {
        def gameInstance = Game.findById(params.id)
        String status  = params.status
        String comment = params.comment
        println gameInstance.id
        println gameInstance.bpmn
        println status
        println comment


        if(!status) {
            gameInstance.comment = comment
            if(gameInstance.status == "rejected") {
                mailService.sendMail {
                    async true
                    to gameInstance.owner.email
                    subject "REMAR – O seu WAR \"${gameInstance.name}\" foi rejeitado!"
                    html "<h3>O seu WAR \"${gameInstance.name}\" foi rejeitado pois ${comment}</h3> <br> "
                }
            }
        }

        if (status == "approve" && gameInstance.status != "approved") {
            def platforms = Platform.list() // TODO: logic to select platforms

            gameInstance.status  = "approved"
            gameInstance.active = true
            gameInstance.version = 0
            gameInstance.addToPlatforms(platforms[0])
            gameInstance.addToPlatforms(platforms[1])
            gameInstance.addToPlatforms(platforms[2])
            gameInstance.addToPlatforms(platforms[3])

            gameInstance.save flush: true



            mailService.sendMail {
                async true
                to gameInstance.owner.email
                subject "REMAR – O seu WAR \"${gameInstance.name}\" foi aprovado!"
                html '<h3>O seu WAR \"${gameInstance.name}\" foi aprovado! :)</h3> <br>'
            }

            redirect controller: "process", action: "deploy", id: gameInstance.bpmn
        } else if (status == "reject" && gameInstance.status != "rejected") {
            gameInstance.status  = "rejected"

            redirect controller: "process", action: "undeploy", id: gameInstance.bpmn

        }

        gameInstance.save flush: true

        render "ok"
    }

    @Transactional
    def delete(Deploy deployInstance) {
//
//        if (gameInstance == null) {
//            notFound()
//            return
//        }
//
//        if(gameInstance.developer == springSecurityService.currentUser){
//            def war_dir = new File(grailsApplication.config.camundaWebapps+gameInstance.war_filename.minus(".war"))
//            war_dir.mkdirs()
//
//            if(war_dir.exists()){
//                println "Removendo deploy da aplicação..."
//                if(war_dir.deleteDir()){
//                    println "Remoção ocorrida com sucesso!"
//                    println "Removendo arquivo .war..."
//                    def war_file = new File(grailsApplication.config.camundaWebapps+gameInstance.war_filename)
//                    if(war_file.delete()){
//                        println "Arquivo .war removido com sucesso!"
//                    }
//                    else{
//                        println "Problemas ao remover .war!"
//                        redirect controller: "deploy", action: "index"
//                    }
//
//                }
//                else{
//                    println "Problemas ao remover diretório!"
//                    redirect controller: "deploy", action: "index"
//                }
//            }
//
//            gameInstance.delete flush:true
//
//            redirect controller: "deploy", action: "index"
//        }
//        else{
//            flash.message = "Você não tem acesso a esse deploy"
//            redirect action: 'index'
//        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'deploy.label', default: 'Deploy'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
