package br.ufscar.sead.loa.demo.remar


import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class PhraseController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Phrase.list(params), model:[phraseInstanceCount: Phrase.count()]
    }

    def show(Phrase phraseInstance) {
        respond phraseInstance
    }

    def create() {
        respond new Phrase(params)
    }

    @Transactional
    def save(Phrase phraseInstance) {
        if (phraseInstance == null) {
            notFound()
            return
        }

        if (phraseInstance.hasErrors()) {
            respond phraseInstance.errors, view:'create'
            return
        }

        phraseInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'phrase.label', default: 'Phrase'), phraseInstance.id])
                redirect phraseInstance
            }
            '*' { respond phraseInstance, [status: CREATED] }
        }
    }

    def edit(Phrase phraseInstance) {
        respond phraseInstance
    }

    @Transactional
    def update(Phrase phraseInstance) {
        if (phraseInstance == null) {
            notFound()
            return
        }

        if (phraseInstance.hasErrors()) {
            respond phraseInstance.errors, view:'edit'
            return
        }

        phraseInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Phrase.label', default: 'Phrase'), phraseInstance.id])
                redirect phraseInstance
            }
            '*'{ respond phraseInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Phrase phraseInstance) {

        if (phraseInstance == null) {
            notFound()
            return
        }

        phraseInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Phrase.label', default: 'Phrase'), phraseInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'phrase.label', default: 'Phrase'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
