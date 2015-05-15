package br.ufscar.sead.loa.escolamagica.remar



import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.context.request.RequestContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["ROLE_PROF"])
@Transactional(readOnly = true)
class QuestionEscolaController {

    RuntimeService runtimeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond QuestionEscola.list(params), model:[questionEscolaInstanceCount: QuestionEscola.count()]
    }

    def confirming(){
        println params.id
        //redirect(controller: "process",action: "completeTask", id: "confirming")

    }

    def show(QuestionEscola questionEscolaInstance) {
        respond questionEscolaInstance
    }

    def create() {
        respond new QuestionEscola(params)
    }

    def createXML(){

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
        xml.mkp.xmlDeclaration(version: "1.0",encoding: "utf-8")
        xml.Perguntas(){
            for(int i=0; i<4; i++){
                def questionList = QuestionEscola.findAllByLevel(i+1)
                if(!questionList.isEmpty()) {
                    int j=0
                    int k=0
                    int l=0
                    Classe(ClaAno: i+1) {
                        while (!questionList.isEmpty()) {
                            Pergunta(PergNum: k, respCorreta: questionList.get(l).getCorrectAnswer(), titulo:questionList.get(j).getTitle()) {
                                Resp(num:'0',questionList.get(l).getAnswers()[0])
                                Resp(num:'1',questionList.get(l).getAnswers()[1])
                                Resp(num:'2',questionList.get(l).getAnswers()[2])
                                Resp(num:'3',questionList.get(l).getAnswers()[3])
                            }
                            questionList.remove(j)
                            k++
                        }

                    }
                }

            }

        }



        redirect(controller: "process",action: "completeTask", id: "createQuestions")


    }

    @Transactional
    def save(QuestionEscola questionEscolaInstance) {
        if (questionEscolaInstance == null) {
            notFound()
            return
        }

        if (questionEscolaInstance.hasErrors()) {
            respond questionEscolaInstance.errors, view:'create'
            return
        }

        questionEscolaInstance.save flush:true




        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Questão'), questionEscolaInstance.id])
                redirect(action: "index")
            }
            '*' { respond questionEscolaInstance, [status: CREATED] }
        }

    }

    def edit(QuestionEscola questionEscolaInstance) {
        respond questionEscolaInstance
    }

    @Transactional
    def update(QuestionEscola questionEscolaInstance) {
        if (questionEscolaInstance == null) {
            notFound()
            return
        }

        if (questionEscolaInstance.hasErrors()) {
            respond questionEscolaInstance.errors, view:'edit'
            return
        }

        questionEscolaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Questão'), questionEscolaInstance.id])
                redirect questionEscolaInstance
            }
            '*'{ respond questionEscolaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(QuestionEscola questionEscolaInstance) {

        if (questionEscolaInstance == null) {
            notFound()
            return
        }

        questionEscolaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Questão'), questionEscolaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Questão'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
