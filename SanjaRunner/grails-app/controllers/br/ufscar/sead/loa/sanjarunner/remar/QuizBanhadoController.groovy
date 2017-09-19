package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizBanhadoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportQuestions: "POST"]
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
        //respond QuizBanhado.list(params), model:[quizBanhadoInstanceCount: QuizBanhado.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new QuizBanhado(params)
        session.user = springSecurityService.currentUser

        def list = QuizBanhado.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuizBanhado(question: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizBanhado(question: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizBanhado(question: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizBanhado(question: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuizBanhado.findAllByOwnerId(session.user.id)
        respond list, model: [quizBanhadoInstanceCount: QuizBanhado.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuizBanhado quizBanhadoInstance) {
        respond quizBanhadoInstance
    }

    def create() {
        respond new QuizBanhado(params)
    }

    @Transactional
    def save(QuizBanhado quizBanhadoInstance) {
        if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        /*if (quizBanhadoInstance.hasErrors()) {
            respond quizBanhadoInstance.errors, view:'create'
            return
        }*/

        quizBanhadoInstance.question = params.question
        quizBanhadoInstance.answers[0]= params.answers1
        quizBanhadoInstance.answers[1]= params.answers2
        quizBanhadoInstance.answers[2]= params.answers3
        quizBanhadoInstance.answers[3]= params.answers4
        quizBanhadoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizBanhadoInstance.ownerId = session.user.id as long
        quizBanhadoInstance.taskId = session.taskId as String
        quizBanhadoInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect quizBanhadoInstance
            }
            '*' { respond quizBanhadoInstance, [status: CREATED] }
        }*/
    }

    def edit(QuizBanhado quizBanhadoInstance) {
        respond quizBanhadoInstance
    }

    @Transactional
    def update(/*QuizBanhado quizBanhadoInstance*/) {
        /*if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        if (quizBanhadoInstance.hasErrors()) {
            respond quizBanhadoInstance.errors, view:'edit'
            return
        }

        quizBanhadoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QuizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect quizBanhadoInstance
            }
            '*'{ respond quizBanhadoInstance, [status: OK] }
        }*/

        QuizBanhado quizBanhadoInstance = QuizBanhado.findById(Integer.parseInt(params.quizBanhadoID))
        quizBanhadoInstance.question = params.question
        quizBanhadoInstance.answers[0]= params.answers1
        quizBanhadoInstance.answers[1]= params.answers2
        quizBanhadoInstance.answers[2]= params.answers3
        quizBanhadoInstance.answers[3]= params.answers4
        quizBanhadoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        quizBanhadoInstance.ownerId = session.user.id as long
        quizBanhadoInstance.taskId = session.taskId as String
        quizBanhadoInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(QuizBanhado quizBanhadoInstance) {

        if (quizBanhadoInstance == null) {
            notFound()
            return
        }

        quizBanhadoInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quizBanhado.label', default: 'QuizBanhado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuizBanhado quizBanhadoInstance){
        if (quizBanhadoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render quizBanhadoInstance.question + "%@!" +
                    quizBanhadoInstance.answers[0] + "%@!" +
                    quizBanhadoInstance.answers[1] + "%@!" +
                    quizBanhadoInstance.answers[2] + "%@!" +
                    quizBanhadoInstance.answers[3] + "%@!" +
                    quizBanhadoInstance.correctAnswer + "%@!" +
                    quizBanhadoInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //coleta os valores digitados pelo usuario
        ArrayList<Integer> list_questionId = new ArrayList<Integer>()
        ArrayList<QuizBanhado> questionList = new ArrayList<QuizBanhado>()
        list_questionId.addAll(params.list_id)
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuizBanhado.findById(list_questionId[i]))

        //cria o arquivo json
        for (int i=0; i<list_questionId.size();i++) {
            createTxtQuestoes("quizBanhado/question" + i + ".txt", questionList[i])
        }

        /*createTxtQuestoes("quizBanhado/question0.txt", questionList, 0)
        createTxtQuestoes("quizBanhado/question1.txt", questionList, 1)
        createTxtQuestoes("quizBanhado/question2.txt", questionList, 2)
        createTxtQuestoes("quizBanhado/question3.txt", questionList, 3)*/

        //createTxtQuestoes(questionList)

        // Finds the created file path
        def ids = []
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")

        /*for (int i=0; i<list_questionId.size();i++)
            ids << MongoHelper.putFile("${folder}/quizBanhado/question" + i + ".txt")*/

        ids << MongoHelper.putFile("${folder}/quizBanhado/question0.txt")
        ids << MongoHelper.putFile("${folder}/quizBanhado/question1.txt")
        ids << MongoHelper.putFile("${folder}/quizBanhado/question2.txt")
        ids << MongoHelper.putFile("${folder}/quizBanhado/question3.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}&files=${ids[3]}"
    }

    /*void createTxtQuestoes(String fileName, ArrayList<QuizBanhado> questionList, int index){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName)
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(questionList[index].question.replace("\"","\\\"") + "\n" + questionList[index].answers[0].replace("\"","\\\"") + "\n" + questionList[index].answers[1].replace("\"","\\\"") + "\n" + questionList[index].answers[2].replace("\"","\\\"") + "\n" + questionList[index].answers[3].replace("\"","\\\"") + "\n" + questionList[index].correctAnswer)
        pw.close()
    }*/

    /*void createTxtQuestoes(ArrayList<QuizBanhado> questionList) {
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        for(def i=0; i<questionList.size();i++) {
            File file = new File("$instancePath/" + "quizBanhado/question" + i + ".txt")
            def pw = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(file), "UTF-8"))
            pw.write(questionList[i].question.replace("\"", "\\\"") + "\n" + questionList[i].answers[0].replace("\"", "\\\"") + "\n" + questionList[i].answers[1].replace("\"", "\\\"") + "\n" + questionList[i].answers[2].replace("\"", "\\\"") + "\n" + questionList[i].answers[3].replace("\"", "\\\"") + "\n" + questionList[i].correctAnswer)
            pw.close()
        }
    }*/

    void createTxtQuestoes(String fileName, QuizBanhado questionList) {
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/" + fileName)
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(questionList.question.replace("\"", "\\\"") + "\n" + questionList.answers[0].replace("\"", "\\\"") + "\n" + questionList.answers[1].replace("\"", "\\\"") + "\n" + questionList.answers[2].replace("\"", "\\\"") + "\n" + questionList.answers[3].replace("\"", "\\\"") + "\n" + questionList.correctAnswer)
        pw.close()
    }
}
