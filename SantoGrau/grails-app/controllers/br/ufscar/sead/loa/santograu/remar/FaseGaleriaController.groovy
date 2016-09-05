package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseGaleriaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        respond FaseGaleria.list(params), model:[faseGaleriaInstanceCount: FaseGaleria.count()]
    }

    def show(FaseGaleria faseGaleriaInstance) {
        respond faseGaleriaInstance
    }

    def create() {
        respond new FaseGaleria(params)
    }

    @Transactional
    def save(FaseGaleria faseGaleriaInstance) {
        if (faseGaleriaInstance == null) {
            notFound()
            return
        }

        if (faseGaleriaInstance.hasErrors()) {
            respond faseGaleriaInstance.errors, view:'create'
            return
        }

        faseGaleriaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'faseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect faseGaleriaInstance
            }
            '*' { respond faseGaleriaInstance, [status: CREATED] }
        }
    }

    def edit(FaseGaleria faseGaleriaInstance) {
        respond faseGaleriaInstance
    }

    @Transactional
    def update(FaseGaleria faseGaleriaInstance) {
        if (faseGaleriaInstance == null) {
            notFound()
            return
        }

        if (faseGaleriaInstance.hasErrors()) {
            respond faseGaleriaInstance.errors, view:'edit'
            return
        }

        faseGaleriaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FaseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect faseGaleriaInstance
            }
            '*'{ respond faseGaleriaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FaseGaleria faseGaleriaInstance) {

        if (faseGaleriaInstance == null) {
            notFound()
            return
        }

        faseGaleriaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseGaleria.label', default: 'FaseGaleria'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
