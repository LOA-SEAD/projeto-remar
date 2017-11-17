package br.ufscar.sead.loa.demo.remar


import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class PhraseController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {

	if (params.t) {
            session.taskId = params.t
        }
	session.user = springSecurityService.currentUser

	def list = Phrase.findAllByAuthor(session.user.username)

        render view: "index", model: [phraseInstanceList: list, phraseInstanceCount: list.size()]
    }

    def show(Phrase phraseInstance) {
        respond phraseInstance
    }

    def create() {
	Phrase phrase = new Phrase(params)
        respond phrase
    }

    @Transactional
    def save(Phrase phraseInstance) {
        if (phraseInstance == null) {
            notFound()
            return
        }

	Phrase phrase = new Phrase();
        phrase.id = phraseInstance.id
        phrase.content = phraseInstance.content

	if (phraseInstance.author == null) {
            phraseInstance.author = session.user.username
	}
        
        phrase.author = phraseInstance.author
        phrase.taskId    = session.taskId as String
	phrase.ownerId = session.user.id

        if (phrase.hasErrors()) {
            respond phrase.errors, view:'create'
            return
        }

        phrase.save flush:true

        redirect(action: 'index')
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

        redirect(action: 'index')
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
