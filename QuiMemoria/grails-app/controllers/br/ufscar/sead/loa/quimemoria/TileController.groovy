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
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        render  view: "index"
    }

    def show() {
        // Verifica se o usuário fez o upload de alguma peça de dada dificuldade
        render  template: "tile",
                model: [
                    tileInstance: Tile.findById(params.id)
                ]
    }

    def create() {
        respond new Tile(params)
    }

    @Transactional
    def save(Tile tileInstance) {
        if (tileInstance == null) {
            notFound()
            return
        }

        if (tileInstance.hasErrors()) {
            respond tileInstance.errors, view:'create'
            return
        }

        def userId = session.user = springSecurityService.currentUser.getId()
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

    def listByDifficulty() {
        def owner = session.user.id
        def taskId = session.taskId
        def difficulty = params.difficulty.toInteger()

        println(owner)
        println(taskId)
        println(difficulty)

        render  template: "select",
                model: [
                        tileList: Tile.findAllByDifficultyAndOwnerIdAndTaskId(difficulty, owner, taskId)
                ]
    }

    def validate() {
        def owner = springSecurityService.currentUser.getId()
        def message = new StringBuilder()
        def difficulties = ['Fácil', 'Médio', 'Difícil']
        def ok = true

        for (def difficulty = 1; difficulty <= 3; difficulty++) {
            def min = difficulty * 2 + 2
            def count = Tile.countByDifficultyAndOwnerIdAndTaskId(difficulty, owner, session.taskId)

            if (count < min) {
                message << 'A dificuldade <b>' << difficulties[difficulty - 1] << '</b> deve ter no mínimo <b>' << min << ' peças</b> e você fez o upload de <b>' << count << ' peças</b>. <br/>'
                ok = false
            }
        }

        if (!ok) {
            render message.toString()
            return
        } else {
            // cria o arquivo json das peças
            createCustomTilesFile("customTiles.json", params.orientation)

            // encontra o endereço do arquivo criado
            def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")

            log.debug folder
            def ids = []
            ids << MongoHelper.putFile("${folder}/customTiles.json")

            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8080
            }

            // atualiza a tarefa corrente para o status de "completo"
            render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                    "?files=${ids[0]}"
        }
    }

    def createCustomTilesFile(filename, orientation) {
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        def owner = session.user.id
        def easyTilesIdList   = Tile.findAllByDifficultyAndOwnerIdAndTaskId(1, owner, session.taskId)*.id
        def mediumTilesIdList = Tile.findAllByDifficultyAndOwnerIdAndTaskId(2, owner, session.taskId)*.id
        def hardTilesIdList   = Tile.findAllByDifficultyAndOwnerIdAndTaskId(3, owner, session.taskId)*.id

        instancePath.mkdirs()

        def file = new File("$instancePath/" + filename)
        def bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"))

        println instancePath

        bw.write ("{\n")
        bw.write ("\t\"tiles\" : {\n")
        // Impressão das peças do nivel fácil
        bw.write ("\t\t\"easy\" : " + (easyTilesIdList as JSON).toString() + ",\n")
        // Impressão das peças do nivel médio
        bw.write ("\t\t\"medium\" : " + (mediumTilesIdList as JSON).toString() + ",\n")
        // Impressão das peças do nivel difícil
        bw.write ("\t\t\"hard\" : " + (hardTilesIdList as JSON).toString() + ",\n")
        bw.write ("\t},\n")
        // Orientação das peças
        bw.write ("\t\"orientation\" : \"" + orientation + "\"\n")
        bw.write ("}\n")

        bw.close()
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
