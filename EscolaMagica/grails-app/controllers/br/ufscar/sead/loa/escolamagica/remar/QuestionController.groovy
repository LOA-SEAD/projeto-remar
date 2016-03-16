package br.ufscar.sead.loa.escolamagica.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.web.JSONBuilder
import groovy.json.JsonBuilder
import groovy.xml.MarkupBuilder
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["IS_AUTHENTICATED_FULLY"])
class QuestionController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "GET" ]

    @Secured(['permitAll'])
    def index(Integer max) {
        if (params.t && params.h) {
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.test()))

            redirect controller: "question"
            return
        } else {
            session.user = springSecurityService.currentUser
        }

        def list = Question.findAllByOwnerId(session.user.id)

        if(!list) {
            new Question(title: 'Questão 1 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 1, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 2 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 1, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 3 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 1, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 4 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 1, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 5 – Nível 1', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 1, taskId: session.taskId, ownerId: session.user.id).save flush: true

            new Question(title: 'Questão 1 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 2 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 3 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 4 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 5 – Nível 2', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 2, taskId: session.taskId, ownerId: session.user.id).save flush: true

            new Question(title: 'Questão 1 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 2 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 3 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 4 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, taskId: session.taskId, ownerId: session.user.id).save flush: true
            new Question(title: 'Questão 5 – Nível 3', answers: ['Alternativa 1', 'Alternativa 2', 'Alternativa 3', 'Alternativa 4'],
                    correctAnswer: 0, level: 3, taskId: session.taskId, ownerId: session.user.id).save flush: true
        }

        respond Question.findAllByOwnerId(session.user.id), model: [questionInstanceCount: Question.count()]
    }

    def confirming() {
        log.debug params.id
        //redirect(controller: "process",action: "completeTask", id: "confirming")
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
        respond new Question(params.id)
    }

    def createXML() {

        //   def servletContext = ServletContextHolder.servletContext
        //  def storagePath = servletContext.getRealPath("/")
        //   log.debug storagePath

        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<Question> questionList = new ArrayList<Question>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(Question.findById(list_questionId[i]));

        }

        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new FileWriter("$instancePath/perguntas.xml")
        def xml = new MarkupBuilder(fw)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "utf-8")
        xml.Perguntas() {
            for (int i = 0; i < 4; i++) {
                def list = []
                questionList.each {
                    if(it.level == String.valueOf(i+1))
                        list.push(it);
                }

               // def questionList = Question.findAllByOwnerIdAndLevel(session.user.id, String.valueOf(i + 1))
                if (!list.isEmpty()) {
                    int j = 0
                    int k = 0
                    int l = 0
                    Classe(ClaAno: i + 1) {
                        while (!list.isEmpty()) {
                            Pergunta(PergNum: k, respCorreta: list.get(l).getCorrectAnswer(), titulo: list.get(j).getTitle()) {
                                Resp(num: '0', list.get(l).getAnswers()[0])
                                Resp(num: '1', list.get(l).getAnswers()[1])
                                Resp(num: '2', list.get(l).getAnswers()[2])
                                Resp(num: '3', list.get(l).getAnswers()[3])
                            }
                            list.remove(j)
                            k++
                        }

                    }
                }

            }

        }

        String id = MongoHelper.putFile("${instancePath}/perguntas.xml")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        log.debug "=="
        log.debug session.user.id
        log.debug "=="

        questionInstance.taskId = session.taskId as String
        questionInstance.ownerId = session.user.id as long

        log.debug "=="
        log.debug questionInstance.ownerId;
        log.debug "=="

        questionInstance.save flush: true

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create'
            return
        }


        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Questão'), questionInstance.id])
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

        redirect action: "index"
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

    @Transactional
    def generateQuestions(){
        MultipartFile csv = params.csv

        csv.inputStream.eachCsvLine { row ->
            Question questionInstance = new Question()
            questionInstance.level = row[0] ?: "NA";
            questionInstance.title = row[1] ?: "NA";
            questionInstance.answers[0] = row[2] ?: "NA";
            questionInstance.answers[1] = row[3] ?: "NA";
            questionInstance.answers[2] = row[4] ?: "NA";
            questionInstance.answers[3] = row[5] ?: "NA";
            String correct = row[6] ?: "NA";
            questionInstance.correctAnswer =  correct.toInteger()
            questionInstance.ownerId = session.user.id
            if(questionInstance.hasErrors()){

            }
            else
                questionInstance.save flush: true
        }
        redirect(action: index())
    }
}
