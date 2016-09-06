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

        def theme = new ThemeFaseGaleria(ownerId: session.user.id, taskId: session.taskId).save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + session.user.id + "/themes/" + theme.getId())
        userPath.mkdirs()

//        def iconUploaded = request.getFile('icone')
//        def openingUploaded = request.getFile('opening')
//        def backgroundUploaded = request.getFile('background')

        def img1Uploaded = request.getFile("img-1")
        def img2Uploaded = request.getFile("img-2")
        def img3Uploaded = request.getFile("img-3")
        def img4Uploaded = request.getFile("img-4")



        if(!img1Uploaded.isEmpty() || !img2Uploaded.isEmpty() || !img3Uploaded.isEmpty() ||
                !img4Uploaded.isEmpty()) {

            def img1 = new File("$userPath/image1.png")
            def img2 = new File("$userPath/image2.png")
            def img3 = new File("$userPath/image3.png")
            def img4 = new File("$userPath/image4.png")

            img1Uploaded.transferTo(img1)
            img2Uploaded.transferTo(img2)
            img3Uploaded.transferTo(img3)
            img4Uploaded.transferTo(img4)


//            VerifyAndUpload(originalIconUploaded, userPath)
//            VerifyAndUpload(originalOpeningUploaded, userPath)
//            VerifyAndUpload(originalBackgroundUploaded, userPath)
        }

        redirect(action:"index")

    }
}
