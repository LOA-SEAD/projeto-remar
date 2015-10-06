package br.ufscar.sead.loa.quiforca.remar

import br.ufscar.sead.loa.remar.User
import groovy.json.JsonBuilder
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.imgscalr.Scalr
import org.springframework.security.access.annotation.Secured
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class ThemeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        if (params.p && params.t && params.h) {
            session.processId = params.p
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "theme"
            return
        }

        session.user = springSecurityService.currentUser

        if (params.review) {
            respond Theme.findAllByProcessIdAndTaskId(session.processId, session.taskId), model:[themeInstanceCount: Theme.count()]

        }
        respond Theme.list(), model:[themeInstanceCount: Theme.count()]
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

        themeInstance.processId = session.processId as long
        themeInstance.taskId    = session.taskId as long

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
            def originalOpeningUploaded = new File("$userPath/inicio.png")
            def originalBackgroundUploaded = new File("$userPath/papel.png")

            iconUploaded.transferTo(originalIconUploaded)
            openingUploaded.transferTo(originalOpeningUploaded)
            backgroundUploaded.transferTo(originalBackgroundUploaded)

            VerifyAndUpload(originalIconUploaded, userPath)
            VerifyAndUpload(originalOpeningUploaded, userPath)
            VerifyAndUpload(originalBackgroundUploaded, userPath)
        }

        redirect(controller: "Theme", action:"index")

    }

    def choose(Theme instance) {
        def list = []
        list.add(servletContext.getRealPath("/data/${instance.ownerId}/themes/${params.id}/inicio.png"))
        list.add(servletContext.getRealPath("/data/${instance.ownerId}/themes/${params.id}/papel.png"))
        list.add(servletContext.getRealPath("/data/${instance.ownerId}/themes/${params.id}/icon.png"))

        def builder = new JsonBuilder()
        def json = builder(
                "files": list
        )

        def file = new File(servletContext.getRealPath("/data/${session.user.id}/${session.taskId}"))
        file.mkdirs()
        file = new File("${file}/files.json")
        def pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        redirect uri: "http://${request.serverName}:${request.serverPort}/process/task/resolve/${session.taskId}", params: [json: file]
    }
}
