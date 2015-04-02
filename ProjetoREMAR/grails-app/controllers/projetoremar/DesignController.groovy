package projetoremar

import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.h2.engine.User
import org.imgscalr.Scalr
import org.springframework.security.access.annotation.Secured

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['ROLE_PROF'])
@Transactional(readOnly = true)
class DesignController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Design.list(params), model: [designInstanceCount: Design.count()]
    }

    def show(Design designInstance) {
        respond designInstance
    }

    def create() {
        respond new Design(params)
    }

    def ShowImage(){
       def images = Design.get(params.id)
       byte[] image = images.icone

        response.contentType = "image/png"
        response.outputStream << image
        response.outputStream.flush()
        return

    }

    def VerifyAndUpload(originalUpload,storagePath){

        def imageIn = ImageIO.read(originalUpload)
        def name = originalUpload.getName()
        println "NAME: "+ name

        if((imageIn.getWidth() > 800)||imageIn.getHeight() > 600){
            println "Imagem muito grande, será redimensionada"
            BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, 600, 800, Scalr.OP_ANTIALIAS)
            def newImgUploaded = new File(storagePath+"/"+name)
            println newImgUploaded
            ImageIO.write(newImg, 'png', newImgUploaded)
            return false
        }
        else{
            println "Imagem nos conformes"
            return true
        }

    }



    @Transactional
    def ImagesManager() {
     //   def designInstance = new Design(params)

       // def webRoot = servletContext.getRealPath("/")
       // println webRoot

        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath("/")+"images"
        println storagePath


        def iconUploaded = request.getFile('icone')
        def openingUploaded = request.getFile('opening')
        def backgroundUploaded = request.getFile('background')

        if((!iconUploaded.isEmpty())||(!openingUploaded.isEmpty())||(!backgroundUploaded.isEmpty())) {

            def originalIconUploaded = new File(storagePath + '/icon.png')
            def originalOpeningUploaded = new File(storagePath + '/opening.png')
            def originalBackgroundUploaded = new File(storagePath + '/background.png')

            iconUploaded.transferTo(originalIconUploaded)
            openingUploaded.transferTo(originalOpeningUploaded)
            backgroundUploaded.transferTo(originalBackgroundUploaded)


            if (VerifyAndUpload(originalIconUploaded,storagePath)) {
                println "Imagem nos conformes"
                //iconUploaded.transferTo(new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/icon'))
            } else {
                println "Imagem redimensionada"
               // def deletedImage = originalIconUploaded.delete()
               // println deletedImage
            }

            if (VerifyAndUpload(originalOpeningUploaded,storagePath)) {
                println "Imagem nos conformes"
                //iconUploaded.transferTo(new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/opening'))
            } else {
                println "Imagem redimensionada"
            }


            if (VerifyAndUpload(originalBackgroundUploaded,storagePath)) {
                println "Imagem nos conformes"
               // iconUploaded.transferTo(new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/background'))
            } else {
                println "Imagem redimensionada"
            }

        }



            redirect(controller: "design", action:"index")



        println "IMAGES MANAGER"

    }


    @Transactional
    def save(Design designInstance) {
        if (designInstance == null) {
            notFound()
            return
        }

        if (designInstance.hasErrors()) {
            respond designInstance.errors, view: 'create'
            return
        }


        designInstance.save flush: true


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'design.label', default: 'Design'), designInstance.id])
                redirect designInstance
            }
            '*' { respond designInstance, [status: CREATED] }
        }
    }

    def edit(Design designInstance) {
        respond designInstance
    }

    @Transactional
    def update(Design designInstance) {
        if (designInstance == null) {
            notFound()
            return
        }

        if (designInstance.hasErrors()) {
            respond designInstance.errors, view: 'edit'
            return
        }

        designInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Design.label', default: 'Design'), designInstance.id])
                redirect designInstance
            }
            '*' { respond designInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Design designInstance) {

        if (designInstance == null) {
            notFound()
            return
        }

        designInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Design.label', default: 'Design'), designInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'design.label', default: 'Design'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
