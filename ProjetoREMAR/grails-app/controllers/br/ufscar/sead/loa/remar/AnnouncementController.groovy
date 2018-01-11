package br.ufscar.sead.loa.remar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnnouncementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def announcements = Announcement.list().sort { it.createdDate }
        respond model:[announcements: announcements, announcementCount: Announcement.count()]
    }

    def show(Announcement announcement) {
        respond announcement
    }

    def create() {
        respond new Announcement(params)
    }

    @Transactional
    def save(Announcement announcement) {
        if (announcement == null) {
            notFound()
            return
        }

        if (announcement.author == null) {
            announcement.author == User.findById(springSecurityService.getCurrentUser().getId())
        }

        if (announcement.hasErrors()) {
            respond announcement.errors, view:'create'
            return
        }

        announcement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'announcement.label', default: 'Announcement'), announcement.id])
                redirect announcement
            }
            '*' { respond announcement, [status: CREATED] }
        }
    }

    def edit(Announcement announcement) {
        respond announcement
    }

    @Transactional
    def update(Announcement announcement) {
        if (announcement == null) {
            notFound()
            return
        }

        if (announcement.hasErrors()) {
            respond announcement.errors, view:'edit'
            return
        }

        announcement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Announcement.label', default: 'Announcement'), announcement.id])
                redirect announcement
            }
            '*'{ respond announcement, [status: OK] }
        }
    }

    @Transactional
    def delete(Announcement announcement) {

        if (announcement == null) {
            notFound()
            return
        }

        announcement.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Announcement.label', default: 'Announcement'), announcement.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'announcement.label', default: 'Announcement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
