package br.ufscar.sead.loa.santograuacessivel.remar
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.util.Environment


@Secured(["isAuthenticated()"])
class FaseBibliotecaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
    @Transactional
    def index() {
        if (params.t) {
            session.taskId = params.t
        }

        session.user = springSecurityService.currentUser

        def list = QuestionFaseBiblioteca.findAllByOwnerId(session.user.id)
        if(list.size()==0){
            new QuestionFaseBiblioteca(tips: ["Dica A", "Dica B", "Dica C"], answer: "Resposta 1", ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBiblioteca(tips: ["Dica A", "Dica B", "Dica C"], answer: "Resposta 2", ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBiblioteca(tips: ["Dica A", "Dica B", "Dica C"], answer: "Resposta 3", ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseBiblioteca.findAllByOwnerId(session.user.id)
        respond list, model: [questionFaseBibliotecaInstanceCount: QuestionFaseBiblioteca.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(QuestionFaseBiblioteca questionFaseBibliotecaInstance) {
        respond questionFaseBibliotecaInstance
    }

    def create() {
        respond new QuestionFaseBiblioteca(params)
    }

    @Transactional
    def save(QuestionFaseBiblioteca questionFaseBibliotecaInstance) {
        if (questionFaseBibliotecaInstance == null) {
            notFound()
            return
        }

        questionFaseBibliotecaInstance.tips[0] = params.tip1
        questionFaseBibliotecaInstance.tips[1] = params.tip2
        questionFaseBibliotecaInstance.tips[2] = params.tip3
        questionFaseBibliotecaInstance.answer = params.answer
        questionFaseBibliotecaInstance.ownerId = session.user.id as long
        questionFaseBibliotecaInstance.taskId = session.taskId as String
        questionFaseBibliotecaInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseBiblioteca questionFaseBibliotecaInstance) {
        respond questionFaseBibliotecaInstance
    }

    @Transactional
    def update() {
        QuestionFaseBiblioteca questionFaseBibliotecaInstance = QuestionFaseBiblioteca.findById(Integer.parseInt(params.faseBibliotecaID))
        questionFaseBibliotecaInstance.tips[0] = params.tip1
        questionFaseBibliotecaInstance.tips[1] = params.tip2
        questionFaseBibliotecaInstance.tips[2] = params.tip3
        questionFaseBibliotecaInstance.answer = params.answer
        questionFaseBibliotecaInstance.ownerId = session.user.id as long
        questionFaseBibliotecaInstance.taskId = session.taskId as String
        questionFaseBibliotecaInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseBiblioteca QuestionFaseBibliotecaInstance) {
        if (QuestionFaseBibliotecaInstance == null) {
            notFound()
            return
        }

        QuestionFaseBibliotecaInstance.delete flush:true
        render "delete OK"
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseBiblioteca.label', default: 'QuestionFaseBiblioteca'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseBiblioteca QuestionFaseBibliotecaInstance){
        if (QuestionFaseBibliotecaInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render QuestionFaseBibliotecaInstance.tips[0] + "%@!" +
                    QuestionFaseBibliotecaInstance.tips[1] + "%@!" +
                    QuestionFaseBibliotecaInstance.tips[2] + "%@!" +
                    QuestionFaseBibliotecaInstance.answer + "%@!" +
                    QuestionFaseBibliotecaInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseBiblioteca> questionList = new ArrayList<QuestionFaseBiblioteca>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuestionFaseBiblioteca.findById(list_questionId[i]));

        //cria o arquivo json
        createJsonFile("biblioteca.json", questionList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/biblioteca.json")


        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
    }

    void createJsonFile(String fileName, ArrayList<QuestionFaseBiblioteca> questionList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write("{\n")
        for(def i=0; i<questionList.size(); i++){
            pw.write("\t\"livro" + (i+1) + "\": [\"" + questionList[i].tips[0].replace("\"","\\\"") + "\", ")
            pw.write("\"" + questionList[i].tips[1].replace("\"","\\\"") + "\", ")
            pw.write("\"" + questionList[i].tips[2].replace("\"","\\\"") + "\", ")
            pw.write("\""+ questionList[i].answer.replace("\"","\\\"") +"\"]")

            if(i<questionList.size()-1)
                pw.write(",")
            pw.write("\n")
        }
        pw.write("}");
        pw.close();
    }

    @Transactional
    def generateQuestions(){
        // Função de importar CSV
        MultipartFile csv = params.csv
        def error = false;

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 4) {
                QuestionFaseBiblioteca questionInstance = new QuestionFaseBiblioteca()
                questionInstance.tips[0] = row[0] ?: "NA";
                questionInstance.tips[1] = row[1] ?: "NA";
                questionInstance.tips[2] = row[2] ?: "NA";
                questionInstance.answer = row[3] ?: "NA";
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
           O arquivo gerado possui os seguintes campos na ordem correspondente:
                Dica; Dica; Dica; Resposta.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseBiblioteca> questionList = new ArrayList<QuestionFaseBiblioteca>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(QuestionFaseBiblioteca.findById(list_questionId[i]));
        }

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestions.csv"), "UTF-8"))

        for(int i=0; i<questionList.size();i++){
            fw.write(questionList.getAt(i).tips[0] + ";" + questionList.getAt(i).tips[1] + ";" +
                    questionList.getAt(i).tips[2] + ";" + questionList.getAt(i).answer + "\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/santograuacessivel/samples/export/exportQuestions.csv"
    }
}
