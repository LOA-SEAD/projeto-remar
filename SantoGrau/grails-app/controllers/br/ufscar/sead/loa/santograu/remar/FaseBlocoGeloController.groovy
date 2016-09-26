package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseBlocoGeloController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        def list = QuestionFaseBlocoGelo.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuestionFaseBlocoGelo(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseBlocoGelo.findAllByOwnerId(session.user.id)
        respond list, model: [faseBlocoGeloInstanceCount: QuestionFaseBlocoGelo.count()]
    }

    def show(QuestionFaseBlocoGelo faseBlocoGeloInstance) {
        respond faseBlocoGeloInstance
    }

    def create() {
        respond new QuestionFaseBlocoGelo(params)
    }

    @Transactional
    def save(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance) {
        if (questionFaseBlocoGeloInstance == null) {
            notFound()
            return
        }

        questionFaseBlocoGeloInstance.answers[0]= params.answers1
        questionFaseBlocoGeloInstance.answers[1]= params.answers2
        questionFaseBlocoGeloInstance.answers[2]= params.answers3
        questionFaseBlocoGeloInstance.ownerId = session.user.id as long
        questionFaseBlocoGeloInstance.taskId = session.taskId as String
        questionFaseBlocoGeloInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseBlocoGelo faseBlocoGeloInstance) {
        respond faseBlocoGeloInstance
    }

    @Transactional
    def update() {
        QuestionFaseBlocoGelo questionFaseBlocoGeloInstance = QuestionFaseBlocoGelo.findById(Integer.parseInt(params.faseBlocoGeloID))
        questionFaseBlocoGeloInstance.title = params.title
        questionFaseBlocoGeloInstance.answers[0]= params.answers1
        questionFaseBlocoGeloInstance.answers[1]= params.answers2
        questionFaseBlocoGeloInstance.answers[2]= params.answers3
        questionFaseBlocoGeloInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseBlocoGeloInstance.ownerId = session.user.id as long
        questionFaseBlocoGeloInstance.taskId = session.taskId as String
        questionFaseBlocoGeloInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance) {

        if (questionFaseBlocoGeloInstance == null) {
            notFound()
            return
        }

        questionFaseBlocoGeloInstance.delete flush:true
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseBlocoGelo.label', default: 'QuestionFaseBlocoGelo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance){
        if (questionFaseBlocoGeloInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseBlocoGeloInstance.title + "%@!" +
                    questionFaseBlocoGeloInstance.answers[0] + "%@!" +
                    questionFaseBlocoGeloInstance.answers[1] + "%@!" +
                    questionFaseBlocoGeloInstance.answers[2] + "%@!" +
                    questionFaseBlocoGeloInstance.correctAnswer + "%@!" +
                    questionFaseBlocoGeloInstance.id
        }

    }

    @Transactional
    def exportQuestions(){
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseBlocoGelo> questionList = new ArrayList<QuestionFaseBlocoGelo>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuestionFaseBlocoGelo.findById(list_questionId[i]));

        //cria o arquivo json
        createJsonFile("questoesbn.json", questionList)
        render "index"

        //def ids = []
        //def folder = servletContext.getRealPath("/data/${session.user.id}/${session.taskId}")

        //ids << MongoHelper.putFile(folder + '/pergFacil.json')
        //ids << MongoHelper.putFile(folder + '/pergMedio.json')
        //ids << MongoHelper.putFile(folder + '/pergDificil.json')

        //def port = request.serverPort
        //if (Environment.current == Environment.DEVELOPMENT) {
        //   port = 8080
        //}

        //render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
        //        "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"


    }

    void createJsonFile(String fileName, ArrayList<QuestionFaseBlocoGelo> questionList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n")
        pw.write("\t\"quantidadeQuestoes\": [\"" + questionList.size() + "\"],\n")
        for(def i=0; i<questionList.size();i++){
            pw.write("\t\"" + (i+1) + "\": [\"" + questionList[i].title + "\", ")
            pw.write("\""+ questionList[i].answers[0] +"\", " + "\""+ questionList[i].answers[1] +"\", ")
            pw.write("\""+ questionList[i].answers[2] +"\", ")
            switch(questionList[i].correctAnswer){
                case 0:
                    pw.write("\"A\"]")
                    break;
                case 1:
                    pw.write("\"B\"]")
                    break;
                case 2:
                    pw.write("\"C\"]")
                    break;
                default:
                    println("Erro! Alternativa correta inválida")
            }
            if(i<questionList.size()-1)
                pw.write(",")
            pw.write("\n")
        }
        pw.write("}");
        pw.close();
    }
}
