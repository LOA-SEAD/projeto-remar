package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.apache.tools.ant.util.FileUtils
import static java.awt.RenderingHints.*
import java.awt.image.BufferedImage
import javax.imageio.ImageIO

@Secured(["isAuthenticated()"])
class FaseGaleriaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", deleteTheme: "DELETE", imagesManager: "POST", exportLevel:"POST"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        def list = ThemeFaseGaleria.findAllByOwnerId(session.user.id)

        render view: "index", model: [themeFaseGaleriaInstanceList: list]
    }

    def show(FaseGaleria faseGaleriaInstance) {
        respond faseGaleriaInstance
    }

    def create() {
        respond new FaseGaleria(params)
    }

    @Transactional
    def save() {
        //cria a instancia da fase galeria com os valores inseridos pelo usuario
        FaseGaleria faseGaleria = new FaseGaleria()
        faseGaleria.themeId = Long.parseLong(params.radio)
        faseGaleria.orientacao = params.orientacao
        faseGaleria.ownerId = session.user.id as long
        faseGaleria.taskId = session.taskId as String

        //salva os dados da fase no BD
        saveFaseGaleria(faseGaleria)

        //cria o arquivo json da fase
        createJsonFile("quadros.json", faseGaleria)

        respond new FaseGaleria(params)
        //def ids = []
        //def folder = servletContext.getRealPath("/data/${session.user.id}/${session.taskId}")

        //ids << MongoHelper.putFile(folder + '/computadores.json')

        //def port = request.serverPort
        //if (Environment.current == Environment.DEVELOPMENT) {
        //    port = 8080
        //}

        //render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
        //       "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"

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
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

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

//        def iconUploaded = request.getFile('icone')
//        def openingUploaded = request.getFile('opening')
//        def backgroundUploaded = request.getFile('background')

        for(def i=1;i<=qtsImagens;i++) {
            def image = new File("$userPath/image" + i + ".png")
            imagesUploaded[i-1].transferTo(image)
            resizeImage(userPath, i)
        }

        redirect(action:"index")

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

    @Secured(['permitAll'])
    def exportLevel(){
        //cria a instancia da fase galeria com os valores inseridos pelo usuario
        FaseGaleria faseGaleria = new FaseGaleria()
        faseGaleria.themeId = Long.parseLong(params.radio)
        faseGaleria.orientacao = params.orientacao
        faseGaleria.ownerId = session.user.id as long
        faseGaleria.taskId = session.taskId as String

        //salva os dados da fase no BD
        saveFaseGaleria(faseGaleria)

        //cria o arquivo json da fase
        createJsonFile("quadros.json", faseGaleria)

        respond new FaseGaleria(params)
        //def ids = []
        //def folder = servletContext.getRealPath("/data/${session.user.id}/${session.taskId}")

        //ids << MongoHelper.putFile(folder + '/computadores.json')

        //def port = request.serverPort
        //if (Environment.current == Environment.DEVELOPMENT) {
        //    port = 8080
        //}

        //render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
        //       "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"


    }

    void createJsonFile(String fileName, FaseGaleria faseGaleria){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

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
        File fileFasesJson = new File("$instancePath/fases.json")
        boolean exists = fileFasesJson.exists()
        if(!exists) {
            PrintWriter printer = new PrintWriter(fileFasesJson);
            printer.write("{\n");
            printer.write("\t\"quantidade\": [\"1\"],\n")
            printer.write("\t\"fases\": [\"2\", \"1\"]\n")
            printer.write("}")
            printer.close();
        } else {
            def arq = new JsonSlurper().parseText(new File("$instancePath/fases.json").text)
            PrintWriter printer = new PrintWriter(fileFasesJson);
            printer.write("{\n");

            if(arq["quantidade"][0] == "0") {
                printer.write("\t\"quantidade\": [\"1\"],\n")
                printer.write("\t\"fases\": [\"2\", \"1\"]\n")

            } else {
                printer.write("\t\"quantidade\": [\"2\"],\n")
                printer.write("\t\"fases\": [\"1\", \"2\"]\n")
            }

            printer.write("}")
            printer.close();
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
