package br.ufscar.sead.loa.quimemoria

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.util.Environment
import static org.springframework.http.HttpStatus.*
import org.springframework.security.access.annotation.Secured
import grails.transaction.Transactional


@Secured(['isAuthenticated()'])
class TileController {


    static allowedMethods = [choose: "POST", save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index() {
        // Separar as tiles por dificuldade
        def easyTilesList = Tile.findByDifficulty(1)
        def normalTilesList = Tile.findByDifficulty(2)
        def hardTilesList = Tile.findByDifficulty(3)

        render  view: "index",
                model: [
                    easyTilesList: easyTilesList,
                    normalTilesList: normalTilesList,
                    hardTilesList: hardTilesList
                ]
    }

    def show(Tile tileInstance) {
        respond tileInstance
    }

    def create() {
        respond new Tile(params)
    }

    @Transactional
    def save(Tile tileInstance) {
        println params

        if (tileInstance == null) {
            notFound()
            return
        }

        if (tileInstance.hasErrors()) {
            respond tileInstance.errors, view:'create'
            return
        }

        def userId = springSecurityService.getCurrentUser().getId()
        println(userId + " " + session.taskId)
        tileInstance.ownerId = userId
        tileInstance.taskId = session.taskId

        tileInstance.save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def id = tileInstance.getId()
        def userPath = new File(dataPath, "/" + userId + "/tiles")
        userPath.mkdirs()

        def f1Uploaded = request.getFile("tile-a")
        def f2Uploaded = request.getFile("tile-b")
        if (!f1Uploaded.isEmpty() && !f2Uploaded.isEmpty()) {
            def f1 = new File("$userPath/tile$id-a.png")
            def f2 = new File("$userPath/tile$id-b.png")
            f1Uploaded.transferTo(f1)
            f2Uploaded.transferTo(f2)
        }

        redirect(controller: "Tile", action:"index")
    }

    def edit(Tile tileInstance) {
        respond tileInstance
    }

    @Transactional
    def update(Tile tileInstance) {
        if (tileInstance == null) {
            notFound()
            return
        }

        if (tileInstance.hasErrors()) {
            respond tileInstance.errors, view:'edit'
            return
        }

        tileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Tile.label', default: 'Tile'), tileInstance.id])
                redirect tileInstance
            }
            '*'{ respond tileInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Tile tileInstance) {

        if (tileInstance == null) {
            notFound()
            return
        }

        tileInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Tile.label', default: 'Tile'), tileInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tile.label', default: 'Tile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def choose() {

        def files = ""
        def idList = JSON.parse(params.tiles)
        def folder = servletContext.getRealPath("/data/${Tile.get(idList[0]).ownerId}/tiles/")

        for (id in idList) {

            files += "&files=" + MongoHelper.putFile("${folder}/tile${id}-a.png")
            files += "&files=" + MongoHelper.putFile("${folder}/tile${id}-b.png")
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}${files}"

    }


}
