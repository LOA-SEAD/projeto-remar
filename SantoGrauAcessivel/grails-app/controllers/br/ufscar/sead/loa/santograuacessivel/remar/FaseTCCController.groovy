package br.ufscar.sead.loa.santograuacessivel.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseTCCController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET"]
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
        if (params.t) {
            session.taskId = params.t
        }
        if (params.p) {
            session.processId = params.p
        }
        session.user = springSecurityService.currentUser

        def list = QuestionFaseTCC.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuestionFaseTCC(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 5", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseTCC.findAllByOwnerId(session.user.id)
        respond list, model: [questionFaseTccInstanceCount: QuestionFaseTCC.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuestionFaseTCC faseTCCInstance) {
        respond faseTCCInstance
    }

    def create() {
        respond new QuestionFaseTCC(params)
    }

    @Transactional
    def save(QuestionFaseTCC questionFaseTCCInstance) {
        if (questionFaseTCCInstance == null) {
            notFound()
            return
        }

        questionFaseTCCInstance.answers[0]= params.answers1
        questionFaseTCCInstance.answers[1]= params.answers2
        questionFaseTCCInstance.answers[2]= params.answers3
        questionFaseTCCInstance.answers[3]= params.answers4
        questionFaseTCCInstance.answers[4]= params.answers5
        questionFaseTCCInstance.ownerId = session.user.id as long
        questionFaseTCCInstance.taskId = session.taskId as String
        questionFaseTCCInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseTCC questionFaseTCCInstance) {
        respond questionFaseTCCInstance
    }

    @Transactional
    def update() {
        QuestionFaseTCC questionFaseTCCInstance = QuestionFaseTCC.findById(Integer.parseInt(params.faseTCCID))
        questionFaseTCCInstance.title = params.title
        questionFaseTCCInstance.answers[0]= params.answers1
        questionFaseTCCInstance.answers[1]= params.answers2
        questionFaseTCCInstance.answers[2]= params.answers3
        questionFaseTCCInstance.answers[3]= params.answers4
        questionFaseTCCInstance.answers[4]= params.answers5
        questionFaseTCCInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseTCCInstance.ownerId = session.user.id as long
        questionFaseTCCInstance.taskId = session.taskId as String
        questionFaseTCCInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseTCC questionFaseTCCInstance) {

        if (questionFaseTCCInstance == null) {
            notFound()
            return
        }

        questionFaseTCCInstance.delete flush:true
        render "delete OK"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseTCC.label', default: 'QuestionFaseTCC'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseTCC questionFaseTCCInstance){
        if (questionFaseTCCInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseTCCInstance.title + "%@!" +
                    questionFaseTCCInstance.answers[0] + "%@!" +
                    questionFaseTCCInstance.answers[1] + "%@!" +
                    questionFaseTCCInstance.answers[2] + "%@!" +
                    questionFaseTCCInstance.answers[3] + "%@!" +
                    questionFaseTCCInstance.answers[4] + "%@!" +
                    questionFaseTCCInstance.correctAnswer + "%@!" +
                    questionFaseTCCInstance.id
        }

    }

    @Transactional
    def exportQuestions(){
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseTCC> questionList = new ArrayList<QuestionFaseTCC>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuestionFaseTCC.findById(list_questionId[i]));

        //cria o arquivo json
        createJsonFile("questoestcc.json", questionList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/questoestcc.json")


        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
    }

    void createJsonFile(String fileName, ArrayList<QuestionFaseTCC> questionList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write("{\n")
        pw.write("\t\"quantidadeQuestoes\": [\"" + questionList.size() + "\"],\n")
        for(def i=0; i<questionList.size();i++){
            pw.write("\t\"" + (i+1) + "\": [\"" + questionList[i].title.replace("\"","\\\"") + "\", ")
            pw.write("\""+ questionList[i].answers[0].replace("\"","\\\"") +"\", " + "\""+ questionList[i].answers[1].replace("\"","\\\"") +"\", ")
            pw.write("\""+ questionList[i].answers[2].replace("\"","\\\"") +"\", " + "\""+ questionList[i].answers[3].replace("\"","\\\"") +"\", ")
            pw.write("\""+ questionList[i].answers[4].replace("\"","\\\"") +"\", ")
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

        //se o arquivo fases.json nao existe, cria ele com nenhuma fase opcional
        def fasesFolder = new File("${dataPath}/${springSecurityService.currentUser.id}/processes/${session.processId}")
        fasesFolder.mkdirs()
        File fileFasesJson = new File("$fasesFolder/fases.json")
        boolean exists = fileFasesJson.exists()
        if(!exists) {
            PrintWriter printer = new PrintWriter(fileFasesJson);
            printer.write("{\n");
            printer.write("\t\"quantidade\": [\"0\"],\n")
            printer.write("\t\"fases\": [\"1\", \"2\"]\n")
            printer.write("}")
            printer.close();
        }
    }

    @Transactional
    def generateQuestions(){
        MultipartFile csv = params.csv
        def error = false;

        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 7) {
                QuestionFaseTCC questionInstance = new QuestionFaseTCC()
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
        ArrayList<QuestionFaseTCC> questionList = new ArrayList<QuestionFaseTCC>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(QuestionFaseTCC.findById(list_questionId[i]));

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

        render "/santograuacessivel/samples/export/exportQuestions.csv"
    }
}
