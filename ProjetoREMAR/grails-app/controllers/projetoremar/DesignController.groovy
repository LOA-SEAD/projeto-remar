package projetoremar

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

    @Transactional
    def ImagesManager() {
     //   def designInstance = new Design(params)

        def iconUploaded = request.getFile('icone')
        def openingUploaded = request.getFile('opening')
        def backgroundUploaded = request.getFile('background')

       //iconUploaded.transferTo(new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/icon.png'))
        openingUploaded.transferTo(new File("/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/open.png"))
        backgroundUploaded.transferTo(new File("//home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/background.png"))

        def originalIconUploaded = new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/icon.png')


        iconUploaded.transferTo(originalIconUploaded)

        def imageIn = ImageIO.read(originalIconUploaded)

        if(!(iconUploaded)||!(openingUploaded)||!(backgroundUploaded)) {
            def height = imageIn.getHeight()
            def width = imageIn.getWidth()

            if ((height > 600) || (width > 800)) {
                println "Imagem muito grande, será redimensionada"
                BufferedImage largeImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, 600, 800, Scalr.OP_ANTIALIAS)
                def largImgUploaded = new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/iconResized.png')
                ImageIO.write(largeImg, 'png', largImgUploaded)

            } else if ((height < 600) || (width < 800)) {
                println "Imagem mt pequena ( oque fazer) ? :("          //TODO
            } else {
                println "Imagem nos conformes"
                iconUploaded.transferTo(new File('/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/icon.png'))
                openingUploaded.transferTo(new File("/home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/open.png"))
                backgroundUploaded.transferTo(new File("//home/loa/Denis/REMAR/ProjetoREMAR/grails-app/assets/images/background.png"))

            }
        }
        else{
            redirect(controller: "design", action:"index")
        }


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
