package br.ufscar.sead.loa.remar

import grails.plugin.mail.MailService
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_DESENVOLVEDOR'])
class DeployController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    MailService mailService

    def index(Integer max) {

        if (request.isUserInRole("ROLE_ADMIN")) {
            render view: 'index', model:[deployInstanceList: Deploy.list(), deployInstanceCount: Deploy.count()]
        } else {
            render view: 'index', model:[deployInstanceList: Deploy.findAllByOwner(springSecurityService.currentUser as User), deployInstanceCount: Deploy.count()]
        }

    }

    @Secured(['ROLE_ADMIN'])
    def edit(Deploy deployInstance) {
        render view: 'edit', model:[deployInstance: deployInstance]
    }

    def create() {
        respond new Deploy(params)
    }

    @Transactional
    def save(Deploy deployInstance) {
        MultipartFile war = params.war
        def name = war.originalFilename.substring(0, war.originalFilename.lastIndexOf('.'))
        deployInstance.submittedAt = new Date()
        deployInstance.owner       = springSecurityService.currentUser as User
        deployInstance.status      = "pending"
        deployInstance.name        = name

        def file = new File(servletContext.getRealPath('/wars'), war.originalFilename)

        file.mkdirs()

        war.transferTo(file)
        def cmd = "sh " + servletContext.getRealPath("/scripts") + "/verify-war.sh ${servletContext.getRealPath("/wars")} ${name}"
        println cmd
        def foundBpmn = cmd.execute().text.toInteger()
        println foundBpmn
        if (!foundBpmn) {
            println ":("
            deployInstance.status  = "rejected"
            deployInstance.comment = name + "Process.bpmn not found"
            deployInstance.save flush: true
            return
        }

        deployInstance.save flush:true


        if(deployInstance.hasErrors()) {
            println deployInstance.errors
            respond deployInstance.errors, view:"create"
        } else {
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), deployInstance.id])
            redirect action: "index"
        }

    }

    def review() {
        def deploy = Deploy.findById(params.id)
        String status  = params.status
        String comment = params.comment

        if(!status && comment) {
            deploy.comment = comment
            if(deploy.status == "rejected") {
                mailService.sendMail {
                    async true
                    to deploy.owner.email
                    subject "REMAR – O seu WAR \"${deploy.name}\" foi rejeitado!"
                    html "<h3>O seu WAR \"${deploy.name}\" foi rejeitado pois ${comment}</h3> <br> "
                }
            }
        }

        if (status == "approve" && deploy.status != "approved") {
            deploy.status  = "approved"

            def game = new Game(name: deploy.name, active: true, version: 0, owner: deploy.owner)
            def platforms = Platform.list() // TODO: logic to select platforms
            game.addToPlatforms(platforms[0])
            game.addToPlatforms(platforms[1])
            game.addToPlatforms(platforms[2])
            game.addToPlatforms(platforms[3])
            game.save flush: true

            mailService.sendMail {
                async true
                to deploy.owner.email
                subject "REMAR – O seu WAR \"${deploy.name}\" foi aprovado!"
                html '<h3>O seu WAR \"${deploy.name}\" foi aprovado! :)</h3> <br>'
            }

            redirect controller: "process", action: "deploy", id: deploy.name
        } else if (status == "reject" && deploy.status != "rejected") {
            deploy.status  = "rejected"

            redirect controller: "process", action: "undeploy", id: deploy.name

        }

        deploy.save flush: true

        render "ok"
    }

    @Transactional
    def delete(Deploy deployInstance) {
//
//        if (deployInstance == null) {
//            notFound()
//            return
//        }
//
//        if(deployInstance.developer == springSecurityService.currentUser){
//            def war_dir = new File(grailsApplication.config.camundaWebapps+deployInstance.war_filename.minus(".war"))
//            war_dir.mkdirs()
//
//            if(war_dir.exists()){
//                println "Removendo deploy da aplicação..."
//                if(war_dir.deleteDir()){
//                    println "Remoção ocorrida com sucesso!"
//                    println "Removendo arquivo .war..."
//                    def war_file = new File(grailsApplication.config.camundaWebapps+deployInstance.war_filename)
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
//            deployInstance.delete flush:true
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
