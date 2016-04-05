package br.ufscar.sead.loa.respondasepuder.remar



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: ["GET","POST"]]

    def index() {
        respond Question.list(), model:[questionInstanceCount: Question.count()]
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

        createJsonFile("pergFacil.json",questionList_level1)
        createJsonFile("pergMedio.json",questionList_level2)
        createJsonFile("pergDificl.json",questionList_level3)

        render "Questões exportadas com sucesso"


    }

    void createJsonFile(String fileName, ArrayList<Question> questionList ){
        int i = 0
        File file = new File(fileName);
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n ");
        pw.write("\"numero\":[\"" + questionList.size()+ "\",\"4\"],\n")
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
        pw.write("\n}");
        pw.close();

    }

}
