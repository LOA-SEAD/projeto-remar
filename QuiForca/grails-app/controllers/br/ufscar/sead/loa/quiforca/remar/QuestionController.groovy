package br.ufscar.sead.loa.quiforca.remar

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonBuilder
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.form.TaskFormData

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["ROLE_PROF"])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    RuntimeService runtimeService
    TaskService taskService

    def index(Integer max) { // TODO: change to ModelAndView
        def user = springSecurityService.getCurrentUser()
//        params.max = Math.min(max ?: 10, 100)
        params.max = 100 // TODO
        respond Question.findAllByOwnerId(user.getId(), params), model:[questionInstanceCount: Question.count(), userName: user.getName(), userId: user.getId()]
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

        def list = Question.getAll(params.id? params.id.split(',').toList() : null)

        def builder = new JsonBuilder()

        def json = builder {
            nome "Forca"
            palavras list.collect {p ->
                ["palavra": p.getAnswer(),
                 "dica": p.getStatement(),
                 "contribuicao": p.getAuthor()]
            }
        }

//        render builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId())
        userPath.mkdirs()


        def fileName = "configuracao.json"

        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        redirect controller: "process", action: "complete", id: "ChooseQuestions"
    }
}
