package br.ufscar.sead.loa.memoria

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.util.Environment

import java.nio.file.Path

import static org.springframework.http.HttpStatus.*
import org.springframework.security.access.annotation.Secured
import grails.transaction.Transactional
import java.nio.file.Files

@Secured(['isAuthenticated()'])
class TileController {

    def beforeInterceptor = [action: this.&check, only: ['index']]

    def springSecurityService

    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }

    def index() {
        if (params.t) {
            session.taskId = params.t
        }

        if (params.level) {
            session.level = params.level
        }

        def tilesList = Tile.findAllByOwnerId(session.user.id)

        render view: "index", model: [tilesList: tilesList, tilesCount: tilesList.count, level: session.level]
    }

    def show() {
        render template: "tile",
                model: [tileInstance: Tile.findById(params.id)]
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
            respond tileInstance.errors, view: 'create'
            return
        }


        def userId = session.user.id
        tileInstance.ownerId = userId
        tileInstance.save flush: true

        def id = tileInstance.getId()
        // id = id do tileInstance = userId declarado acima = id do usuário da sessão >>> 4 itens armazenando a mesma coisa? pq?
        def userPath = servletContext.getRealPath("/data/" + userId.toString())
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        def f1Uploaded = request.getFile("audioA")
        def f2Uploaded = request.getFile("audioB")


        def f1 = new File("$userPath/audio$id-a.wav")
        def f2 = new File("$userPath/audio$id-b.wav")

        f1Uploaded.transferTo(f1)
        f2Uploaded.transferTo(f2)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }

        render(status: 200, text: "http://${request.serverName}:${port}/memoria/tile/")

    }

    def edit() {
        def tileInstance = Tile.findById(params.id)

        render view: "edit",
                model: [
                        tileInstance: tileInstance,
                        edit        : true
                ]
    }

    @Transactional
    def update() {
        def tileInstance = Tile.get(params.id)
        tileInstance.content = params.content
        tileInstance.description = params.description
        tileInstance.difficulty = params.difficulty.toInteger()

        tileInstance.save flush: true

        if (tileInstance.hasErrors()) {
            println tileInstance.errors
        }

        def userId = session.user.id
        def id = tileInstance.getId()
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/" + tileInstance.taskId.toString() + "/tiles")
        def script_convert_png = servletContext.getRealPath("/scripts/convert.sh")


        def f1Uploaded = request.getFile("tile-a")

        def f2Uploaded = request.getFile("tile-b")


        def errors = [
                not_image_file_a: false,
                not_image_file_b: false
        ]

        if (! f1Uploaded.isEmpty()){
            if (!f1Uploaded.fileItem.contentType.startsWith("image/")) {
                errors.not_image_file_a = true
            }
        }

        if (! f2Uploaded.isEmpty()){
            if (!f2Uploaded.fileItem.contentType.startsWith("image/")) {
                errors.not_image_file_b = true
            }
        }

        // if any of those files aren't images, we can't convert
        if (!(errors.not_image_file_a || errors.not_image_file_b)) {

            // Change tile first image if it was uploaded
            if (!f1Uploaded.isEmpty()) {
                def f1 = new File("$userPath/tile$id-a.png")
                f1Uploaded.transferTo(f1)

                // convert to png
                executarShell(
                        script_convert_png,
                        [
                                f1.absolutePath,
                                f1.absolutePath
                        ]
                )
            }

            // Change tile second image if it was uploaded
            if (!f2Uploaded.isEmpty()) {
                def f2 = new File("$userPath/tile$id-b.png")
                f2Uploaded.transferTo(f2)

                // convert to png
                executarShell(
                        script_convert_png,
                        [
                                f2.absolutePath,
                                f2.absolutePath
                        ]
                )
            }

            redirect(controller: "Tile", action: "index")
        } else {
            flash.error = errors
            tileInstance.delete(flush:true)
            redirect(controller: "Tile", action: "create")
        }

    }

    @Transactional
    def delete() {
        def tileInstance = Tile.findById(params.id)

        if (tileInstance == null) {
            notFound()
            return
        }

        // delete tile images before removing them from database
        def tiles = getTilesAudios(tileInstance)

        def f1 = new File(tiles.a)
        def f2 = new File(tiles.b)
        f1.delete()
        f2.delete()

        tileInstance.delete flush: true

        redirect(controller: "Tile", action: "index")
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tile.label', default: 'Tile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def validate() {
        def owner = springSecurityService.currentUser.getId()

        // Getting all the selected tiles
        def tileList = Tile.getAll(params.id)
        def message = new StringBuilder()

        // encontra o endereço do arquivo criado
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        def newPath = new File(folder)
        newPath.mkdirs()

        def f1 = new File(getTilesAudios(tileList[0]).a)
        def f2 = new File(getTilesAudios(tileList[0]).b)
        def f3 = new File(getTilesAudios(tileList[1]).a)
        def f4 = new File(getTilesAudios(tileList[1]).b)
        def f5 = new File(getTilesAudios(tileList[2]).a)
        def f6 = new File(getTilesAudios(tileList[2]).b)
        def d1 = new File("$folder/L1A1.wav")
        def d2 = new File("$folder/L1A2.wav")
        def d3 = new File("$folder/L1A3.wav")
        def d4 = new File("$folder/L1A4.wav")
        def d5 = new File("$folder/L1A5.wav")
        def d6 = new File("$folder/L1A6.wav")

        Files.copy(f1.toPath(), d1.toPath())
        Files.copy(f2.toPath(), d2.toPath())
        Files.copy(f3.toPath(), d3.toPath())
        Files.copy(f4.toPath(), d4.toPath())
        Files.copy(f5.toPath(), d5.toPath())
        Files.copy(f6.toPath(), d6.toPath())


        def fileName = "level1.json"

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$folder/$fileName"), "UTF-8"));

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }
        def fullUrl ="http://${request.serverName}:${port}/process/task/complete/${session.taskId}?"

        def cardContador = 1
        for (def i = 0; i < tileList.size(); i++) {
            fw.write("{")
            fw.write("\"cardNumber\": " + cardContador + ", ")
            fw.write("\"cardText\": \"" + tileList[i].textA + "\", ")
            fw.write("\"audioName\": " + "\"L1A" + cardContador + ".wav\"")
            fw.write("}\n")

            fullUrl += "files=${MongoHelper.putFile("${folder}/L1A${cardContador}.wav")}&"

            cardContador++;

            fw.write("{")
            fw.write("\"cardNumber\": " + cardContador + ", ")
            fw.write("\"cardText\": \"" + tileList[i].textB + "\", ")
            fw.write("\"audioName\": " + "\"L1A" + cardContador +".wav\"")
            fw.write("}\n")

            fullUrl += "files=${MongoHelper.putFile("${folder}/L1A${cardContador}.wav")}&"

            cardContador++;
        }

        fw.close();

        log.debug folder
        fullUrl += "files=${MongoHelper.putFile("${folder}/level1.json")}"

        // atualiza a tarefa corrente para o status de "completo"
        render(status: 200, text: fullUrl)
    }

    // return list with filenames for images related to a tile pair
    def getTilesAudios(tileInstance) {
        def userPath = servletContext.getRealPath("/data/${tileInstance.ownerId.toString()}")
        def id = tileInstance.id
        def images = [
                "a": "$userPath/audio$id-a.wav".toString(),
                "b": "$userPath/audio$id-b.wav".toString()
        ]

        return images
    }
}

