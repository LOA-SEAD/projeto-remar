package br.ufscar.sead.loa.escolamagica.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.xml.MarkupBuilder
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class QuestionController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE" ]

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Question.findAllByOwnerId(session.user.id)
        if(!list) {
            println "Questions list for user " + session.user.id + "is empty."
            println "Generating questions automatically."
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
    def update() {
        Question questionInstance = Question.findById(Integer.parseInt(params.questionID))

        questionInstance.level = Integer.parseInt(params.level)
        questionInstance.title = params.title
        questionInstance.answers[0] = params.answers1
        questionInstance.answers[1] = params.answers2
        questionInstance.answers[2] = params.answers3
        questionInstance.answers[3] = params.answers4
        questionInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionInstance.ownerId = session.user.id as long
        questionInstance.taskId = session.taskId as String
        questionInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        println "Delete Question ID = " + questionInstance.id

        questionInstance.delete flush: true
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

    def returnInstance(Question questionInstance){

        if (questionInstance == null) {
            notFound()
        }
        else{
            render questionInstance.level + "%@!" +
                    questionInstance.title + "%@!" +
                    questionInstance.answers[0] + "%@!" +
                    questionInstance.answers[1] + "%@!" +
                    questionInstance.answers[2] + "%@!" +
                    questionInstance.answers[3] + "%@!" +
                    questionInstance.correctAnswer + "%@!" +
                    questionInstance.id
        }
    }

    def exportCSV(){
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<Question> questionList = new ArrayList<Question>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(Question.findById(list_questionId[i]));

        }

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new FileWriter("$instancePath/exportQuestions.csv")
        for(int i=0; i<questionList.size();i++){
            fw.write(questionList.getAt(i).level + ";" + questionList.getAt(i).title + ";" + questionList.getAt(i).answers[0] + ";" + questionList.getAt(i).answers[1] + ";" +
                     questionList.getAt(i).answers[2] + ";" + questionList.getAt(i).answers[3] + ";" + (questionList.getAt(i).correctAnswer +1) + ";dica;tema" +";\n" )
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/escolamagica/samples/export/exportQuestions.csv"

    }

    @Transactional
    def generateQuestions(){
        /*
         * Importa questões de um arquivo CSV com valores separados por ponto-e-vírgula
         */
        MultipartFile csv = params.csv

        csv.inputStream.toCsvReader([ 'separatorChar': ';']).eachLine { row ->
            Question questionInstance = new Question()
            questionInstance.level = row[0] ?: "NA";
            questionInstance.title = row[1] ?: "NA";
            questionInstance.answers[0] = row[2] ?: "NA";
            questionInstance.answers[1] = row[3] ?: "NA";
            questionInstance.answers[2] = row[4] ?: "NA";
            questionInstance.answers[3] = row[5] ?: "NA";
            String correct = row[6] ?: "NA";
            questionInstance.correctAnswer =  (correct.toInteger() -1)
            questionInstance.taskId = session.taskId as String
            questionInstance.ownerId = session.user.id as long
            questionInstance.save flush: true
            println(questionInstance.taskId)
            println(questionInstance)
            println(questionInstance.errors)


        }
        redirect(action: index())
    }
}
