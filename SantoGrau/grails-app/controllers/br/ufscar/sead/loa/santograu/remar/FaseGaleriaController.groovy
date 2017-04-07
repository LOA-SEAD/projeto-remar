package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import org.apache.tools.ant.util.FileUtils
import grails.transaction.Transactional
import static java.awt.RenderingHints.*
import java.awt.image.BufferedImage
import grails.util.Environment
import groovy.json.JsonSlurper
import javax.imageio.ImageIO

@Transactional(readOnly = true)

@Secured(["isAuthenticated()"])


class FaseGaleriaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", deleteTheme: "DELETE", imagesManager: "POST", exportLevel:"POST"]

    def beforeInterceptor = [action: this.&check, only: ['index', 'imagesManager','deleteTheme', 'imagesManager', 'exportLevel']]

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

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }

        session.user = springSecurityService.currentUser
        def list = ThemeFaseGaleria.findAllByOwnerId(session.user.id)
        String orientacao = ""
        if(params.orientacao) {
            orientacao = params.orientacao
        }

        render view: "index", model: [themeFaseGaleriaInstanceList: list, orientacao: orientacao]
    }

    def show(FaseGaleria faseGaleriaInstance) {
        respond faseGaleriaInstance
    }

    def create() {
        render view: "create", model: [orientacao: params.orientacao]
        //respond new FaseGaleria(params)
    }

    @Transactional
    def save() {
        //cria a instancia da fase galeria com os valores inseridos pelo usuario
        FaseGaleria faseGaleria = new FaseGaleria()
        faseGaleria.themeId = Long.parseLong(params.radio)
        faseGaleria.orientacao = params.orientacao
        faseGaleria.ownerId = session.user.id as long
        faseGaleria.taskId = session.taskId as String

        redirect(action: "index")
    }

    def saveFaseGaleria(FaseGaleria faseGaleriaInstance) {
        faseGaleriaInstance.save flush:true
    }


    def edit(FaseGaleria faseGaleriaInstance) {
        respond faseGaleriaInstance
    }

    @Transactional
    def update(FaseGaleria faseGaleriaInstance) {
        if (faseGaleriaInstance == null) {
            notFound()
            return
        }

        if (faseGaleriaInstance.hasErrors()) {
            respond faseGaleriaInstance.errors, view:'edit'
            return
        }

        faseGaleriaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FaseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect faseGaleriaInstance
            }
            '*'{ respond faseGaleriaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FaseGaleria faseGaleriaInstance) {

        if (faseGaleriaInstance == null) {
            notFound()
            return
        }

        faseGaleriaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }


    @Transactional
    def deleteTheme(ThemeFaseGaleria themeFaseGaleriaInstance) {

        if (themeFaseGaleriaInstance == null) {
            notFound()
            return
        }

        themeFaseGaleriaInstance.delete flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseGaleria.label', default: 'FaseGaleria'), faseGaleriaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseGaleria.label', default: 'FaseGaleria'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional
    def imagesManager() {
        def imagesUploaded = []
        int qtsImagens=0;
        for(def i=1;i<=10;i++) {
            def caminhoImg = "img-" + i
            if(request.getFile(caminhoImg) != null && request.getFile(caminhoImg).size > 0) {
                imagesUploaded[qtsImagens++] = request.getFile(caminhoImg);
            }
        }

        def theme = new ThemeFaseGaleria(ownerId: session.user.id, taskId: session.taskId, howManyImages: qtsImagens).save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + session.user.id + "/themes/" + theme.getId())
        userPath.mkdirs()

        for(def i=1;i<=qtsImagens;i++) {
            def image = new File("$userPath/image" + i + ".png")
            imagesUploaded[i-1].transferTo(image)
            resizeImage(userPath, i)
        }

        redirect(actixon:"index", params: [orientacao:params.orientacao])

    }

    def resizeImage(userPath, i) {
        int newWidth = 160
        int newHeight = 200
        def newImage = ImageIO.read(new File("$userPath/image" + i + ".png"))
        try {
            new BufferedImage( newWidth, newHeight, newImage.type ).with { img ->
                createGraphics().with {
                    setRenderingHint( KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC )
                    drawImage( newImage, 0, 0, newWidth, newHeight, null )
                    dispose()
                }
                ImageIO.write( img, 'png', new File("$userPath/image" + i + ".png"))
            }
        } catch (Exception e) {
            println e.message
        }
    }

    @Transactional
    def exportLevel(){
        //cria a instancia da fase galeria com os valores inseridos pelo usuario
        FaseGaleria faseGaleria = new FaseGaleria()
        faseGaleria.themeId = Long.parseLong(params.themeId)
        faseGaleria.orientacao = params.orientacao
        faseGaleria.ownerId = session.user.id as long
        faseGaleria.taskId = session.taskId as String

        //salva os dados da fase no BD
        saveFaseGaleria(faseGaleria)

        //cria o arquivo json da fase
        createJsonFile("quadros.json", faseGaleria)

        // Finds the created file path
        def id
        def files = "?"
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        def fasesFolder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/processes/${session.processId}")
        id = MongoHelper.putFile("${folder}/quadros.json")
        files += "files=${id}&"
        id = MongoHelper.putFile("${fasesFolder}/fases.json")
        files += "files=${id}&"
        ThemeFaseGaleria.findById(faseGaleria.themeId).howManyImages.times {
            id = MongoHelper.putFile("${folder}/${it + 1}.png")
            files += "files=${id}&"
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        // Updates current task to 'completed' status
        render "http://${request.serverName}:${port}/process/task/complete/${session.taskId}${files}"

    }

    void createJsonFile(String fileName, FaseGaleria faseGaleria){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        def fasesFolder = new File("${dataPath}/${springSecurityService.currentUser.id}/processes/${session.processId}")
        instancePath.mkdirs()
        fasesFolder.mkdirs()

        def theme = ThemeFaseGaleria.findById(faseGaleria.themeId)
        saveImages(theme, instancePath)

        File file = new File("$instancePath/"+fileName);
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n")
        pw.write("\t\"numero\": [\"" + theme.howManyImages + "\"],\n")
        pw.write("\t\"resposta\": [\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\", \"10\"],\n")
        pw.write("\t\"dicaOrdenacao\": [\"" + faseGaleria.orientacao +"\"]\n")
        pw.write("}")
        pw.close()

        //adiciona a fase galeria no arquivo fases.json
        File fileFasesJson = new File("$fasesFolder/fases.json")
        boolean exists = fileFasesJson.exists()
        if(!exists) {
            PrintWriter printer = new PrintWriter(fileFasesJson)
            printer.write("{\n")
            printer.write("\t\"quantidade\": [\"1\"],\n")
            printer.write("\t\"fases\": [\"2\", \"1\"]\n")
            printer.write("}\n")
            printer.close()
        } else {
            def arq = new JsonSlurper().parseText(fileFasesJson.text)
            PrintWriter printer = new PrintWriter(fileFasesJson)
            printer.write("{\n")

            if(arq["quantidade"][0] == "0") {
                printer.write("\t\"quantidade\": [\"1\"],\n")
                printer.write("\t\"fases\": [\"2\", \"1\"]\n")
            } else {
                printer.write("\t\"quantidade\": [\"2\"],\n")
                printer.write("\t\"fases\": [\"1\", \"2\"]\n")
            }

            printer.write("}")
            printer.close()
        }
    }

    void saveImages(ThemeFaseGaleria theme, path) {
        def dataPath = servletContext.getRealPath("/data")
        def dstPath = "/" + session.user.id + "/" + session.taskId
        def srcPath = "/" + session.user.id + "/themes/" + theme.getId()
        path.mkdirs()

        FileUtils file = new FileUtils()
        for(def i=1;i<=theme.howManyImages;i++) {
            try {
                def src = new File(dataPath, srcPath + "/image" + i + ".png")
                def dst = new File(dataPath, dstPath + "/" + i + ".png")
                file.copyFile(src, dst)
            } catch(Exception e) {
                println e.message
            }
        }
    }
}
