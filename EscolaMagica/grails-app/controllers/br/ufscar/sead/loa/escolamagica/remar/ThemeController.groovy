package br.ufscar.sead.loa.escolamagica.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment
import groovy.json.JsonBuilder

//import org.imgscalr.Scalr
import org.springframework.security.access.annotation.Secured
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder

//import javax.imageio.ImageIO
//import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*

@Secured(['IS_AUTHENTICATED_FULLY'])
class ThemeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    @Secured(['permitAll'])
    def index(Integer max) {
        if (params.t && params.h) {
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "theme"
            return
        } else {
            session.user = springSecurityService.currentUser
        }

        if (!Theme.findAllByOwnerId(session.user.id)) {
            def id = new Theme(ownerId: session.user.id).save(flush: true).id
            def samples = servletContext.getRealPath("/samples/tema-escola-magica-remar")
            def dir = servletContext.getRealPath("/data/${session.user.id}/themes/${id}")
            def ant = new AntBuilder()
            ant.sequential() {
                mkdir(dir: dir)
                copy(todir: dir) {
                    fileset(dir: samples)
                }
            }
        }

        respond Theme.findAllByOwnerId(session.user.id) , model:[themeInstanceCount: Theme.count()]
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

//    def VerifyAndUpload(originalUpload,storagePath){
//
//        def imageIn = ImageIO.read(originalUpload)
//        def name = originalUpload.getName()
//
//
//        if(originalUpload.toString().contains("icon")){
//
//            int[] sizes = [36,48,72,96,144,192]
//
//            for(int i=0; i<sizes.length; i++) {
//
//                BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, sizes[i], sizes[i], Scalr.OP_ANTIALIAS)
//                name = "icon" + sizes[i] + ".png"
//                def newImgUploaded = new File("$storagePath/$name")
//                ImageIO.write(newImg, 'png', newImgUploaded)
//
//            }
//
//
//        }
//
//
//        if((imageIn.getWidth() > 800)||imageIn.getHeight() > 600){
//            BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, 600, 800, Scalr.OP_ANTIALIAS)
//            def newImgUploaded = new File("$storagePath/$name")
//            ImageIO.write(newImg, 'png', newImgUploaded)
//            return false
//        }
//        else{
//            return true
//        }
//
//    }


    @Transactional
    def ImagesManager() { // TODO: fix var names + optimize
        def userId = springSecurityService.getCurrentUser().getId()

        def theme = new Theme(ownerId: userId, processId: session.processId, taskId: session.taskId).save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/themes/" + theme.getId())
        userPath.mkdirs()

//        def iconUploaded = request.getFile('icone')
//        def openingUploaded = request.getFile('opening')
//        def backgroundUploaded = request.getFile('background')

        def a0Uploaded = request.getFile("a-0")
        def a1Uploaded = request.getFile("a-1")
        def b0Uploaded = request.getFile("b-0")
        def b1Uploaded = request.getFile("b-1")
        def c0Uploaded = request.getFile("c-0")
        def c1Uploaded = request.getFile("c-1")


        if(!a0Uploaded.isEmpty() || !a1Uploaded.isEmpty() || !b0Uploaded.isEmpty() ||
           !b1Uploaded.isEmpty() || !c0Uploaded.isEmpty() || !c1Uploaded.isEmpty()) {

            def a0 = new File("$userPath/portaa-sheet0.png")
            def a1 = new File("$userPath/portaa-sheet1.png")
            def b0 = new File("$userPath/portab-sheet0.png")
            def b1 = new File("$userPath/portab-sheet1.png")
            def c0 = new File("$userPath/portac-sheet0.png")
            def c1 = new File("$userPath/portac-sheet1.png")

            a0Uploaded.transferTo(a0)
            a1Uploaded.transferTo(a1)
            b0Uploaded.transferTo(b0)
            b1Uploaded.transferTo(b1)
            c0Uploaded.transferTo(c0)
            c1Uploaded.transferTo(c1)

//            VerifyAndUpload(originalIconUploaded, userPath)
//            VerifyAndUpload(originalOpeningUploaded, userPath)
//            VerifyAndUpload(originalBackgroundUploaded, userPath)
        }

        redirect(controller: "Theme", action:"index")

    }

    def choose() {
        def files
        def folder = servletContext.getRealPath("/data/${Theme.get(params.id).ownerId}/themes/${params.id}")
        files = "?files=" + MongoHelper.putFile("${folder}/portaa-sheet0.png")
        for (name in ["portaa-sheet1", "portab-sheet0", "portab-sheet1", "portac-sheet0", "portac-sheet1"]) {
            files += "&files=" + MongoHelper.putFile("${folder}/${name}.png")
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}${files}"
    }
}
