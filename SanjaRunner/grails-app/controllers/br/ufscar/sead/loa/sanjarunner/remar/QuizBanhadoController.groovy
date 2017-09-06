package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class QuizBanhadoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportLevel: "POST"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportLevel','save', 'update', 'delete']]

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
            new QuizBanhado(question: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizBanhado(question: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuizBanhado(question: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
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

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QuizBanhado.label', default: 'QuizBanhado'), quizBanhadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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

    @Transactional
    def exportQuestions(){
        //coleta os valores digitados pelo usuario
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuizBanhado> questionList = new ArrayList<QuizBanhado>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++) {
            //questionList.add(QuizBanhado.findById(list_questionId[i]));
            //cria o arquivo json
            createTxtQuestoes("quizBanhado/question" + i + ".txt", QuizBanhado.findById(list_questionId[i]))

            // Finds the created file path
            def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
            String id = MongoHelper.putFile("${folder}/quizBanhado/question" + i + ".txt")


            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8080
            }

            // Updates current task to 'completed' status
            render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
        }

        /*CORRIGIR:
        //cria os arquivos json e html da fase
        createJsonFileComputadores("computadores.json", faseTecnologia)
        createHtmlFileTelao("telao.html", faseTecnologia)

        // Finds the created file path
        def ids = []
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        def fasesFolder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/processes/${session.processId}")

        log.debug folder
        ids << MongoHelper.putFile(folder + '/telao.html')
        ids << MongoHelper.putFile(fasesFolder + '/fases.json')
        ids << MongoHelper.putFile(folder + '/computadores.json')

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"
        */
    }

    void createTxtQuestoes(String fileName, QuizBanhado quizBanhado){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(quizBanhado.question.replace("\"","\\\"") + "\n" + quizBanhado.answers[0].replace("\"","\\\"") + "\n" + quizBanhado.answers[1].replace("\"","\\\"") + "\n" + quizBanhado.answers[2].replace("\"","\\\"") + "\n" + quizBanhado.answers[3].replace("\"","\\\"") + "\n" + quizBanhado.correctAnswer)
        pw.close();
    }
}
