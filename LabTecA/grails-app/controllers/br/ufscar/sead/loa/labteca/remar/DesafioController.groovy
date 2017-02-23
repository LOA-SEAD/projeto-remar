package br.ufscar.sead.loa.labteca.remar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Transactional(readOnly = true)
@Secured('ROLE_ADMIN')
class DesafioController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        if (params.t)
            session.taskID = params.t

        if (params.p)
            session.processID = params.p

        session.user = springSecurityService.currentUser

        def compostos = Composto.findAll()
        def tipos = [Composto.SAL, Composto.BASE, Composto.ACIDO, Composto.ORGANICO, Composto.ETC]

        respond compostos, model: [tiposCompostoList: tipos]
    }

    def show(Desafio desafioInstance) {
        respond desafioInstance
    }

    def create() {
        respond new Desafio(params)
    }

    @Transactional
    def save(Desafio desafioInstance) {
        if (desafioInstance == null) {
            notFound()
            return
        }

        if (desafioInstance.hasErrors()) {
            respond desafioInstance.errors, view:'create'
            return
        }

        desafioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'desafio.label', default: 'Desafio'), desafioInstance.id])
                redirect desafioInstance
            }
            '*' { respond desafioInstance, [status: CREATED] }
        }
    }

    def edit(Desafio desafioInstance) {
        respond desafioInstance
    }

    @Transactional
    def update(Desafio desafioInstance) {
        if (desafioInstance == null) {
            notFound()
            return
        }

        if (desafioInstance.hasErrors()) {
            respond desafioInstance.errors, view:'edit'
            return
        }

        desafioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Desafio.label', default: 'Desafio'), desafioInstance.id])
                redirect desafioInstance
            }
            '*'{ respond desafioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Desafio desafioInstance) {

        if (desafioInstance == null) {
            notFound()
            return
        }

        desafioInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Desafio.label', default: 'Desafio'), desafioInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'desafio.label', default: 'Desafio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
