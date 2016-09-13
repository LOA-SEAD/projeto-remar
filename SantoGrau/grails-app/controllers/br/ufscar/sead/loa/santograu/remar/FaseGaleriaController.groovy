package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.apache.tools.ant.util.FileUtils

@Secured(["isAuthenticated()"])
class FaseGaleriaController {
    def springSecurityService

    static allowedMethods = [save: "POST", saveLevel: "PUT", update: "PUT", delete: "DELETE", deleteTheme: "DELETE", imagesManager: "POST", exportLevel:"POST"]

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
        FaseGaleria faseGaleriaInstance = new FaseGaleria()
        faseGaleriaInstance.orientacao = params.orientacao
        faseGaleriaInstance.themeId = Long.parseLong(params.themeId)
        faseGaleriaInstance.ownerId = session.user.id as long
        faseGaleriaInstance.taskId = session.taskId as String
        faseGaleriaInstance.save flush:true

        redirect(action: "index")
    }

    def saveFaseGaleria(FaseGaleria faseGaleriaInstance) {
        faseGaleriaInstance.save flush:true
    }

    def saveLevel() {
        println "entrou save -----------------";
        println "orientacoes: " + params.orientacao
        FaseGaleria faseGaleriaInstance = new FaseGaleria()

        //faseGaleriaInstance.save flush:true
        redirect(action: "index")
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
        }

        redirect(action:"index")

    }

    @Secured(['permitAll'])
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
        createJsonFile("Quadros.json", faseGaleria)

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
