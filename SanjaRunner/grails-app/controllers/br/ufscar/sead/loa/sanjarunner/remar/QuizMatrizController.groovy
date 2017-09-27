package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizMatrizController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportQuestions: "POST", returnInstance: "GET"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportQuestions','save', 'update', 'delete']]

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
    def index(Integer max) {
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
        /*switch(questionList[index].correctAnswer){
            case 0:
                pw.write("0")
                break;
            case 1:
                pw.write("1")
                break;
            case 2:
                pw.write("2")
                break;
            case 3:
                pw.write("3")
                break;
            default:
                println("Erro! Alternativa correta inválida")
        }*/
        pw.close()
    }
}
