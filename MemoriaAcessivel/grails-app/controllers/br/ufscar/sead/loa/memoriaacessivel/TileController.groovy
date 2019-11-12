package br.ufscar.sead.loa.memoriaacessivel

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
        println(params)
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

        def tileID = tileInstance.getId()

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + tileID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if(params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if(params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if(params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if(params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectPerg"] == "gerar") {
            println "Text-to-Speech (Texto Primeira Carta)"
            println "Running Script for Text-to-Speech (Texto Primeira Carta)"
            textToSpeech("$tileInstance.textA", "$userPath/carta1.mp3")
        }

        if (params["selectResp"] == "gerar") {
            println "Text-to-Speech (Texto Segunda Carta)"
            println "Running Script for Text-to-Speech (Texto Segunda Carta)"
            textToSpeech("$tileInstance.textB", "$userPath/carta2.mp3")
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }

        render(status: 200, text: "http://${request.serverName}:${port}/memoria_acessivel/tile/")

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
        println("params edit: $params")

        Tile tileInstance = Tile.findById(Integer.parseInt(params.tileID))

        tileInstance.textA = params.textA
        tileInstance.textB = params.textB
        def userId = session.user.id
        tileInstance.ownerId = userId
        tileInstance.save flush: true

        def tileID = params.tileID

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + tileID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if(params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if(params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if(params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if(params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectPerg"] == "gerar") {
            println "Text-to-Speech (Texto Primeira Carta)"
            println "Running Script for Text-to-Speech (Texto Primeira Carta)"
            textToSpeech("$tileInstance.textA", "$userPath/carta1.mp3")
        }

        if (params["selectResp"] == "gerar") {
            println "Text-to-Speech (Texto Segunda Carta)"
            println "Running Script for Text-to-Speech (Texto Segunda Carta)"
            textToSpeech("$tileInstance.textB", "$userPath/carta2.mp3")

        }



        if (request.isXhr()) {
            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8090
            }

            //redirect(controller: "Tile", action: "index")

            render("http://localhost:${port}/memoria_acessivel/tile")
        } else {
            // TODO
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

    void textToSpeech(String text, String file) {
        def ant = new AntBuilder()
        def rootPath = servletContext.getRealPath('/')
        def script = "${rootPath}/scripts/gtts.py"
        ant.sequential {
            chmod(perm: "+x", file: script)
            exec(executable: script) {
                arg(value: "$text")
                arg(value: "$file")
            }
        }
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
        println("params: $params")
        def owner = springSecurityService.currentUser.getId()

        // Getting all the selected tiles
        def tileList = Tile.getAll(params.id)
        def message = new StringBuilder()

        // encontra o endereço do arquivo criado
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        //def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/")
        def newPath = new File(folder)
        newPath.mkdirs()

        switch (session.level) {
            case 1: if (tileList.size() != 3) render(500); break;
            case 2: if (tileList.size() != 4) render(500); break;
            case 3: if (tileList.size() != 6) render(500); break;
        }

        def fileName = "level${session.level}.json"

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$folder/$fileName"), "UTF-8"));

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }
        def fullUrl ="http://${request.serverName}:${port}/process/task/complete/${session.taskId}?"

        def cardCounter = 1
        for (def i = 0; i < tileList.size(); i++) {

            def currFile = new File(getTilesAudios(tileList[i]).a)
            def destFile = new File("$folder/L${session.level}A${cardCounter}.wav")
            print("session level: $session.level")
            Files.copy(currFile.toPath(), destFile.toPath())


            fw.write("{")
            fw.write("\"cardNumber\": " + cardCounter + ", ")
            fw.write("\"cardText\": \"" + tileList[i].textA + "\", ")
            fw.write("\"audioName\": " + "\"L" + session.level + "A" + cardCounter +".wav\"")
            fw.write("}\n")

            fullUrl += "files=${MongoHelper.putFile("${folder}/L${session.level}A${cardCounter}.wav")}&"

            cardCounter++;

            currFile = new File(getTilesAudios(tileList[i]).b)
            destFile = new File("$folder/L${session.level}A${cardCounter}.wav")
            Files.copy(currFile.toPath(), destFile.toPath())

            fw.write("{")
            fw.write("\"cardNumber\": " + (cardCounter-1) + ", ")
            fw.write("\"cardText\": \"" + tileList[i].textB + "\", ")
            fw.write("\"audioName\": " + "\"L" + session.level + "A" + cardCounter +".wav\"")
            fw.write("}\n")

            fullUrl += "files=${MongoHelper.putFile("${folder}/L${session.level}A${cardCounter}.wav")}&"

            cardCounter++;
        }

        fw.close();

        log.debug folder
        fullUrl += "files=${MongoHelper.putFile("${folder}/level${session.level}.json")}"

        // atualiza a tarefa corrente para o status de "completo"
        render(status: 200, text: fullUrl)
    }

    // return list with filenames for images related to a tile pair
    def getTilesAudios(tileInstance) {
        def userPath = servletContext.getRealPath("/data/${tileInstance.ownerId.toString()}")
        def id = tileInstance.id
        def images = [
                "a": "$userPath/audios/$id/carta1.mp3".toString(),
                "b": "$userPath/audios/$id/carta2.mp3".toString()
        ]

        return images
    }
}

