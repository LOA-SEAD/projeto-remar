package br.ufscar.sead.loa.quiforca.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        println session.user.username

        def list = Question.list()

        render view: "index", model: [questionInstanceList: list, questionInstanceCount: Question.count(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def create() {
        respond new Question(params)
    }

    @Transactional
    def newQuestion(Question questionInstance) {
        if (questionInstance.author == null) {
            questionInstance.author = session.user.username
        }

        Question newQuest = new Question();
        newQuest.id = questionInstance.id
        newQuest.statement = questionInstance.statement
        newQuest.answer = questionInstance.answer
        newQuest.author = questionInstance.author
        newQuest.category = questionInstance.category
        newQuest.taskId    = session.taskId as String

        if (newQuest.hasErrors()) {
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

        newQuest.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newQuest.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())


    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }




        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create' //TODO
            render questionInstance.errors;
            return
        }

        questionInstance.taskId = session.taskId as String

        questionInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())
    }

    def edit(Question questionInstance) {
        respond questionInstance
    }

    @Transactional
    def update() {

        Question questionInstance = Question.findById(Integer.parseInt(params.questionID))

        questionInstance.statement = params.statement
        questionInstance.answer = params.answer
        questionInstance.category = params.category
        questionInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        questionInstance.delete flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def toJson() {

        def list = Question.getAll(params.id ? params.id.split(',').toList() : null)

        def builder = new JsonBuilder()

        def json = builder(
                list.collect { p ->
                    ["palavra"     : p.getAnswer().toUpperCase(),
                     "dica"        : p.getStatement(),
                     "contribuicao": p.getAuthor()]
                }
        )

        log.debug builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()


        def fileName = "palavras.json"

        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write('{ "nome" : "Forca","palavras":' + builder.toString() + '}');
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Question questionInstance){

        if (questionInstance == null) {
            notFound()
        }
        else{
            render questionInstance.statement + "%@!" +
                    questionInstance.answer + "%@!" +
                    questionInstance.author + "%@!" +
                    questionInstance.category + "%@!" +
                    questionInstance.version + "%@!" +
                    questionInstance.ownerId + "%@!" +
                    questionInstance.taskId + "%@!" +
                    questionInstance.id
        }
    }

    @Transactional
    def generateQuestions() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username



        csv.inputStream.toCsvReader(['separatorChar': ';']).eachLine { row ->


            Question questionInstance = new Question()



            try{
                String correct = row[6] ?: "NA";
                int correctAnswer = (correct.toInteger() -1)
                questionInstance.statement = row[1] ?: "NA";
                questionInstance.answer = row[(2 + correctAnswer)] ?: "NA";
                questionInstance.category = row[8] ?: "NA";
            }
            catch (ArrayIndexOutOfBoundsException exception){
                //println("Not default .csv - Model: Title-Answer-Category")
                questionInstance.statement = row[0] ?: "NA";
                questionInstance.answer = row[1] ?: "NA";
                questionInstance.category = row[2] ?: "NA";
            }

            questionInstance.author = username
            questionInstance.taskId = session.taskId as String

            if (questionInstance.hasErrors()) {

            }
            else{
                questionInstance.save flush: true
            }

        }

        redirect(action: index())

    }
}
