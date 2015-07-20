package br.ufscar.sead.loa.remar
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured

class MoodleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def save(Moodle moodle) {
        moodle.installedAt = new Date()

        println(moodle.installedAt);
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
}
