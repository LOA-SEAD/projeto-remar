package br.ufscar.sead.loa.santograuacessivel.remar
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class FaseCampoFutebolController {
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

        def list = QuestionFaseCampoFutebol.findAllByOwnerId(session.user.id)
        if(list.size()==0){
            new QuestionFaseCampoFutebol(title: "Desafio 1", answer: "Resposta 1", ownerId: session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoFutebol(title: "Desafio 2", answer: "Resposta 2", ownerId: session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseCampoFutebol.findAllByOwnerId(session.user.id)
        respond list, model: QuestionFaseCampoFutebol.count(), errorImportQuestions:params.errorImportQuestions
    }

    def show(QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance) {
        respond QuestionFaseCampoFutebolInstance
    }

    def create() {
        respond new QuestionFaseCampoFutebol(params)
    }

    @Transactional
    def save(QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance) {
        if (QuestionFaseCampoFutebolInstance == null) {
            notFound()
            return
        }

        QuestionFaseCampoFutebolInstance.answer = params.answer
        QuestionFaseCampoFutebolInstance.ownerId = session.user.id as long
        QuestionFaseCampoFutebolInstance.taskId = session.taskId as String
        QuestionFaseCampoFutebolInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance) {
        respond QuestionFaseCampoFutebolInstance
    }

    @Transactional
    def update() {

        QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance = QuestionFaseCampoFutebol.findById(params.faseCampoFutebolID)
        QuestionFaseCampoFutebolInstance.title = params.title
        QuestionFaseCampoFutebolInstance.answer = params.answer
        QuestionFaseCampoFutebolInstance.ownerId = session.user.id as long
        QuestionFaseCampoFutebolInstance.taskId = session.taskId as String
        QuestionFaseCampoFutebolInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance) {
        if (QuestionFaseCampoFutebolInstance == null) {
            notFound()
            return
        }

        QuestionFaseCampoFutebolInstance.delete flush:true
        render "delete OK"
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseCampoFutebol.label', default: 'QuestionFaseCampoFutebol'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseCampoFutebol QuestionFaseCampoFutebolInstance){
        if (QuestionFaseCampoFutebolInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render QuestionFaseCampoFutebolInstance.title + "%@!" +
                    QuestionFaseCampoFutebolInstance.answer + "%@!" +
                    QuestionFaseCampoFutebolInstance.id
        }
    }

    @Secured(['permitAll'])
    def exportQuestions(){
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseCampoFutebol> questionList = new ArrayList<QuestionFaseCampoFutebol>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++)
            questionList.add(QuestionFaseCampoFutebol.findById(list_questionId[i]));

        //cria o arquivo json
        createJsonFile("campo.json", questionList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/campo.json")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
    }

    void createJsonFile(String fileName, ArrayList<QuestionFaseCampoFutebol> questionList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write("{\n")
        for(def i=0; i<questionList.size(); i++){
            pw.write("\t\"desafio" + (i+1) + "\": [\"" + questionList[i].title.replace("\"","\\\"") + "\", ")
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
        MultipartFile csv = params.csv
        def error = false;

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 2) {
                QuestionFaseCampoFutebol questionInstance = new QuestionFaseCampoFutebol()
                questionInstance.title = row[0] ?: "NA";
                questionInstance.answer = row[1] ?: "NA";
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
                Pergunta, Resposta.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>() ;
        ArrayList<QuestionFaseCampoFutebol> questionList = new ArrayList<QuestionFaseCampoFutebol>();
        list_questionId.addAll(params.list_id);
        for (int i=0; i<list_questionId.size();i++){
            questionList.add(QuestionFaseCampoFutebol.findById(list_questionId[i]));
        }

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestions.csv"), "UTF-8"))

        for(int i=0; i<questionList.size();i++){
            fw.write(questionList.getAt(i).title + ";" + questionList.getAt(i).answer + ";" + "\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/santograuacessivel/samples/export/exportQuestions.csv"
    }
}
