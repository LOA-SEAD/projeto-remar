package br.ufscar.sead.loa.santograu.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class FaseCampoMinadoController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET", exportQuestions: "POST"]

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
    def index() {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = QuestionFaseCampoMinado.findAllByOwnerId(session.user.id)
        if(list.size()==0){
            new QuestionFaseCampoMinado(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseCampoMinado.findAllByOwnerId(session.user.id)
        respond list, model: [faseCampoMinadoInstanceCount: QuestionFaseCampoMinado.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        respond questionFaseCampoMinadoInstance
    }

    def create() {
        respond new QuestionFaseCampoMinado(params)
    }

    @Transactional
    def save(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        if (questionFaseCampoMinadoInstance == null) {
            notFound()
            return
        }

        questionFaseCampoMinadoInstance.answers[0]= params.answers1
        questionFaseCampoMinadoInstance.answers[1]= params.answers2
        questionFaseCampoMinadoInstance.answers[2]= params.answers3
        questionFaseCampoMinadoInstance.answers[3]= params.answers4
        questionFaseCampoMinadoInstance.answers[4]= params.answers5
        questionFaseCampoMinadoInstance.ownerId = session.user.id as long
        questionFaseCampoMinadoInstance.taskId = session.taskId as String
        questionFaseCampoMinadoInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        respond questionFaseCampoMinadoInstance
    }

    @Transactional
    def update() {
        QuestionFaseCampoMinado questionFaseCampoMinadoInstance = QuestionFaseCampoMinado.findById(Integer.parseInt(params.faseCampoMinadoID))
        questionFaseCampoMinadoInstance.title = params.title
        questionFaseCampoMinadoInstance.answers[0]= params.answers1
        questionFaseCampoMinadoInstance.answers[1]= params.answers2
        questionFaseCampoMinadoInstance.answers[2]= params.answers3
        questionFaseCampoMinadoInstance.answers[3]= params.answers4
        questionFaseCampoMinadoInstance.answers[4]= params.answers5
        questionFaseCampoMinadoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseCampoMinadoInstance.ownerId = session.user.id as long
        questionFaseCampoMinadoInstance.taskId = session.taskId as String
        questionFaseCampoMinadoInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {

        if (questionFaseCampoMinadoInstance == null) {
            notFound()
            return
        }

        questionFaseCampoMinadoInstance.delete flush:true
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseCampoMinado.label', default: 'QuestionFaseCampoMinado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseCampoMinado questionFaseCampoMinadoInstance){
        if (questionFaseCampoMinadoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseCampoMinadoInstance.title + "%@!" +
                    questionFaseCampoMinadoInstance.answers[0] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[1] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[2] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[3] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[4] + "%@!" +
                    questionFaseCampoMinadoInstance.correctAnswer + "%@!" +
                    questionFaseCampoMinadoInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseCampoMinado> questionList = new ArrayList<QuestionFaseCampoMinado>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuestionFaseCampoMinado.findById(list_questionId[i]));

        //cria o arquivo json
        createJsonFile("questoescm.json", questionList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/questoescm.json")


        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
    }

    void createJsonFile(String fileName, ArrayList<QuestionFaseCampoMinado> questionList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write("{\n")
        pw.write("\t\"quantidadeQuestoes\": [\"" + questionList.size() + "\"],\n")
        for(def i=0; i<questionList.size();i++){
            pw.write("\t\"" + (i+1) + "\": [\"" + questionList[i].title + "\", ")
            pw.write("\""+ questionList[i].answers[0] +"\", " + "\""+ questionList[i].answers[1] +"\", ")
            pw.write("\""+ questionList[i].answers[2] +"\", " + "\""+ questionList[i].answers[3] +"\", ")
            pw.write("\""+ questionList[i].answers[4] +"\", ")
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
                case 3:
                    pw.write("\"D\"]")
                    break;
                case 4:
                    pw.write("\"E\"]")
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

    @Transactional
    def generateQuestions(){
        MultipartFile csv = params.csv
        def error = false;

        csv.inputStream.toCsvReader([ 'separatorChar': ';']).eachLine { row ->
            if(row.size() == 7) {
                QuestionFaseCampoMinado questionInstance = new QuestionFaseCampoMinado()
                questionInstance.title = row[0] ?: "NA";
                questionInstance.answers[0] = row[1] ?: "NA";
                questionInstance.answers[1] = row[2] ?: "NA";
                questionInstance.answers[2] = row[3] ?: "NA";
                questionInstance.answers[3] = row[4] ?: "NA";
                questionInstance.answers[4] = row[5] ?: "NA";
                String correct = row[6] ?: "NA";
                questionInstance.correctAnswer =  (correct.toInteger() - 1)
                questionInstance.taskId = session.taskId as String
                questionInstance.ownerId = session.user.id as long
                questionInstance.save flush: true
                println(questionInstance.errors)
            } else {
                error = true
            }
        }

        redirect(action: index(), params: [errorImportQuestions:error])
    }

    def exportCSV(){
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa5, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseCampoMinado> questionList = new ArrayList<QuestionFaseCampoMinado>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(QuestionFaseCampoMinado.findById(list_questionId[i]));

        }

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestions.csv"), "UTF-8"))

        for(int i=0; i<questionList.size();i++){
            fw.write(questionList.getAt(i).title + ";" + questionList.getAt(i).answers[0] + ";" + questionList.getAt(i).answers[1] + ";" +
                    questionList.getAt(i).answers[2] + ";" + questionList.getAt(i).answers[3] + ";" + questionList.getAt(i).answers[4] + ";" + (questionList.getAt(i).correctAnswer +1) + "\n" )
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/santograu/samples/export/exportQuestions.csv"
    }
}
