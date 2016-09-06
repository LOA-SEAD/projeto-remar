package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseGaleriaController {
    def springSecurityService

    static allowedMethods = [save: "POST", saveLevel: "PUT", update: "PUT", delete: "DELETE", deleteTheme: "DELETE", imagesManager: "POST"]

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
}
