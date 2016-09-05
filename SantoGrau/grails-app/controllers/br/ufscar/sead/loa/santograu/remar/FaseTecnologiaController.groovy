package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseTecnologiaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = 1//springSecurityService.currentUser
        params.max = Math.min(max ?: 10, 100)
        respond new FaseTecnologia(params)
    }

    def show(FaseTecnologia faseTecnologiaInstance) {
        respond faseTecnologiaInstance
    }

    def create() {
        respond new FaseTecnologia(params)
    }

    //@Transactional
    def save(FaseTecnologia faseTecnologiaInstance) {
        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        if (faseTecnologiaInstance.hasErrors()) {
            respond faseTecnologiaInstance.errors, view:'create'
            return
        }

        faseTecnologiaInstance.palavras[0]= params.palavras1
        faseTecnologiaInstance.palavras[1]= params.palavras2
        faseTecnologiaInstance.palavras[2]= params.palavras3
        faseTecnologiaInstance.ownerId = session.user.id as long
        faseTecnologiaInstance.taskId = session.taskId as String

        faseTecnologiaInstance.save flush:true

        /*
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'FaseTecnologia.label', default: 'FaseTecnologia'), faseTecnologiaInstance.id])
                redirect faseTecnologiaInstance
            }
            '*' { respond faseTecnologiaInstance, [status: CREATED] }
        }*/
    }

    def edit(FaseTecnologia faseTecnologiaInstance) {
        respond faseTecnologiaInstance
    }

    //@Transactional
    def update(FaseTecnologia faseTecnologiaInstance) {
        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        if (faseTecnologiaInstance.hasErrors()) {
            respond faseTecnologiaInstance.errors, view:'edit'
            return
        }

        faseTecnologiaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FaseTecnologia.label', default: 'FaseTecnologia'), faseTecnologiaInstance.id])
                redirect faseTecnologiaInstance
            }
            '*'{ respond faseTecnologiaInstance, [status: OK] }
        }
    }

    //@Transactional
    def delete(FaseTecnologia faseTecnologiaInstance) {

        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        faseTecnologiaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseTecnologia.label', default: 'FaseTecnologia'), faseTecnologiaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseTecnologia.label', default: 'FaseTecnologia'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
