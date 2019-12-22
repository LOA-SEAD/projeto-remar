package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizMatrizController {

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
        //respond QuizMatriz.list(params), model:[quizMatrizInstanceCount: QuizMatriz.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new QuizMatriz(params)
        session.user = springSecurityService.currentUser

        def list = QuizMatriz.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuizMatriz(question: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizMatriz(question: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizMatriz(question: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizMatriz(question: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuizMatriz.findAllByOwnerId(session.user.id)
        respond list, model: [quizMatrizInstanceCount: QuizMatriz.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuizMatriz quizMatrizInstance) {
        respond quizMatrizInstance
    }

    def create() {
        respond new QuizMatriz(params)
    }

    @Transactional
    def save(QuizMatriz quizMatrizInstance) {
        if (quizMatrizInstance == null) {
            notFound()
            return
        }

        /*if (quizMatrizInstance.hasErrors()) {
            respond quizMatrizInstance.errors, view:'create'
            return
        }*/

        quizMatrizInstance.question = params.question
        quizMatrizInstance.answers[0]= params.answers1
        quizMatrizInstance.answers[1]= params.answers2
        quizMatrizInstance.answers[2]= params.answers3
        quizMatrizInstance.answers[3]= params.answers4
        quizMatrizInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizMatrizInstance.ownerId = session.user.id as long
        quizMatrizInstance.taskId = session.taskId as String
        quizMatrizInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quizMatriz.label', default: 'QuizMatriz'), quizMatrizInstance.id])
                redirect quizMatrizInstance
            }
            '*' { respond quizMatrizInstance, [status: CREATED] }
        }*/
    }

    def edit(QuizMatriz quizMatrizInstance) {
        respond quizMatrizInstance
    }

    @Transactional
    def update(/*QuizMatriz quizMatrizInstance*/) {
        /*if (quizMatrizInstance == null) {
            notFound()
            return
        }

        if (quizMatrizInstance.hasErrors()) {
            respond quizMatrizInstance.errors, view:'edit'
            return
        }

        quizMatrizInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QuizMatriz.label', default: 'QuizMatriz'), quizMatrizInstance.id])
                redirect quizMatrizInstance
            }
            '*'{ respond quizMatrizInstance, [status: OK] }
        }*/

        QuizMatriz quizMatrizInstance = QuizMatriz.findById(Integer.parseInt(params.quizMatrizID))
        quizMatrizInstance.question = params.question
        quizMatrizInstance.answers[0]= params.answers1
        quizMatrizInstance.answers[1]= params.answers2
        quizMatrizInstance.answers[2]= params.answers3
        quizMatrizInstance.answers[3]= params.answers4
        quizMatrizInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizMatrizInstance.ownerId = session.user.id as long
        quizMatrizInstance.taskId = session.taskId as String
        quizMatrizInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(QuizMatriz quizMatrizInstance) {

        if (quizMatrizInstance == null) {
            notFound()
            return
        }

        quizMatrizInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizMatriz.label', default: 'QuizMatriz'), quizMatrizInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quizMatriz.label', default: 'QuizMatriz'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuizMatriz quizMatrizInstance){
        if (quizMatrizInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render quizMatrizInstance.question + "%@!" +
                    quizMatrizInstance.answers[0] + "%@!" +
                    quizMatrizInstance.answers[1] + "%@!" +
                    quizMatrizInstance.answers[2] + "%@!" +
                    quizMatrizInstance.answers[3] + "%@!" +
                    quizMatrizInstance.correctAnswer + "%@!" +
                    quizMatrizInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //coleta os valores digitados pelo usuario
        ArrayList<Integer> list_questionId = new ArrayList<Integer>()
        ArrayList<QuizMatriz> questionList = new ArrayList<QuizMatriz>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizMatriz.findById(list_questionId[i]))

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
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}&files=${ids[3]}"
    }

    void createTxtQuestoes(String fileName, ArrayList<QuizMatriz> questionList, int index){
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
        String text
        char [] correctText = new char[200]
        //Para alterar a linha correta
        int indexQuestion = 1

        MultipartFile csv = params.csv
        def error = false

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 6) {
                //Tratamento para inputs maiores que 200 caracteres
                for (int i=0; i<(row.size() - 1); i++){
                    if (row[i].length() > 200){
                        text = row[i]
                        text.getChars(0, 200, correctText, 0)
                        row[i] = new String(correctText)
                    }
                }
                QuizMatriz quizMatrizInstance = QuizMatriz.findById(indexQuestion)
                quizMatrizInstance.question = row[0] ?: "NA"
                quizMatrizInstance.answers[0] = row[1] ?: "NA"
                quizMatrizInstance.answers[1] = row[2] ?: "NA"
                quizMatrizInstance.answers[2] = row[3] ?: "NA"
                quizMatrizInstance.answers[3] = row[4] ?: "NA"
                String correct = row[5] ?: "NA";
                //Ve se nao tentou passar uma string ao inves de um inteiro
                try {
                    quizMatrizInstance.correctAnswer = (correct.toInteger() - 1)
                    //Ve se a alternativa nao estah fora do intervalo
                    if (quizMatrizInstance.correctAnswer < 0 ||
                            quizMatrizInstance.correctAnswer > 3){
                        quizMatrizInstance.correctAnswer = 0
                    }
                }
                //Corrige o erro da string
                catch (NumberFormatException nFE){
                    quizMatrizInstance.correctAnswer = 0
                }
                quizMatrizInstance.taskId = session.taskId as String
                quizMatrizInstance.ownerId = session.user.id as long
                quizMatrizInstance.save flush: true
                println(quizMatrizInstance.errors)
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
        ArrayList<QuizMatriz> questionList = new ArrayList<QuizMatriz>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizMatriz.findById(list_questionId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestionsMatriz.csv"), "UTF-8"))

        for(int i=0; i<questionList.size();i++) {
            fw.write(questionList[i].question + ";" + questionList[i].answers[0] + ";" + questionList[i].answers[1] + ";" + questionList[i].answers[2] + ";" + questionList[i].answers[3] + ";" + (questionList[i].correctAnswer + 1) + "\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportQuestionsMatriz.csv"
    }
}
