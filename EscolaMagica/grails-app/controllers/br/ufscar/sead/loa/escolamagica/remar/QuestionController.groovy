package br.ufscar.sead.loa.escolamagica.remar


import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.context.request.RequestContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["IS_AUTHENTICATED_FULLY"])
@Transactional(readOnly = true)
class QuestionController {

    RuntimeService runtimeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Question.list(params), model: [questionInstanceCount: Question.count()]
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

        def session = RequestContextHolder.currentRequestAttributes().getSession()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + session.userId)
        userPath.mkdirs()
        println userPath

        def fw = new FileWriter("$userPath/perguntas.xml")
        //def fw = new FileWriter(storagePath+"perguntas.xml")
        //def xml = new MarkupBuilder(xmlObj)
        def xml = new groovy.xml.MarkupBuilder(fw)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "utf-8")
        xml.Perguntas() {
            for (int i = 0; i < 4; i++) {
                def questionList = Question.findAllByLevel(i + 1)
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



        redirect(controller: "process", action: "completeTask", id: "createQuestions")


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

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Questão'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: OK] }
        }
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
