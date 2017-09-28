package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizCassianoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportQuestions: "POST", returnInstance: "GET", generateQuestions: "POST"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportQuestions','save', 'update', 'delete', 'generateQuestions']]

    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }

    @Secured(['permitAll'])
    def index() {
        //params.max = Math.min(max ?: 10, 100)
        //respond QuizCassiano.list(params), model:[quizCassianoInstanceCount: QuizCassiano.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new QuizCassiano(params)
        session.user = springSecurityService.currentUser

        def list = QuizCassiano.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuizCassiano(question: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizCassiano(question: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizCassiano(question: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizCassiano(question: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizCassiano(question: "Questão 5", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuizCassiano.findAllByOwnerId(session.user.id)
        respond list, model: [quizCassianoInstanceCount: QuizCassiano.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuizCassiano quizCassianoInstance) {
        respond quizCassianoInstance
    }

    def create() {
        respond new QuizCassiano(params)
    }

    @Transactional
    def save(QuizCassiano quizCassianoInstance) {
        if (quizCassianoInstance == null) {
            notFound()
            return
        }

        /*if (quizCassianoInstance.hasErrors()) {
            respond quizCassianoInstance.errors, view:'create'
            return
        }*/

        quizCassianoInstance.question = params.question
        quizCassianoInstance.answers[0]= params.answers1
        quizCassianoInstance.answers[1]= params.answers2
        quizCassianoInstance.answers[2]= params.answers3
        quizCassianoInstance.answers[3]= params.answers4
        quizCassianoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizCassianoInstance.ownerId = session.user.id as long
        quizCassianoInstance.taskId = session.taskId as String
        quizCassianoInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quizCassiano.label', default: 'QuizCassiano'), quizCassianoInstance.id])
                redirect quizCassianoInstance
            }
            '*' { respond quizCassianoInstance, [status: CREATED] }
        }*/
    }

    def edit(QuizCassiano quizCassianoInstance) {
        respond quizCassianoInstance
    }

    @Transactional
    def update(/*QuizCassiano quizCassianoInstance*/) {
        /*if (quizCassianoInstance == null) {
            notFound()
            return
        }

        if (quizCassianoInstance.hasErrors()) {
            respond quizCassianoInstance.errors, view:'edit'
            return
        }

        quizCassianoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QuizCassiano.label', default: 'QuizCassiano'), quizCassianoInstance.id])
                redirect quizCassianoInstance
            }
            '*'{ respond quizCassianoInstance, [status: OK] }
        }*/

        QuizCassiano quizCassianoInstance = QuizCassiano.findById(Integer.parseInt(params.quizCassianoID))
        quizCassianoInstance.question = params.question
        quizCassianoInstance.answers[0]= params.answers1
        quizCassianoInstance.answers[1]= params.answers2
        quizCassianoInstance.answers[2]= params.answers3
        quizCassianoInstance.answers[3]= params.answers4
        quizCassianoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizCassianoInstance.ownerId = session.user.id as long
        quizCassianoInstance.taskId = session.taskId as String
        quizCassianoInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(QuizCassiano quizCassianoInstance) {

        if (quizCassianoInstance == null) {
            notFound()
            return
        }

        quizCassianoInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizCassiano.label', default: 'QuizCassiano'), quizCassianoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quizCassiano.label', default: 'QuizCassiano'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuizCassiano quizCassianoInstance){
        if (quizCassianoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render quizCassianoInstance.question + "%@!" +
                    quizCassianoInstance.answers[0] + "%@!" +
                    quizCassianoInstance.answers[1] + "%@!" +
                    quizCassianoInstance.answers[2] + "%@!" +
                    quizCassianoInstance.answers[3] + "%@!" +
                    quizCassianoInstance.correctAnswer + "%@!" +
                    quizCassianoInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //coleta os valores digitados pelo usuario
        ArrayList<Integer> list_questionId = new ArrayList<Integer>()
        ArrayList<QuizCassiano> questionList = new ArrayList<QuizCassiano>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizCassiano.findById(list_questionId[i]))

        //cria o arquivo json, sendo que eh passado apenas o nome do arquivo, seu caminho fica no path do web-app/remar/process.json
        for (int i=0; i<list_questionId.size();i++) {
            createTxtQuestoes("question" + i + ".txt", questionList, i)
        }

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        def ids = []

        for (int i=0; i<list_questionId.size();i++)
            ids << MongoHelper.putFile("${folder}/question" + i + ".txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}&files=${ids[3]}&files=${ids[4]}"
    }

    void createTxtQuestoes(String fileName, ArrayList<QuizCassiano> questionList, int index){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName)
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(questionList[index].question.replace("\"","\\\"") + "\n" + Integer.toString(questionList[index].correctAnswer) + "\n" + questionList[index].answers[0].replace("\"","\\\"") + "\n" + questionList[index].answers[1].replace("\"","\\\"") + "\n" + questionList[index].answers[2].replace("\"","\\\"") + "\n" + questionList[index].answers[3].replace("\"","\\\""))
        pw.close()
    }

    @Transactional
    def generateQuestions(){
        MultipartFile csv = params.csv
        def error = false
        //Para alterar a linha correta
        int indexQuestion = 1

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if (row.size() == 6) {
                QuizCassiano quizCassianoInstance = QuizCassiano.findById(indexQuestion)
                quizCassianoInstance.question = row[0] ?: "NA"
                quizCassianoInstance.answers[0] = row[1] ?: "NA"
                quizCassianoInstance.answers[1] = row[2] ?: "NA"
                quizCassianoInstance.answers[2] = row[3] ?: "NA"
                quizCassianoInstance.answers[3] = row[4] ?: "NA"
                String correct = row[5] ?: "NA";
                quizCassianoInstance.correctAnswer =  (correct.toInteger() - 1)
                quizCassianoInstance.taskId = session.taskId as String
                quizCassianoInstance.ownerId = session.user.id as long
                quizCassianoInstance.save flush: true
                println(quizCassianoInstance.errors)
            } else {
                error = true
            }
            //Incrementa o contador de linha
            indexQuestion += 1
        }

        redirect(action: index(), params: [errorImportQuestions:error])
    }

    def exportCSV(){
        /* Funcao que exporta as questões selecionadas para um arquivo .csv generico.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta.
           O separador do arquivo .csv gerado eh o ";" (ponto e virgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>()
        ArrayList<QuizCassiano> questionList = new ArrayList<QuizCassiano>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizCassiano.findById(list_questionId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestionsCassiano.csv"), "UTF-8"))

        for(int i=0; i<questionList.size();i++) {
            fw.write(questionList[i].question + ";" + questionList[i].answers[0] + ";" + questionList[i].answers[1] + ";" + questionList[i].answers[2] + ";" + questionList[i].answers[3] + ";" + (questionList[i].correctAnswer + 1) + "\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportQuestionsCassiano.csv"
    }
}
