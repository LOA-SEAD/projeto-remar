package escolamagica

import grails.converters.JSON
import grails.converters.XML
import org.springframework.security.access.annotation.Secured
import projetoremar.Palavras

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['ROLE_PROF'])
@Transactional(readOnly = true)
class QuestoesController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Questoes.list(params), model:[questoesInstanceCount: Questoes.count()]

    }

    def show(Questoes questoesInstance) {
        respond questoesInstance

    }

    def test(){
        render Questoes.list() as XML
    }

    def create() {
        respond new Questoes(params)


    }


    @Transactional
    def save(Questoes questoesInstance) {
        if (questoesInstance == null) {
            notFound()
            return
        }

        if (questoesInstance.hasErrors()) {
            respond questoesInstance.errors, view:'create'
            return
        }

        questoesInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'questoes.label', default: 'Questoes'), questoesInstance.id])
                redirect questoesInstance
            }
            '*' { respond questoesInstance, [status: CREATED] }
        }
    }

    def edit(Questoes questoesInstance) {
        respond questoesInstance
    }

    @Transactional
    def update(Questoes questoesInstance) {
        if (questoesInstance == null) {
            notFound()
            return
        }

        if (questoesInstance.hasErrors()) {
            respond questoesInstance.errors, view:'edit'
            return
        }

        questoesInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Questoes.label', default: 'Questoes'), questoesInstance.id])
                redirect questoesInstance
            }
            '*'{ respond questoesInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Questoes questoesInstance) {

        if (questoesInstance == null) {
            notFound()
            return
        }

        questoesInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Questoes.label', default: 'Questoes'), questoesInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'questoes.label', default: 'Questoes'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
