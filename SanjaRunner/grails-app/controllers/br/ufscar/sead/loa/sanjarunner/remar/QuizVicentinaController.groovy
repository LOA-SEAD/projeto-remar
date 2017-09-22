package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizVicentinaController {

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
        //respond QuizVicentina.list(params), model:[quizVicentinaInstanceCount: QuizVicentina.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new QuizVicentina(params)
        session.user = springSecurityService.currentUser

        def list = QuizVicentina.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuizVicentina(question: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizVicentina(question: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizVicentina(question: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizVicentina(question: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizVicentina(question: "Questão 5", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuizVicentina.findAllByOwnerId(session.user.id)
        respond list, model: [quizVicentinaInstanceCount: QuizVicentina.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuizVicentina quizVicentinaInstance) {
        respond quizVicentinaInstance
    }

    def create() {
        respond new QuizVicentina(params)
    }

    @Transactional
    def save(QuizVicentina quizVicentinaInstance) {
        if (quizVicentinaInstance == null) {
            notFound()
            return
        }

        /*if (quizVicentinaInstance.hasErrors()) {
            respond quizVicentinaInstance.errors, view:'create'
            return
        }*/

        quizVicentinaInstance.question = params.question
        quizVicentinaInstance.answers[0]= params.answers1
        quizVicentinaInstance.answers[1]= params.answers2
        quizVicentinaInstance.answers[2]= params.answers3
        quizVicentinaInstance.answers[3]= params.answers4
        quizVicentinaInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizVicentinaInstance.ownerId = session.user.id as long
        quizVicentinaInstance.taskId = session.taskId as String
        quizVicentinaInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quizVicentina.label', default: 'QuizVicentina'), quizVicentinaInstance.id])
                redirect quizVicentinaInstance
            }
            '*' { respond quizVicentinaInstance, [status: CREATED] }
        }*/
    }

    def edit(QuizVicentina quizVicentinaInstance) {
        respond quizVicentinaInstance
    }

    @Transactional
    def update(/*QuizVicentina quizVicentinaInstance*/) {
        /*if (quizVicentinaInstance == null) {
            notFound()
            return
        }

        if (quizVicentinaInstance.hasErrors()) {
            respond quizVicentinaInstance.errors, view:'edit'
            return
        }

        quizVicentinaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QuizVicentina.label', default: 'QuizVicentina'), quizVicentinaInstance.id])
                redirect quizVicentinaInstance
            }
            '*'{ respond quizVicentinaInstance, [status: OK] }
        }*/

        QuizVicentina quizVicentinaInstance = QuizVicentina.findById(Integer.parseInt(params.quizVicentinaID))
        quizVicentinaInstance.question = params.question
        quizVicentinaInstance.answers[0]= params.answers1
        quizVicentinaInstance.answers[1]= params.answers2
        quizVicentinaInstance.answers[2]= params.answers3
        quizVicentinaInstance.answers[3]= params.answers4
        quizVicentinaInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizVicentinaInstance.ownerId = session.user.id as long
        quizVicentinaInstance.taskId = session.taskId as String
        quizVicentinaInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(QuizVicentina quizVicentinaInstance) {

        if (quizVicentinaInstance == null) {
            notFound()
            return
        }

        quizVicentinaInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizVicentina.label', default: 'QuizVicentina'), quizVicentinaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quizVicentina.label', default: 'QuizVicentina'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuizVicentina quizVicentinaInstance){
        if (quizVicentinaInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render quizVicentinaInstance.question + "%@!" +
                    quizVicentinaInstance.answers[0] + "%@!" +
                    quizVicentinaInstance.answers[1] + "%@!" +
                    quizVicentinaInstance.answers[2] + "%@!" +
                    quizVicentinaInstance.answers[3] + "%@!" +
                    quizVicentinaInstance.correctAnswer + "%@!" +
                    quizVicentinaInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //coleta os valores digitados pelo usuario
        ArrayList<Integer> list_questionId = new ArrayList<Integer>()
        ArrayList<QuizVicentina> questionList = new ArrayList<QuizVicentina>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizVicentina.findById(list_questionId[i]))

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

    void createTxtQuestoes(String fileName, ArrayList<QuizVicentina> questionList, int index){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName)
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(questionList[index].question.replace("\"","\\\"") + "\n" + questionList[index].answers[0].replace("\"","\\\"") + "\n" + questionList[index].answers[1].replace("\"","\\\"") + "\n" + questionList[index].answers[2].replace("\"","\\\"") + "\n" + questionList[index].answers[3].replace("\"","\\\"") + "\n"/* + Integer.toString(questionList[index].correctAnswer)*/)
        switch(questionList[index].correctAnswer){
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
        }
        pw.close()
    }
}
