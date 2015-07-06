package br.ufscar.sead.loa.remar



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MoodleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Moodle.list(params), model:[moodleCount: Moodle.count()]
    }

    def show(Moodle moodle) {
        respond moodle
    }

    def create() {
        respond new Moodle(params)
    }

    @Transactional
    def save(Moodle moodle) {
        moodle.installedAt = new Date()
        print moodle.installedAt

        /*if (moodle == null) {
            notFound()
            return
        }

        if (moodle.hasErrors()) {
            respond moodle.errors, view:'create'
            return
        }*/

        moodle.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'moodle.label', default: 'Moodle'), moodle.id])
                redirect moodle
            }
            '*' { respond moodle, [status: CREATED] }
        }
    }

    def edit(Moodle moodle) {
        respond moodle
    }

    @Transactional
    def update(Moodle moodle) {
        if (moodle == null) {
            notFound()
            return
        }

        if (moodle.hasErrors()) {
            respond moodle.errors, view:'edit'
            return
        }

        moodle.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Moodle.label', default: 'Moodle'), moodle.id])
                redirect moodle
            }
            '*'{ respond moodle, [status: OK] }
        }
    }

    @Transactional
    def delete(Moodle moodle) {

        if (moodle == null) {
            notFound()
            return
        }

        moodle.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Moodle.label', default: 'Moodle'), moodle.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'moodle.label', default: 'Moodle'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
