package projetoremar

import org.springframework.security.access.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['ROLE_PROF'])
@Transactional(readOnly = true)
class PalavrasController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {

        def user = springSecurityService.getCurrentUser()
        params.max = Math.min(max ?: 10, 100)
        respond Palavras.list(params), model:[palavrasInstanceCount: Palavras.count(), user_name: user.getName()]

    }

    def show(Palavras palavrasInstance) {
        respond palavrasInstance
    }

    def create() {
        respond new Palavras(params)
    }

    @Transactional
    def save(Palavras palavrasInstance) {
        if (palavrasInstance == null) {
            notFound()
            return
        }

        if (palavrasInstance.hasErrors()) {
            respond palavrasInstance.errors, view:'create'
            return
        }

        palavrasInstance.save flush:true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                palavrasInstance
            }
        } else {
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'palavras.label', default: 'Palavras'), palavrasInstance.id])
                    redirect palavrasInstance
                }
                '*' { respond palavrasInstance, [status: CREATED] }
            }
        }
    }

    def edit(Palavras palavrasInstance) {
        respond palavrasInstance
    }

    @Transactional
    def update(Palavras palavrasInstance) {
        if (palavrasInstance == null) {
            notFound()
            return
        }

        if (palavrasInstance.hasErrors()) {
            respond palavrasInstance.errors, view:'edit'
            return
        }

        palavrasInstance.save flush:true


        if (request.isXhr()) {
            render(contentType: "application/json") {
                palavrasInstance
            }
        } else {

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'Palavras.label', default: 'Palavras'), palavrasInstance.id])
                    redirect palavrasInstance
                }
                '*' { respond palavrasInstance, [status: OK] }
            }
        }
    }

    def newJson() {



        def webRoot = servletContext.getRealPath("/")
        def directory = new File(webRoot, "/Questoes")
        directory.mkdirs();

        def list = Palavras.list()
        println list.getClass()
        def fileName = 'palavras.json'

        //def jsonBuilder = new JsonBuilder()
        //  jsonBuilder(palavras: Palavras)
        // println (jsonBuilder.toPrettyString())
        // jsonBuilder.writeTo("/home/loa/Denis/ProjetoREMAR/web-app/Questoes/palavras.json")
        //def jsonFile = new File("/home/loa/Denis/ProjetoREMAR/web-app/Questoes/palavras.json")
        // jsonFile.createNewFile()


        FileUtils.writeToFile(directory, fileName, list)


        response.contentType = "application/text"
        response.setHeader("Content-Disposition", "attachment;filename=\"${fileName}\"")
        response.setHeader("Content-Length", "${file.size()}")
        response.setHeader("Cache-Control", "must-revalidate")
        response.outputStream << file.newInputStream()

        println "download metodo"
    }

    @Transactional
    def delete(Palavras palavrasInstance) {

        if (palavrasInstance == null) {
            notFound()
            return
        }

        palavrasInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Palavras.label', default: 'Palavras'), palavrasInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'palavras.label', default: 'Palavras'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
