package br.ufscar.sead.loa.quiforca.remar

import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.imgscalr.Scalr
import org.springframework.security.access.annotation.Secured

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['ROLE_PROF'])
@Transactional(readOnly = true)
class ThemeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Theme.findAllByOwnerId(springSecurityService.getCurrentUser().getId(), params), model:[themeInstanceCount: Theme.count()]
    }

    def show(Theme themeInstance) {
        respond themeInstance
    }

    def create() {
        respond new Theme(params)
    }

    @Transactional
    def save(Theme themeInstance) {


        if (themeInstance == null) {
            notFound()
            return
        }

        if (themeInstance.hasErrors()) {
            respond themeInstance.errors, view:'create'
            return
        }

        themeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'theme.label', default: 'Theme'), themeInstance.id])
                redirect themeInstance
            }
            '*' { respond themeInstance, [status: CREATED] }
        }
    }

    def edit(Theme themeInstance) {
        respond themeInstance
    }

    @Transactional
    def update(Theme themeInstance) {
        if (themeInstance == null) {
            notFound()
            return
        }

        if (themeInstance.hasErrors()) {
            respond themeInstance.errors, view:'edit'
            return
        }

        themeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Theme.label', default: 'Theme'), themeInstance.id])
                redirect themeInstance
            }
            '*'{ respond themeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Theme themeInstance) {

        if (themeInstance == null) {
            notFound()
            return
        }

        themeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Theme.label', default: 'Theme'), themeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'theme.label', default: 'Theme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def ShowImage(){
        def images = Theme.get(params.id)
        byte[] image = images.icone

        response.contentType = "image/png"
        response.outputStream << image
        response.outputStream.flush()
        return

    }

    def VerifyAndUpload(originalUpload,storagePath){

        def imageIn = ImageIO.read(originalUpload)
        def name = originalUpload.getName()


        if(originalUpload.toString().contains("icon")){

            int[] sizes = [36,48,72,96,144,192]

            for(int i=0; i<sizes.length; i++) {

                BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, sizes[i], sizes[i], Scalr.OP_ANTIALIAS)
                name = "icon" + sizes[i] + ".png"
                def newImgUploaded = new File("$storagePath/$name")
                ImageIO.write(newImg, 'png', newImgUploaded)

            }


        }


        if((imageIn.getWidth() > 800)||imageIn.getHeight() > 600){
            BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, 600, 800, Scalr.OP_ANTIALIAS)
            def newImgUploaded = new File("$storagePath/$name")
            ImageIO.write(newImg, 'png', newImgUploaded)
            return false
        }
        else{
            return true
        }

    }


    @Transactional
    def ImagesManager() { // TODO: fix var names + optimize
        def userId = springSecurityService.getCurrentUser().getId()

        def theme = new Theme(ownerId: userId).save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/themes/" + theme.getId())
        userPath.mkdirs()

        def iconUploaded = request.getFile('icone')
        def openingUploaded = request.getFile('opening')
        def backgroundUploaded = request.getFile('background')

        if((!iconUploaded.isEmpty())||(!openingUploaded.isEmpty())||(!backgroundUploaded.isEmpty())) {

            def originalIconUploaded = new File("$userPath/icon.png")
            def originalOpeningUploaded = new File("$userPath/opening.png")
            def originalBackgroundUploaded = new File("$userPath/background.png")

            iconUploaded.transferTo(originalIconUploaded)
            openingUploaded.transferTo(originalOpeningUploaded)
            backgroundUploaded.transferTo(originalBackgroundUploaded)

            VerifyAndUpload(originalIconUploaded, userPath)
            VerifyAndUpload(originalOpeningUploaded, userPath)
            VerifyAndUpload(originalBackgroundUploaded, userPath)
        }

        redirect(controller: "Theme", action:"index")

    }

    def choose() {
        session.themeId = params.id
        redirect controller: "process", action: "complete", id: "ChooseTheme"
    }
}
