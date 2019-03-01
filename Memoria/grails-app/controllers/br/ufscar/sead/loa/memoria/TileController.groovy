package br.ufscar.sead.loa.memoria

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.util.Environment
import static org.springframework.http.HttpStatus.*
import org.springframework.security.access.annotation.Secured
import grails.transaction.Transactional


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

        def tilesList = Tile.findAllByOwnerId(session.user.id)

        render view: "index", model: [tilesList: tilesList, tilesCount: tilesList.count]
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

    def listByDifficulty() {
        def owner = session.user.id
        def taskId = session.taskId
        def difficulty = params.difficulty.toInteger()
        def tileList = Tile.findAllByDifficultyAndOwnerIdAndTaskId(difficulty, owner, taskId)

        // se a lista de peças não for vazia, renderiza o select com as peças
        if (tileList == null || tileList.empty) {
            // status 412: precondition_failed
            // uma ou mais condições testadas pelo servidos foram avaliadas como falsas ou falharam
            render(status: 412, template: "empty")
        } else {
            render(status: 200, template: "select", model: [tileList: tileList])
        }
    }

    def validate() {
        def owner = springSecurityService.currentUser.getId()

        // Getting all the selected tiles
        def tileList = Tile.getAll(params.id)
        def message = new StringBuilder()
        def ok = true



        if (!ok) {
            render(status: 201, text: message.toString())
            return
        } else {
            // encontra o endereço do arquivo criado
            def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
            def newPath = new File(folder)
            newPath.mkdirs()


            def f1Uploaded = request.getFile(getTilesAudios(tileList[0]).a)
            def f2Uploaded = request.getFile(getTilesAudios(tileList[0]).b)
            def f3Uploaded = request.getFile(getTilesAudios(tileList[1]).a)
            def f4Uploaded = request.getFile(getTilesAudios(tileList[1]).b)
            def f5Uploaded = request.getFile(getTilesAudios(tileList[2]).a)
            def f6Uploaded = request.getFile(getTilesAudios(tileList[2]).b)


            def f1 = new File("$folder/L1A1.wav")
            def f2 = new File("$folder/L1A2.wav")
            def f3 = new File("$folder/L1A3.wav")
            def f4 = new File("$folder/L1A4.wav")
            def f5 = new File("$folder/L1A5.wav")
            def f6 = new File("$folder/L1A6.wav")

            f1Uploaded.transferTo(f1)
            f2Uploaded.transferTo(f2)
            f3Uploaded.transferTo(f3)
            f4Uploaded.transferTo(f4)
            f5Uploaded.transferTo(f5)
            f6Uploaded.transferTo(f6)


            def fileName = "level1.json"
            def fw = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream("$folder/$fileName"), "UTF-8"));

            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8090
            }
            def fullUrl ="http://${request.serverName}:${port}/process/task/complete/${session.taskId}?"





            for (def i=0; i<tileList.size(); i++) {
                def cardContador = i+1
                fw.write("{")
                fw.write("\"cardNumber\": " + cardContador + ", ")
                fw.write("\"cardText\": \"" + tileList[i].textA + "\", ")
                fw.write("\"audioName\": " + "\"audio" + tileList[i].id + "-a.wav\"")
                fw.write("}\n")

                fw.write("{")
                fw.write("\"cardNumber\": " + cardContador + ", ")
                fw.write("\"cardText\": \"" + tileList[i].textB + "\", ")
                fw.write("\"audioName\": " + "\"audio" + tileList[i].id + "-b.wav\"")
                fw.write("}\n")

                fullUrl += "files=${MongoHelper.putFile("${folder}/audio${tileList[i].id}-a.wav")}&"
                fullUrl += "files=${MongoHelper.putFile("${folder}/audio${tileList[i].id}-b.wav")}&"
            }


            fw.close();


            log.debug folder
            fullUrl += "files=${MongoHelper.putFile("${folder}/level1.json")}"

            // atualiza a tarefa corrente para o status de "completo"
            render(status: 200, text: fullUrl)

        }
    }

    def generateTileSet(orientation) {
        // this method will execute 3 different shell scripts in order to create the cartas.png and the CSS that will be
        // automatically generated according to what the user has uploaded

        ////////////////////////////////////////////////////////////////////////////////////////
        // Params script concatenate
        // $1 = -v or -h (vertical or horizontal)
        // $2 = destino (facil, medio, dificil)
        // $3 = path for "tiles" directory

        // this script will create 3 different "decks" in a different image each
        def dataPath = servletContext.getRealPath("/data")
        def owner = session.user.id
        def taskID = session.taskId
        def instancePath = "${dataPath}/${springSecurityService.currentUser.id}/${taskID}"
        def tilesPath = "${instancePath}/tiles"

        def easyTilesIdList = Tile.findAllByDifficultyAndOwnerIdAndTaskId(1, owner, taskID)*.id
        def mediumTilesIdList = Tile.findAllByDifficultyAndOwnerIdAndTaskId(2, owner, taskID)*.id
        def hardTilesIdList = Tile.findAllByDifficultyAndOwnerIdAndTaskId(3, owner, taskID)*.id

        execConcatenate(
                "-${orientation}",
                "facil",
                easyTilesIdList,
                tilesPath
        )

        execConcatenate(
                "-${orientation}",
                "medio",
                mediumTilesIdList,
                tilesPath
        )

        execConcatenate(
                "-${orientation}",
                "dificil",
                hardTilesIdList,
                tilesPath
        )

        ////////////////////////////////////////////////////////////////////////////////////////
        // Parametros script Append
        // #$1 = tiles folder
        // #$2 = orientation

        // this script appends the "flipped" card to the final image
        def script_append = servletContext.getRealPath("/scripts/append.sh")

        def l2 = [
                tilesPath,
                orientation
        ]

        executarShell(script_append, l2)
        ////////////////////////////////////////////////////////////////////////////////////////
        // Parametros script sedSASS
        //#1 - full path for template.scss
        //#2 - full path for output.css
        //#3 - parametro que substituirá char_orientacao no script sass
        //#4 - parametro que substituirá facilPares no script sass
        //#5 - parametro que substituirá medioPares no script sass
        //#6 - parametro que substituirá dificilPares no script sass

        // this script will call the sass script, which will create the css file accordingly to our parameters
        def script_sedSASS = servletContext.getRealPath("/scripts/sed_sass.sh")

        def l3 = [
                servletContext.getRealPath("/scripts/template.scss"),
                "${instancePath}/output.css",
                orientation,
                String.valueOf(easyTilesIdList.size()),
                String.valueOf(mediumTilesIdList.size()),
                String.valueOf(hardTilesIdList.size())
        ]

        executarShell(script_sedSASS, l3)
    }

    def execConcatenate(orient, difficulty, idList, folder) {

        def script_concatenate_tiles = servletContext.getRealPath("/scripts/concatenate.sh")
        def l = [
                orient, // $1
                difficulty, // $2
                folder // $3
        ]

        // adding parameters to the script (name of the img files to be appended)
        // this 'for' needs to be done twice because of the order of the param files in the concatenate script
        for (id in idList)
            l.add("tile${id}-a.png")

        for (id in idList)
            l.add("tile${id}-b.png")

        executarShell(script_concatenate_tiles, l)

    }

    // the list has to contain the path to the sh file as its first element
    // and then the next elements will be the respective params for the script
    def executarShell(scriptName, execList) {
        def ant = new AntBuilder()

        def argLine = String.join(" ", execList);

        ant.sequential {
            chmod(perm: "+x", file: scriptName)
            exec(executable: scriptName) {
                arg(line: argLine)
            }
        }
        //def proc
        //proc = execList.execute()
        //proc.waitFor()
        //if (proc.exitValue()) {
        //    println "script ${execList.get(0)} gave the following error: "
        //    println "[ERROR] ${proc.getErrorStream()}"
        //}

    }

    // return list with filenames for images related to a tile pair
    def getTilesAudios(tileInstance) {
        def userPath = servletContext.getRealPath("/data/" + tileInstance.ownerId.toString() + "/" + ${session.taskId})
        def id = tileInstance.getId()
        def images = [
                "a": "$userPath/audio$id-a.png",
                "b": "$userPath/audio$id-b.png"
        ]

        return images
    }

    def recording() {
        def userId = session.user.getId()
        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File("${dataPath}/${userId}/${session.taskId}/recordings") // o nome do arquivo vai ser necessariamente audio.wav nessa configuração
        userPath.mkdirs()

        def audioUploaded = request.getFile('audio_data')

        if(!audioUploaded.isEmpty()) {
            def originalAudioUploaded = new File("$userPath/audio.wav")
            audioUploaded.transferTo(originalAudioUploaded)
        }

        render(status: 200, text: "http://${request.serverName}:${request.serverPort}/memoria/tile")
    }
}

