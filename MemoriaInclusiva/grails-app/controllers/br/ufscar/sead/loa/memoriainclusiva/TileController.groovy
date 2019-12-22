package br.ufscar.sead.loa.memoriainclusiva

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.util.Environment

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

        if (tilesList.size() == 0) {

            for (int i = 1; i <= 8; i++) {
                Tile tile = new Tile(textA: "${i}A", textB: "${i}B", description: "${i}",
                        ownerId: session.user.id)

                tile.save flush: true

                def samplesPath = servletContext.getRealPath("/samples")
                File samplesFolder = new File(samplesPath)

                def userPath = servletContext.getRealPath("/data/" + session.user.id.toString() + "/audios/" + tile.id)
                def userFolder = new File(userPath)
                userFolder.mkdirs()

                if (samplesFolder.exists()) {
                    String[] fileNames = ["carta1.wav", "carta2.wav", "descricao.wav"]

                    File srcFolder = new File(samplesPath + "/${i}")
                    for (String fileName : fileNames) {
                        def srcFile = new File(srcFolder, fileName)
                        def destFile = new File(userFolder, fileName)
                        println srcFile.getAbsolutePath() + " => " + destFile.getAbsolutePath()
                        Files.copy(srcFile.toPath(), destFile.toPath())
                    }
                } else {
                    textToSpeech("${tile.textA}", "$userPath/carta1.wav")
                    textToSpeech("${tile.textB}", "$userPath/carta2.wav")
                    textToSpeech("${tile.description}", "$userPath/descricao.wav")
                }
            }

            tilesList = Tile.findAllByOwnerId(session.user.id)
        }

        render view: "index", model: [tilesList: tilesList, tilesCount: tilesList.count, level: session.level]
    }

    def show(Tile tileInstance) {
        respond tileInstance
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
        tileInstance.description = params["description"]
        tileInstance.save flush: true

        def tileID = tileInstance.getId()

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + tileID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if (params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioDescription != null) {
            def f1Recorded = request.getFile("audioDescription")
            def f1File = new File("$userPath/descricao.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if (params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-3"] != null) {
            def f1Recorded = request.getFile("audio-3")
            def f1File = new File("$userPath/descricao.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectCartaA"] == "gerar") {
            println "Text-to-Speech (Texto Primeira Carta)"
            println "Running Script for Text-to-Speech (Texto Primeira Carta)"
            textToSpeech("$tileInstance.textA", "$userPath/carta1.wav")
        }
        if (params["selectCartaB"] == "gerar") {
            println "Text-to-Speech (Texto Segunda Carta)"
            println "Running Script for Text-to-Speech (Texto Segunda Carta)"
            textToSpeech("$tileInstance.textB", "$userPath/carta2.wav")
        }
        if (params["selectDescription"] == "gerar") {
            println "Text-to-Speech (Texto da Descrição)"
            println "Running Script for Text-to-Speech (Texto da Descrição)"
            textToSpeech("$tileInstance.description", "$userPath/descricao.wav")
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }

        render(status: 200, text: "http://${request.serverName}:${port}/memoriainclusiva/tile/")

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
        tileInstance.description = params.description
        def userId = session.user.id
        tileInstance.ownerId = userId
        tileInstance.save flush: true

        def tileID = params.tileID

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + tileID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if (params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioDescription != null) {
            def f1Recorded = request.getFile("audioDescription")
            def f1File = new File("$userPath/descricao.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if (params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/carta1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/carta2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-3"] != null) {
            def f1Recorded = request.getFile("audio-3")
            def f1File = new File("$userPath/descricao.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectCartaA"] == "gerar") {
            println "Text-to-Speech (Texto Primeira Carta)"
            println "Running Script for Text-to-Speech (Texto Primeira Carta)"
            textToSpeech("$tileInstance.textA", "$userPath/carta1.wav")
        }

        if (params["selectCartaB"] == "gerar") {
            println "Text-to-Speech (Texto Segunda Carta)"
            println "Running Script for Text-to-Speech (Texto Segunda Carta)"
            textToSpeech("$tileInstance.textB", "$userPath/carta2.wav")
        }
        if (params["selectDescription"] == "gerar") {
            println "Text-to-Speech (Texto da Descrição)"
            println "Running Script for Text-to-Speech (Texto da Descrição)"
            textToSpeech("$tileInstance.description", "$userPath/descricao.wav")
        }

        if (request.isXhr()) {
            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8090
            }

            render ("http://${request.serverName}:${port}/memoriainclusiva/tile/")
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
        def f3 = new File(tiles.c)
        f1.delete()
        f2.delete()
        f3.delete()


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
            case 1: if (tileList.size() != Tile.FACIL) render(500); break;
            case 2: if (tileList.size() != Tile.MEDIO) render(500); break;
            case 3: if (tileList.size() != Tile.DIFICIL) render(500); break;
        }

        def fileName = "level${session.level}.json"

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$folder/$fileName"), "UTF-8"));

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8090
        }
        def fullUrl = "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?"

        for (def i = 0; i < tileList.size(); i++) {

            def currFile = new File(getTilesAudios(tileList[i]).a)
            fileName = "$folder/L${session.level}-${i + 1}A.wav"
            def destFile = new File(fileName)
            Files.copy(currFile.toPath(), destFile.toPath())

            fullUrl += "files=${MongoHelper.putFile(fileName)}&"

            currFile = new File(getTilesAudios(tileList[i]).b)
            fileName = "$folder/L${session.level}-${i + 1}B.wav"
            destFile = new File(fileName)
            Files.copy(currFile.toPath(), destFile.toPath())

            fullUrl += "files=${MongoHelper.putFile(fileName)}&"

            currFile = new File(getTilesAudios(tileList[i]).c)
            fileName = "$folder/L${session.level}-${i + 1}C.wav"
            destFile = new File(fileName)
            Files.copy(currFile.toPath(), destFile.toPath())

            fullUrl += "files=${MongoHelper.putFile(fileName)}&"

            fw.write("{")
            fw.write("\"pairNumber\": " + (i + 1) + ", ")
            fw.write("\"textA\": " + "\"" + tileList[i].textA + "\", ")
            fw.write("\"textB\": " + "\"" + tileList[i].textB + "\", ")
            fw.write("\"description\": " + "\"" + tileList[i].description + "\", ")
            fw.write("\"audioA\": " + "\"L" + session.level + "-" + (i + 1) + "A.wav\"" + ", ")
            fw.write("\"audioB\": " + "\"L" + session.level + "-" + (i + 1) + "B.wav\"" + ", ")
            fw.write("\"descriptionAudio\": " + "\"L" + session.level + "-" + (i + 1) + "C.wav\"")
            fw.write("}\n")
        }

        fw.close();

        log.debug folder
        fileName = "${folder}/level${session.level}.json"
        println fileName
        fullUrl += "files=${MongoHelper.putFile(fileName)}"

        // atualiza a tarefa corrente para o status de "completo"
        render(status: 200, text: fullUrl)
    }

// return list with filenames for images related to a tile pair
    def getTilesAudios(tileInstance) {
        def userPath = servletContext.getRealPath("/data/${tileInstance.ownerId.toString()}")
        def id = tileInstance.id
        def images = [
                "a": "$userPath/audios/$id/carta1.wav".toString(),
                "b": "$userPath/audios/$id/carta2.wav".toString(),
                "c": "$userPath/audios/$id/descricao.wav".toString()
        ]

        return images
    }

    def WAVFile(params) {

        InputStream contentStream

        def userId = springSecurityService.getCurrentUser().getId()

        def dir = new File(servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + params.id))

        File file = new File(dir, params.file + ".wav")

        response.setHeader("Content-disposition", "attachment; filename=" + file.getName())
        response.setHeader("Content-Length", file.size().toString())
        response.setContentType("file-mime-type")
        contentStream = file.newInputStream()
        response.outputStream << contentStream
        webRequest.renderView = false
    }

}

