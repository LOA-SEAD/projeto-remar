package br.ufscar.sead.loa.labteca.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])

class AnotacaoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportAnotacoes','save', 'update', 'delete']]

    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }

    @Secured(['permitAll'])
    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        if (params.p) {
            session.processId = params.p
        }
        session.user = springSecurityService.currentUser

       def list = Anotacao.findAllByOwnerId(session.user.id)
        println list
        respond list, model: [AnotacaoInstanceCount: Anotacao.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(Anotacao anotacaoInstance) {
        respond anotacaoInstance
    }

    def create() {
        respond new Anotacao(params)
    }


   /* @Transactional
    def newAnotacao(Anotacao anotacaoInstance) {

        Anotacao newQuest = new Anotacao();
        newAnotacao.id = anotacaoInstance.id
        newAnotacao.statement = anotacaoInstance.statement
        newAnotacao.taskId    = session.taskId as String
        newAnotacao.ownerId = session.user.id

        if (newAnotacao.hasErrors()) {
            respond newAnotacao.errors, view: 'create' //TODO
            render newAnotacao.errors;
            return
        }

        newAnotacao.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newAnotacao.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())


    }
*/

    @Transactional
    def save(Anotacao anotacaoInstance) {
        if (anotacaoInstance == null) {
            notFound()
            return
        }

        if (anotacaoInstance.hasErrors()) {
            respond anotacaoInstance.errors, view:'create'
            render anotacaoInstance.errors;
            return
        }
      //anotacaoInstance.informacao[0]= params.informacao
        anotacaoInstance.ownerId = session.user.id as long
      // anotacaoInstance.taskId = session.taskId as String
        anotacaoInstance.save flush:true

        redirect(action: "index")
    }

    def edit(Anotacao anotacaoInstance) {
        respond anotacaoInstance
    }

    @Transactional
    def update() {
        Anotacao anotacaoInstance = Anotacao.findById(Integer.parseInt(params.anotacaoID))
        anotacaoInstance.informacao = params.informacao
        anotacaoInstance.ownerId = session.user.id as long
        anotacaoInstance.taskId = session.taskId as String
        anotacaoInstance.save flush:true

        redirect action: "index"
    }


    @Transactional
    def delete(Anotacao anotacaoInstance) {
        if (anotacaoInstance == null) {
            notFound()
            return
        }

        anotacaoInstance.delete flush: true
        redirect action: "index"
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'anotacao.label', default: 'Anotacao'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    @Secured(['permitAll'])
    def returnInstance(Anotacao anotacaoInstance){
        if (anotacaoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render anotacaoInstance.informacao + "%@!" +
                    questionFaseTCCInstance.id
        }

    }

}