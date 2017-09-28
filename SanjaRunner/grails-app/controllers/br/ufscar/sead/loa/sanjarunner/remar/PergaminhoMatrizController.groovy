package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoMatrizController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportInformations: "POST", returnInstance: "GET", generateInformations: "POST"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportInformations','save', 'update', 'delete', 'generateInformations']]

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
        //params.max = Math.min(max ?: 10, 100)
        //respond PergaminhoMatriz.list(params), model:[pergaminhoMatrizInstanceCount: PergaminhoMatriz.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new PergaminhoMatriz(params)
        session.user = springSecurityService.currentUser

        def list = PergaminhoMatriz.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new PergaminhoMatriz(information: ["Informação 1", "Informação 2", "Informação 3", "Informação 4"], ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = PergaminhoMatriz.findAllByOwnerId(session.user.id)
        respond list, model: [pergaminhoMatrizInstanceCount: PergaminhoMatriz.count(), errorImportInformations: params.errorImportInformations]
    }

    def show(PergaminhoMatriz pergaminhoMatrizInstance) {
        respond pergaminhoMatrizInstance
    }

    def create() {
        respond new PergaminhoMatriz(params)
    }

    @Transactional
    def save(PergaminhoMatriz pergaminhoMatrizInstance) {
        if (pergaminhoMatrizInstance == null) {
            notFound()
            return
        }

        /*if (pergaminhoMatrizInstance.hasErrors()) {
            respond pergaminhoMatrizInstance.errors, view:'create'
            return
        }*/

        pergaminhoMatrizInstance.information[0]= params.information1
        pergaminhoMatrizInstance.information[1]= params.information2
        pergaminhoMatrizInstance.information[2]= params.information3
        pergaminhoMatrizInstance.information[3]= params.information4
        pergaminhoMatrizInstance.ownerId = session.user.id as long
        pergaminhoMatrizInstance.taskId = session.taskId as String
        pergaminhoMatrizInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoMatriz.label', default: 'PergaminhoMatriz'), pergaminhoMatrizInstance.id])
                redirect pergaminhoMatrizInstance
            }
            '*'{ respond pergaminhoMatrizInstance, [status: OK] }
        }*/
    }

    def edit(PergaminhoMatriz pergaminhoMatrizInstance) {
        respond pergaminhoMatrizInstance
    }

    @Transactional
    def update(/*PergaminhoMatriz pergaminhoMatrizInstance*/) {
        /*if (pergaminhoMatrizInstance == null) {
            notFound()
            return
        }

        if (pergaminhoMatrizInstance.hasErrors()) {
            respond pergaminhoMatrizInstance.errors, view:'edit'
            return
        }

        pergaminhoMatrizInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoMatriz.label', default: 'PergaminhoMatriz'), pergaminhoMatrizInstance.id])
                redirect pergaminhoMatrizInstance
            }
            '*'{ respond pergaminhoMatrizInstance, [status: OK] }
        }*/

        PergaminhoMatriz pergaminhoMatrizInstance = PergaminhoMatriz.findById(Integer.parseInt(params.pergaminhoMatrizID))
        pergaminhoMatrizInstance.information[0] = params.information1
        pergaminhoMatrizInstance.information[1] = params.information2
        pergaminhoMatrizInstance.information[2] = params.information3
        pergaminhoMatrizInstance.information[3] = params.information4
        pergaminhoMatrizInstance.ownerId = session.user.id as long
        pergaminhoMatrizInstance.taskId = session.taskId as String
        pergaminhoMatrizInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(PergaminhoMatriz pergaminhoMatrizInstance) {

        if (pergaminhoMatrizInstance == null) {
            notFound()
            return
        }

        pergaminhoMatrizInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PergaminhoMatriz.label', default: 'PergaminhoMatriz'), pergaminhoMatrizInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pergaminhoMatriz.label', default: 'PergaminhoMatriz'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(PergaminhoMatriz pergaminhoMatrizInstance){
        if (pergaminhoMatrizInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render pergaminhoMatrizInstance.information[0] + "%@!" +
                    pergaminhoMatrizInstance.information[1] + "%@!" +
                    pergaminhoMatrizInstance.information[2] + "%@!" +
                    pergaminhoMatrizInstance.information[3] + "%@!" +
                    pergaminhoMatrizInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportInformations(){

        //cria o txt do pergaminho da fase do Matriz
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoMatriz> informationList = new ArrayList<PergaminhoMatriz>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoMatriz.findById(list_informationId[i]))

        //cria o txt do pergaminho da fase do Matriz
        createTxtPergaminho("pergaminhoMatriz.txt", informationList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/pergaminhoMatriz.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"

    }

    void createTxtPergaminho(String fileName, ArrayList<PergaminhoMatriz> informationList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(informationList[0].information[0].replace("\"","\\\"") + "\n" + informationList[0].information[1].replace("\"","\\\"") + "\n" + informationList[0].information[2].replace("\"","\\\"") + "\n" + informationList[0].information[3].replace("\"","\\\""))
        pw.close();
    }

    @Transactional
    def generateInformations(){
        MultipartFile csv = params.csv
        def error = false

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 4) {
                PergaminhoMatriz pergaminhoMatrizInstance = PergaminhoMatriz.findById(1)
                pergaminhoMatrizInstance.information[0] = row[0] ?: "NA"
                pergaminhoMatrizInstance.information[1] = row[1] ?: "NA"
                pergaminhoMatrizInstance.information[2] = row[2] ?: "NA"
                pergaminhoMatrizInstance.information[3] = row[3] ?: "NA"
                pergaminhoMatrizInstance.taskId = session.taskId as String
                pergaminhoMatrizInstance.ownerId = session.user.id as long
                pergaminhoMatrizInstance.save flush: true
                println(pergaminhoMatrizInstance.errors)
            } else {
                error = true
            }
        }

        redirect(action: index(), params: [errorImportInformations:error])
    }

    def exportCSV(){
        /* Funcao que exporta as informacoes selecionadas para um arquivo .csv generico.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Informacao1, Informacao2, Informacao3, Informacao4.
           O separador do arquivo .csv gerado eh o ";" (ponto e virgula)
        */

        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoMatriz> informationList = new ArrayList<PergaminhoMatriz>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoMatriz.findById(list_informationId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportInformationsMatriz.csv"), "UTF-8"))

        fw.write(informationList[0].information[0] + ";" + informationList[0].information[1] + ";" + informationList[0].information[2] + ";" + informationList[0].information[3] + "\n")
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportInformationsMatriz.csv"
    }
}
