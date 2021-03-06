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

        render view: "index"
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
        tileInstance.taskId = session.taskId

        tileInstance.save flush: true

        def id = tileInstance.getId()
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/" + tileInstance.taskId.toString() + "/tiles")
        def userFolder = new File(userPath)
        def script_convert_png = servletContext.getRealPath("/scripts/convert.sh")
        userFolder.mkdirs()

        def f1Uploaded = request.getFile("tile-a")
        def f2Uploaded = request.getFile("tile-b")

        def errors = [
                not_image_file_a: false,
                not_image_file_b: false
        ]

        if (!f1Uploaded.fileItem.contentType.startsWith("image/")) {
            errors.not_image_file_a = true
        }


        if (!f2Uploaded.fileItem.contentType.startsWith("image/")) {
            errors.not_image_file_b = true
        }

        // if any of those files aren't images, we can't convert
        if (!(errors.not_image_file_a || errors.not_image_file_b)) {

            if (!f1Uploaded.isEmpty() && !f2Uploaded.isEmpty()) {

                def f1 = new File("$userPath/tile$id-a.png")
                def f2 = new File("$userPath/tile$id-b.png")

                f1Uploaded.transferTo(f1)
                f2Uploaded.transferTo(f2)

                // the convert script will convert the files to png even if they weren't uploaded as such
                // this was needed because the file wouldn't open as png if uploaded as other format
                executarShell(
                        script_convert_png,
                        [
                                f1.absolutePath,
                                f1.absolutePath
                        ]
                )

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
        def tiles = getTilesImages(tileInstance)

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
            render(status: 201, text: message.toString())
            return
        } else {
            // gera os arquivos: output.CSS e cartas.png
            generateTileSet(params.orientation)

            // encontra o endereço do arquivo criado
            def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")


            def fileName = "descricao.json"

            def fw = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream("$folder/$fileName"), "UTF-8"));

            def conteudo = new StringBuilder()
            conteudo << '{\n"descreveSobreGeral" : "Memória",\n'

            if (params.orientation == "v") {
                conteudo << '"direcao" : "vertical",\n'
            } else {
                conteudo << '"direcao" : "horizontal",\n'
            }

            def facilTiles = Tile.findAllByDifficultyAndOwnerIdAndTaskId(1, owner, session.taskId)
            def medioTiles = Tile.findAllByDifficultyAndOwnerIdAndTaskId(2, owner, session.taskId)
            def dificilTiles = Tile.findAllByDifficultyAndOwnerIdAndTaskId(3, owner, session.taskId)

            conteudo << '"totalParesFacilUpload" : ' + facilTiles.size() + ',\n'
            conteudo << '"totalParesMedioUpload" : ' + medioTiles.size() + ',\n'
            conteudo << '"totalParesDificilUpload" : ' + dificilTiles.size() + ',\n'


            conteudo << '"tempoCarta" : ' + 500 + ',\n'

            def stringNomes = new StringBuilder()
            stringNomes << '"nomeCarta": ['

            def stringDescricoes = new StringBuilder()
            stringDescricoes << '"descricaoCarta": ['

            def allTiles = new ArrayList<Tile>()
            allTiles.addAll(facilTiles)
            allTiles.addAll(medioTiles)
            allTiles.addAll(dificilTiles)

            for (Tile t : allTiles){
                stringNomes << '"' + t.content +'", '
                stringDescricoes << '"' + t.description + '", '
            }
            stringNomes.setLength(stringNomes.length() - 2) // deleting last space and comma
            stringNomes << ']'
            stringDescricoes.setLength(stringDescricoes.length() - 2) // deleting last space and comma
            stringDescricoes << ']'

            conteudo << stringNomes + ',\n'
            conteudo << stringDescricoes + '\n}'

            fw.write(conteudo.toString());
            fw.close();

            println conteudo.toString()

            log.debug folder
            def ids = []
            ids << MongoHelper.putFile("${folder}/output.css")
            ids << MongoHelper.putFile("${folder}/tiles/cartas.png")
            ids << MongoHelper.putFile("${folder}/descricao.json")

            //if (! new File(folder).deleteDir()){
            //    println("Erro em tentar excluir a pasta do usuario")
            //}

            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8080
            }

            // atualiza a tarefa corrente para o status de "completo"

            render(status: 200, text: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                    "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}")

            //redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
            //        "?files=${ids[0]}&files=${ids[1]}"
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
    def getTilesImages(tileInstance) {
        def userPath = servletContext.getRealPath("/data/" + tileInstance.ownerId.toString() + "/" + tileInstance.taskId.toString() + "/tiles")
        def id = tileInstance.getId()
        def images = [
                "a": "$userPath/tile$id-a.png",
                "b": "$userPath/tile$id-b.png"
        ]

        return images
    }

}
