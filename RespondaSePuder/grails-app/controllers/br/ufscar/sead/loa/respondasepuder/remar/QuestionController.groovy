package br.ufscar.sead.loa.respondasepuder.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.load.remar.api.MongoHelper
import grails.util.Environment
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["IS_AUTHENTICATED_FULLY"])
class QuestionController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: ["GET","POST"]]

    @Secured(['permitAll'])
    def index() {
        if (params.t && params.h) {
            session.taskId = params.t

            def u = User.findByUsername(new String(params.h.decodeBase64()))
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(u, null, u.authoritiesHashSet()))

            redirect controller: "question"
            return
        } else {
            session.user = springSecurityService.currentUser
        }

        def list = Question.findAllByOwnerId(session.user.id)

        if(list.size()==0){

            new Question(title: "Questão 1 - Nível 1", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 2 - Nível 1", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 3 - Nível 1", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 4 - Nível 1", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 5 - Nível 1", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 1, ownerId:  session.user.id, taskId: session.taskId).save flush: true

            new Question(title: "Questão 1 - Nível 2", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 2 - Nível 2", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 3 - Nível 2", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 4 - Nível 2", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 5 - Nível 2", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 2, ownerId:  session.user.id, taskId: session.taskId).save flush: true

            new Question(title: "Questão 1 - Nível 3", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 2 - Nível 3", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 3 - Nível 3", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 4 - Nível 3", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new Question(title: "Questão 5 - Nível 3", answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"], correctAnswer: 0, hint: "Dica", level: 3, ownerId:  session.user.id, taskId: session.taskId).save flush: true

        }




        respond Question.findAllByOwnerId(session.user.id), model: [questionInstanceCount: Question.count()]
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
        respond new Question(params)
    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view:'create'
            return
        }

        questionInstance.answers[0]= params.answers1
        questionInstance.answers[1]= params.answers2
        questionInstance.answers[2]= params.answers3
        questionInstance.answers[3]= params.answers4
        questionInstance.ownerId = session.user.id as long
        questionInstance.taskId = session.taskId as String




        questionInstance.save flush:true

        redirect(action: "index")

//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
//                redirect questionInstance
//            }
//            '*' { respond questionInstance, [status: CREATED] }
//        }
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
        questionInstance.hint = params.hint
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

        questionInstance.delete flush: true

        redirect action: "index"

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
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
                    questionInstance.hint + "%@!" +
                    questionInstance.id


        }

    }

    @Transactional
    def exportQuestions(){

        int randomQuestion = Integer.parseInt(params.randomQuestion)
        //Criando lista de questões do level 1
        ArrayList<Integer> list_questionId_level1 = new ArrayList<Integer>() ;
        ArrayList<Question> questionList_level1 = new ArrayList<Question>();
        list_questionId_level1.addAll(params.list_id_level1);
        for (int i=0; i<list_questionId_level1.size();i++){
            questionList_level1.add(Question.findById(list_questionId_level1[i]));

        }

        //Criando lista de questões do level 2
        ArrayList<Integer> list_questionId_level2 = new ArrayList<Integer>() ;
        ArrayList<Question> questionList_level2 = new ArrayList<Question>();
        list_questionId_level2.addAll(params.list_id_level2);
        for (int i=0; i<list_questionId_level2.size();i++){
            questionList_level2.add(Question.findById(list_questionId_level2[i]));

        }

        //Criando lista de questões do level 3
        ArrayList<Integer> list_questionId_level3 = new ArrayList<Integer>() ;
        ArrayList<Question> questionList_level3 = new ArrayList<Question>();
        list_questionId_level3.addAll(params.list_id_level3);
        for (int i=0; i<list_questionId_level3.size();i++){
            questionList_level3.add(Question.findById(list_questionId_level3[i]));

        }

        createJsonFile("pergFacil.json",questionList_level1, randomQuestion)
        createJsonFile("pergMedio.json",questionList_level2, randomQuestion)
        createJsonFile("pergDificil.json",questionList_level3, randomQuestion)

        def ids = []
        def folder = servletContext.getRealPath("/data/${session.user.id}/${session.taskId}")

        ids << MongoHelper.putFile(folder + '/pergFacil.json')
        ids << MongoHelper.putFile(folder + '/pergMedio.json')
        ids << MongoHelper.putFile(folder + '/pergDificil.json')

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"


    }

    void createJsonFile(String fileName, ArrayList<Question> questionList, int randomQuestion ){
        int i = 0
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()



        File file = new File("$instancePath/"+fileName);
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n ");
        pw.write("\"numero\":[\"" + questionList.size()+ "\",\""+ randomQuestion +"\"],\n")
        for(i=0; i<(questionList.size()-1);i++){
            pw.write("\"" + (i+1) + "\": [\"" + questionList.getAt(i).title + "\", ")
            switch(questionList.getAt(i).correctAnswer){
                case 0:
                    pw.write("\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                    break;
                case 1:
                    pw.write("\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                    break;
                case 2:
                    pw.write("\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                    break;
                case 3:
                    pw.write("\""+ questionList.getAt(i).answers[3] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " )
                    break;
                default:
                    println("Erro! Alternativa correta inválida")
            }
            pw.write("\""+ questionList.getAt(i).hint +"\"],\n")

        }

        pw.write("\"" + (i+1) + "\": [\"" + questionList.getAt(i).title + "\", ")
        switch(questionList.getAt(i).correctAnswer){
            case 0:
                pw.write("\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                break;
            case 1:
                pw.write("\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                break;
            case 2:
                pw.write("\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " + "\""+ questionList.getAt(i).answers[3] +"\", " )
                break;
            case 3:
                pw.write("\""+ questionList.getAt(i).answers[3] +"\", " + "\""+ questionList.getAt(i).answers[1] +"\", " + "\""+ questionList.getAt(i).answers[2] +"\", " + "\""+ questionList.getAt(i).answers[0] +"\", " )
                break;
            default:
                println("Erro! Alternativa correta inválida")
        }
        pw.write("\""+ questionList.getAt(i).hint +"\"]\n")
        pw.write("}");
        pw.close();

    }

    @Transactional
    def generateQuestions(){
        MultipartFile csv = params.csv


        csv.inputStream.eachCsvLine { row ->
            Question questionInstance = new Question()
            String levelQuestion = row[0] ?: "NA";
            questionInstance.level = levelQuestion.toInteger()
            questionInstance.title = row[1] ?: "NA";
            questionInstance.answers[0] = row[2] ?: "NA";
            questionInstance.answers[1] = row[3] ?: "NA";
            questionInstance.answers[2] = row[4] ?: "NA";
            questionInstance.answers[3] = row[5] ?: "NA";
            String correct = row[6] ?: "NA";
            questionInstance.correctAnswer =  (correct.toInteger() -1)
            questionInstance.hint = row[7] ?: "NA";
            questionInstance.taskId = session.taskId as String
            questionInstance.ownerId = session.user.id as long
            questionInstance.save flush: true

        }
        redirect action: "index"

    }

}
