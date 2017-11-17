package br.ufscar.sead.loa.demo.remar


import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class ThemeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {

        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Theme.findAllByOwnerId(session.user.id)

        render view: "index", model: [themeInstanceList: list, themeInstanceCount: list.size()]
    }

    def show(Theme themeInstance) {
        respond themeInstance
    }

    def create() {
        respond new Theme(params)
    }

    @Transactional
    def save(Theme themeInstance) {
        if (themeInstance == null) {
            notFound()
            return
        }

        def userId = session.user.getId()

        def theme = new Theme(ownerId: userId, taskId: session.taskId).save flush: true

        if (theme.hasErrors()) {
            respond theme.errors, view:'create'
            return
        }

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/themes/" + theme.getId())
        userPath.mkdirs()

        def backgroundUploaded = request.getFile('background')

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'theme.label', default: 'Theme'), themeInstance.id])
                redirect themeInstance
            }
            '*' { respond themeInstance, [status: CREATED] }
        }
    }

    def edit(Theme themeInstance) {
        respond themeInstance
    }

    @Transactional
    def update(Theme themeInstance) {
        if (themeInstance == null) {
            notFound()
            return
        }

        if (themeInstance.hasErrors()) {
            respond themeInstance.errors, view:'edit'
            return
        }

        themeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Theme.label', default: 'Theme'), themeInstance.id])
                redirect themeInstance
            }
            '*'{ respond themeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Theme themeInstance) {

        if (themeInstance == null) {
            notFound()
            return
        }

        themeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Theme.label', default: 'Theme'), themeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'theme.label', default: 'Theme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
