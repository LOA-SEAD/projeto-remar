package br.ufscar.sead.loa.escolamagica.remar

import br.ufscar.sead.loa.remar.User
import grails.plugin.springsecurity.annotation.Secured
import grails.web.JSONBuilder
import groovy.json.JsonBuilder
import groovy.xml.MarkupBuilder
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder

//import org.camunda.bpm.engine.RuntimeService
//import org.codehaus.groovy.grails.web.context.ServletContextHolder
//import org.springframework.web.context.request.RequestContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

//@Secured(["IS_AUTHENTICATED_FULLY"])
class QuestionController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        if (params.p && params.t && params.h) {
            session.processId = params.p
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "question"
        }

        def list = Question.findAllByProcessIdAndTaskId(session.processId, session.taskId)

        if(!list) {
            new Question(title: 'Questão 1 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                         correctAnswer: 0, level: 1, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 2 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                         correctAnswer: 0, level: 1, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 3 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                         correctAnswer: 0, level: 1, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 4 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                         correctAnswer: 0, level: 1, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 5 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                         correctAnswer: 0, level: 1, processId: session.processId, taskId: session.taskId).save flush: true

            new Question(title: 'Questão 1 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 2 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 3 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 4 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 5 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, processId: session.processId, taskId: session.taskId).save flush: true

            new Question(title: 'Questão 1 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 2 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 3 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 4 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, processId: session.processId, taskId: session.taskId).save flush: true
            new Question(title: 'Questão 5 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, processId: session.processId, taskId: session.taskId).save flush: true
        }

        respond Question.findAllByProcessIdAndTaskId(session.processId, session.taskId), model: [questionInstanceCount: Question.count()]
    }

    def confirming() {
        println params.id
        //redirect(controller: "process",action: "completeTask", id: "confirming")
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
        respond new Question(params)
    }

    def createXML() {

        //   def servletContext = ServletContextHolder.servletContext
        //  def storagePath = servletContext.getRealPath("/")
        //   println storagePath

        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()
        println instancePath

        def fw = new FileWriter("$instancePath/perguntas.xml")
        def xml = new MarkupBuilder(fw)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "utf-8")
        xml.Perguntas() {
            for (int i = 0; i < 4; i++) {
                def questionList = Question.findAllByLevelAndProcessIdAndTaskId(i + 1, session.processId, session.taskId)
                if (!questionList.isEmpty()) {
                    int j = 0
                    int k = 0
                    int l = 0
                    Classe(ClaAno: i + 1) {
                        while (!questionList.isEmpty()) {
                            Pergunta(PergNum: k, respCorreta: questionList.get(l).getCorrectAnswer(), titulo: questionList.get(j).getTitle()) {
                                Resp(num: '0', questionList.get(l).getAnswers()[0])
                                Resp(num: '1', questionList.get(l).getAnswers()[1])
                                Resp(num: '2', questionList.get(l).getAnswers()[2])
                                Resp(num: '3', questionList.get(l).getAnswers()[3])
                            }
                            questionList.remove(j)
                            k++
                        }

                    }
                }

            }

        }

        def builder = new JsonBuilder()
        def json = builder(
                "files": [
                        "${instancePath}/perguntas.xml"
                ]
        )

        def file = new File("${instancePath}/files.json")
        def pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();

        redirect uri: "http://${request.serverName}:${request.serverPort}/process/task/resolve/${session.taskId}", params: [json: file]

    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create'
            return
        }

        questionInstance.processId = session.processId as long
        questionInstance.taskId = session.taskId as long

        questionInstance.save flush: true


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Questão'), questionInstance.id])
                redirect(action: "index")
            }
            '*' { respond questionInstance, [status: CREATED] }
        }

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
            respond questionInstance.errors, view: 'edit'
            return
        }

        questionInstance.save flush: true

        redirect action: "index"
    }

    @Transactional
    def delete(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        questionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Questão'), questionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Questão'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
