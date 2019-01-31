package br.ufscar.sead.loa.demo.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import groovy.json.JsonBuilder
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.util.Environment

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class AudioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Audio.list(params), model:[audioInstanceCount: Audio.count()]
    }

    def show(Audio audioInstance) {
        respond audioInstance
    }

    def create() {
        respond new Audio(params)
    }

    @Transactional
    def save(Audio audioInstance) {
        if (audioInstance == null) {
            notFound()
            return
        }

        def userId = session.user.getId()
        def audio = new Audio()
        audio.ownerId = userId
        audioInstance.save flush: true

        if (audio.hasErrors()) {
            respond audio.errors, view: 'create'
            return
        }

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/audio/" + audio.getId())
        userPath.mkdirs()

        def audioUploaded = request.getFile('background')

        if (!audioUploaded.isEmpty()) {
            def originalBackgroundUploaded = new File("$userPath/record.wav")
            audioUploaded.transferTo(originalBackgroundUploaded)
        }

        redirect action: "index"
    }

    def finish() {
        def audio = Audio.findById(params.id);
        def folder = servletContext.getRealPath("/data/${audio.ownerId}/audios/${audio.id}")
        def id = MongoHelper.putFile(folder + '/record.wav')

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${id}"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'audio.label', default: 'Audio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def edit(Audio audioInstance) {
        respond audioInstance
    }

    @Transactional
    def update(Audio audioInstance) {
        if (audioInstance == null) {
            notFound()
            return
        }

        if (audioInstance.hasErrors()) {
            respond audioInstance.errors, view:'edit'
            return
        }

        audioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Audio.label', default: 'Audio'), audioInstance.id])
                redirect audioInstance
            }
            '*'{ respond audioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Audio audioInstance) {

        if (audioInstance == null) {
            notFound()
            return
        }

        audioInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Audio.label', default: 'Audio'), audioInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }


}
