package br.ufscar.sead.loa.quiforca.remar

import br.ufscar.sead.loa.remar.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Holders
import groovy.json.JsonBuilder
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["IS_AUTHENTICATED_FULLY"])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    def grailsApplication

    @Secured(["permitAll"])
    def index(Integer max) { // TODO: change to ModelAndView
        def user = springSecurityService.getCurrentUser()
//        params.max = Math.min(max ?: 10, 100)
        params.max = 100 // TODO

        if (params.p && params.t && params.h) {
            session.processId = params.p
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "question"
        }

        println session.processId
        println session.taskId

        def list = Question.findAllByProcessIdAndTaskId(session.processId, session.taskId)
        render view:"index", model:[questionInstanceList: list, questionInstanceCount: Question.count(), userName: user.getName(), userId: user.getId()]

    }

    /*def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
        respond new Question(params)
    }*/

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            // respond questionInstance.errors, view:'create' TODO
            render questionInstance.errors;
            return
        }

        questionInstance.processId = session.processId as long
        questionInstance.taskId    = session.taskId as long

        questionInstance.save flush:true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

       /* request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: CREATED] }
        }*/
    }

    /*def edit(Question questionInstance) {
        respond questionInstance
    }*/

    @Transactional
    def update(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            // respond questionInstance.errors, view:'edit' TODO
            return
        }

        questionInstance.save flush:true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*'{ respond questionInstance, [status: OK] }
        }*/
    }

    @Transactional
    def delete(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        questionInstance.delete flush:true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def toJson() {

        def list = Question.getAll(params.id ? params.id.split(',').toList() : null)

        def builder = new JsonBuilder()

        def json = builder(
                list.collect { p ->
                    ["palavra"     : p.getAnswer().toUpperCase(),
                     "dica"        : p.getStatement(),
                     "contribuicao": p.getAuthor()]
                }
        )

        println builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()


        def fileName = "palavras.json"

        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        json = builder(
                "files": [
                        file.absolutePath
                ]

        )

        println builder.toString()
        file = new File("${file.parentFile}/files.json")
        pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        redirect uri: "http://${request.serverName}:${request.serverPort}/process/task/resolve/${session.taskId}", params: [json: file]
    }

    def test() {

        def builder = new JsonBuilder()
        def files = []
        files.add("123")
        files.add("456")
        files.add("789")
        def json = builder(
                files: ["123", "123333", "1343443"]
        )

        println builder.toString()
    }
}
