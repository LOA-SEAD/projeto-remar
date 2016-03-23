package br.ufscar.sead.loa.quiforca.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.util.Holders
import groovy.json.JsonBuilder
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.MultipartFile

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

        if (params.t && params.h) {
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "question" // redirect to hide params.h
            return
        }

        def list = Question.list()
        render view: "index", model: [questionInstanceList: list, questionInstanceCount: Question.count(), userName: user.getUsername(), userId: user.getId()]

    }

    /*def show(Question questionInstance) {
        respond questionInstance
    }*/

    def create() {
        respond new Question(params)
    }

    @Transactional
    def newQuestion(Question questionInstance) {
        if (questionInstance.author == null) {
            def user = springSecurityService.currentUser.id
            User currentUser = User.findById(user)
            //println(currentUser.username.toString())
            questionInstance.author = new String();
            questionInstance.author = currentUser.username.toString()
        }

        Question newQuest = new Question();
        newQuest.id = questionInstance.id
        newQuest.statement = questionInstance.statement
        newQuest.answer = questionInstance.answer
        newQuest.author = questionInstance.author
        newQuest.category = questionInstance.category
        newQuest.taskId    = session.taskId as String

        if (newQuest.hasErrors()) {
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

        newQuest.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newQuest.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())


    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }




        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create' //TODO
            render questionInstance.errors;
            return
        }

        questionInstance.taskId = session.taskId as String

        questionInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())

       /* request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: CREATED] }
        }*/
    }

    def edit(Question questionInstance) {
        respond questionInstance
    }

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

        questionInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())

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

        questionInstance.delete flush: true

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
            '*' { render status: NOT_FOUND }
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

        log.debug builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()


        def fileName = "palavras.json"

        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    @Transactional
    def generateQuestions() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username



        csv.inputStream.eachCsvLine { row ->


            Question questionInstance = new Question()
            questionInstance.statement = row[0] ?: "NA";
            questionInstance.answer = row[1] ?: "NA";
            questionInstance.category = row[2] ?: "NA";
            questionInstance.author = username
            questionInstance.taskId = session.taskId as String

            if (questionInstance.hasErrors()) {

            }
            else{
                questionInstance.save flush: true
            }

        }

        redirect(action: index())

    }
}
