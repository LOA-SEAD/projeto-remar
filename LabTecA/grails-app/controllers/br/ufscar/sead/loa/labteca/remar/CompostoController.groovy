package br.ufscar.sead.loa.labteca.remar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Transactional(readOnly = true)
@Secured(["isAuthenticated()"])
class CompostoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", getTipoComposto: "GET"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Composto.list(params), model:[compostoInstanceCount: Composto.count()]
    }

    def show(Composto compostoInstance) {
        respond compostoInstance
    }

    def create() {
        respond new Composto(params)
    }

    @Transactional
    def save(Composto compostoInstance) {
        if (compostoInstance == null) {
            notFound()
            return
        }

        if (compostoInstance.hasErrors()) {
            respond compostoInstance.errors, view:'create'
            return
        }

        compostoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'composto.label', default: 'Composto'), compostoInstance.id])
                redirect compostoInstance
            }
            '*' { respond compostoInstance, [status: CREATED] }
        }
    }

    def edit(Composto compostoInstance) {
        respond compostoInstance
    }

    @Transactional
    def update(Composto compostoInstance) {
        if (compostoInstance == null) {
            notFound()
            return
        }

        if (compostoInstance.hasErrors()) {
            respond compostoInstance.errors, view:'edit'
            return
        }

        compostoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Composto.label', default: 'Composto'), compostoInstance.id])
                redirect compostoInstance
            }
            '*'{ respond compostoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Composto compostoInstance) {

        if (compostoInstance == null) {
            notFound()
            return
        }

        compostoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Composto.label', default: 'Composto'), compostoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'composto.label', default: 'Composto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getNomeComposto(Composto compostoInstance) {
        if (compostoInstance == null) {
            render "null"
        }
        else {
            render compostoInstance.nome
        }
    }

    def getFormulaComposto(Composto compostoInstance) {
        if (compostoInstance == null) {
            render "null"
        }
        else {
            render compostoInstance.formula
        }
    }

    def getTipoComposto(Composto compostoInstance) {
        if (compostoInstance == null) {
            // notFound()
            render "null"
        }
        else {
            render compostoInstance.tipo
        }
    }
}
