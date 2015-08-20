package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.mail.MailService
import grails.plugins.rest.client.RestBuilder
import grails.util.Environment
import groovy.util.slurpersupport.GPathResult
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.springframework.web.multipart.MultipartFile

import java.security.MessageDigest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_DESENVOLVEDOR','ROLE_USER'])
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

        // move to wars folder
        def file = new File(servletContext.getRealPath("/wars/${session.userId}"), fileName + ".war")
        file.mkdirs()
        war.transferTo(file)

        // unzip
        "chmod -R a+x ${servletContext.getRealPath('/scripts')}"
        def unzip = "${servletContext.getRealPath("/scripts")}/unzip.sh ${servletContext.getRealPath("/wars/${session.userId}")} ${fileName}"
        unzip.execute().waitFor()

        file = new File(servletContext.getRealPath("/wars/${session.userId}/${fileName}/WEB-INF"))
        if (!file.exists()) { // file is a WAR?
            gameInstance.valid = false
            gameInstance.name = war.originalFilename
            gameInstance.uri = ""
            gameInstance.status  = "rejected"
            gameInstance.comment = war.originalFilename + " isn't a war!"
            gameInstance.save flush: true
            redirect action: "index"
            println "not war"
            return
        }

        file = new File(servletContext.getRealPath("/wars/${session.userId}/${fileName}/data/manifest.json"))
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

        gameInstance.name    = manifest.name
        gameInstance.uri     = manifest.uri
        gameInstance.android = manifest.android
        gameInstance.linux   = manifest.linux
        gameInstance.moodle  = manifest.moodle

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
            println "banner not found"
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
            println "bpmn not found"
            return

        }

        gameInstance.web = true //default
        gameInstance.bpmn = manifest.bpmn
        gameInstance.comment = "Awaiting review"

        file = new File(servletContext.getRealPath("/wars/${session.userId}"), fileName + ".war")
                       .renameTo(servletContext.getRealPath("/wars/${session.userId}") + "/" + manifest.uri + ".war")

        gameInstance.save flush:true


        if(gameInstance.hasErrors()) {
            println gameInstance.errors
            respond gameInstance.errors, view:"create"
        } else {
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), gameInstance.id])
            redirect action: "index"
        }

    }

    def test() {
        "chmod a+x ${servletContext.getRealPath("/scripts/test.sh")}".execute().waitFor()
        render "${servletContext.getRealPath("/scripts/test.sh")}".execute().text
    }

    @Secured(['ROLE_USER'])
    def newDeveloper(){
        println "OLa"
    }

    @Secured(['ROLE_ADMIN'])
    def review() {
        def gameInstance = Game.findById(params.id)
        String status  = params.status
        String comment = params.comment

        if(!status) {
            gameInstance.comment = comment
            if(gameInstance.status == "rejected") {
                mailService.sendMail {
                    async true
                    to gameInstance.owner.email
                    subject "REMAR – O seu WAR \"${gameInstance.name}\" foi rejeitado!"
                    html "<h3>O seu WAR \"${gameInstance.name}\" foi rejeitado pois ${comment}</h3> <br> "
                }
                render 'success'
            }
        }

        if (status == "approve" && gameInstance.status != "approved") {

            "${servletContext.getRealPath("/scripts/db.sh")} ${gameInstance.uri}".execute().waitFor()

            if (Environment.current == Environment.DEVELOPMENT) {
                gameInstance.status  = "approved"
                gameInstance.active = true
                gameInstance.version = 0
                gameInstance.save flush: true

                redirect controller: "process", action: "deploy", id: gameInstance.bpmn
                return
            }

            def http = new HTTPBuilder('http://root:root@localhost:8080')
            def resp = http.get(path: '/manager/text/deploy',
                    query: [path: "/${gameInstance.uri}",
                            war: servletContext.getRealPath("/wars/${session.userId}/${gameInstance.uri}.war") ])
            resp = GrailsIOUtils.toString(resp)
            if(resp.indexOf('OK') != -1) {
                gameInstance.status  = "approved"
                gameInstance.active = true
                gameInstance.version = 0
                gameInstance.save flush: true

                mailService.sendMail {
                    async true
                    to gameInstance.owner.email
                    subject "REMAR – O seu WAR \"${gameInstance.name}\" foi aprovado!"
                    html '<h3>O seu WAR \"${gameInstance.name}\" foi aprovado! :)</h3> <br>'
                }

                render "success"
            } else {
                response.status = 500
                render resp

            }
            // probably we don't need this anymore because when the WAR is deployed the bpmn is deployed too
            // redirect controller: "process", action: "deploy", id: gameInstance.bpmn
        } else if (status == "reject" && gameInstance.status != "rejected") {
            gameInstance.status  = "rejected"

            render "success"

        }

        gameInstance.save flush: true

    }

    @Transactional
    def delete(Game gameInstance) {

        if (gameInstance == null) {
            response.status = 404
            render "Not found"
            return
        }

        if (gameInstance.owner == springSecurityService.currentUser) {
            gameInstance.delete flush: true
        }

        render "success"
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
