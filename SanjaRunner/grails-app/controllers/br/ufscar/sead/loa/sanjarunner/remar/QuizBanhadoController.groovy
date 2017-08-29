package br.ufscar.sead.loa.sanjarunner.remar



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QuizBanhadoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond QuizBanhado.list(params), model:[quizBanhadoInstanceCount: QuizBanhado.count()]
    }

    def show(QuizBanhado quizBanhadoInstance) {
        respond quizBanhadoInstance
    }

    def create() {
        respond new QuizBanhado(params)
    }

    @Transactional
    def save(QuizBanhado quizBanhadoInstance) {
        if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        if (quizBanhadoInstance.hasErrors()) {
            respond quizBanhadoInstance.errors, view:'create'
            return
        }

        quizBanhadoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect quizBanhadoInstance
            }
            '*' { respond quizBanhadoInstance, [status: CREATED] }
        }
    }

    def edit(QuizBanhado quizBanhadoInstance) {
        respond quizBanhadoInstance
    }

    @Transactional
    def update(QuizBanhado quizBanhadoInstance) {
        if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        if (quizBanhadoInstance.hasErrors()) {
            respond quizBanhadoInstance.errors, view:'edit'
            return
        }

        quizBanhadoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QuizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect quizBanhadoInstance
            }
            '*'{ respond quizBanhadoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(QuizBanhado quizBanhadoInstance) {

        if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        quizBanhadoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quizBanhado.label', default: 'QuizBanhado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
