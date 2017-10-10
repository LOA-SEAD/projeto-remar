package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoSantosController {

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
        //respond PergaminhoSantos.list(params), model:[pergaminhoSantosInstanceCount: PergaminhoSantos.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new PergaminhoSantos(params)
        session.user = springSecurityService.currentUser

        def list = PergaminhoSantos.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new PergaminhoSantos(information: ["Informação 1", "Informação 2", "Informação 3", "Informação 4", "Informação 5"], ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = PergaminhoSantos.findAllByOwnerId(session.user.id)
        respond list, model: [pergaminhoSantosInstanceCount: PergaminhoSantos.count(), errorImportInformations: params.errorImportInformations]
    }

    def show(PergaminhoSantos pergaminhoSantosInstance) {
        respond pergaminhoSantosInstance
    }

    def create() {
        respond new PergaminhoSantos(params)
    }

    @Transactional
    def save(PergaminhoSantos pergaminhoSantosInstance) {
        if (pergaminhoSantosInstance == null) {
            notFound()
            return
        }

        /*if (pergaminhoSantosInstance.hasErrors()) {
            respond pergaminhoSantosInstance.errors, view:'create'
            return
        }*/

        pergaminhoSantosInstance.information[0]= params.information1
        pergaminhoSantosInstance.information[1]= params.information2
        pergaminhoSantosInstance.information[2]= params.information3
        pergaminhoSantosInstance.information[3]= params.information4
        pergaminhoSantosInstance.information[4]= params.information5
        pergaminhoSantosInstance.ownerId = session.user.id as long
        pergaminhoSantosInstance.taskId = session.taskId as String
        pergaminhoSantosInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoSantos.label', default: 'PergaminhoSantos'), pergaminhoSantosInstance.id])
                redirect pergaminhoSantosInstance
            }
            '*'{ respond pergaminhoSantosInstance, [status: OK] }
        }*/
    }

    def edit(PergaminhoSantos pergaminhoSantosInstance) {
        respond pergaminhoSantosInstance
    }

    @Transactional
    def update(/*PergaminhoSantos pergaminhoSantosInstance*/) {
        /*if (pergaminhoSantosInstance == null) {
            notFound()
            return
        }

        if (pergaminhoSantosInstance.hasErrors()) {
            respond pergaminhoSantosInstance.errors, view:'edit'
            return
        }

        pergaminhoSantosInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoSantos.label', default: 'PergaminhoSantos'), pergaminhoSantosInstance.id])
                redirect pergaminhoSantosInstance
            }
            '*'{ respond pergaminhoSantosInstance, [status: OK] }
        }*/

        PergaminhoSantos pergaminhoSantosInstance = PergaminhoSantos.findById(Integer.parseInt(params.pergaminhoSantosID))
        pergaminhoSantosInstance.information[0] = params.information1
        pergaminhoSantosInstance.information[1] = params.information2
        pergaminhoSantosInstance.information[2] = params.information3
        pergaminhoSantosInstance.information[3] = params.information4
        pergaminhoSantosInstance.information[4] = params.information5
        pergaminhoSantosInstance.ownerId = session.user.id as long
        pergaminhoSantosInstance.taskId = session.taskId as String
        pergaminhoSantosInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(PergaminhoSantos pergaminhoSantosInstance) {

        if (pergaminhoSantosInstance == null) {
            notFound()
            return
        }

        pergaminhoSantosInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PergaminhoSantos.label', default: 'PergaminhoSantos'), pergaminhoSantosInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pergaminhoSantos.label', default: 'PergaminhoSantos'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(PergaminhoSantos pergaminhoSantosInstance){
        if (pergaminhoSantosInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render pergaminhoSantosInstance.information[0] + "%@!" +
                    pergaminhoSantosInstance.information[1] + "%@!" +
                    pergaminhoSantosInstance.information[2] + "%@!" +
                    pergaminhoSantosInstance.information[3] + "%@!" +
                    pergaminhoSantosInstance.information[4] + "%@!" +
                    pergaminhoSantosInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportInformations(){

        //cria o txt do pergaminho da fase do Santos
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoSantos> informationList = new ArrayList<PergaminhoSantos>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoSantos.findById(list_informationId[i]))

        //cria o txt do pergaminho da fase do Santos
        createTxtPergaminho("pergaminhoSantos.txt", informationList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/pergaminhoSantos.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"

    }

    void createTxtPergaminho(String fileName, ArrayList<PergaminhoSantos> informationList){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write(informationList[0].information[0].replace("\"","\\\"") + "\n" + informationList[0].information[1].replace("\"","\\\"") + "\n" + informationList[0].information[2].replace("\"","\\\"") + "\n" + informationList[0].information[3].replace("\"","\\\"") + "\n" + informationList[0].information[4].replace("\"","\\\""))
        pw.close();
    }

    @Transactional
    def generateInformations(){
        String text
        char [] correctText = new char[600]

        MultipartFile csv = params.csv
        def error = false

        csv.inputStream.toCsvReader([ 'separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->
            if(row.size() == 5) {
                //Tratamento para inputs maiores que 600 caracteres
                for (int i=0; i<row.size(); i++){
                    if (row[i].length() > 600){
                        text = row[i]
                        text.getChars(0, 600, correctText, 0)
                        row[i] = new String(correctText)
                    }
                }
                PergaminhoSantos pergaminhoSantosInstance = PergaminhoSantos.findById(1)
                pergaminhoSantosInstance.information[0] = row[0] ?: "NA"
                pergaminhoSantosInstance.information[1] = row[1] ?: "NA"
                pergaminhoSantosInstance.information[2] = row[2] ?: "NA"
                pergaminhoSantosInstance.information[3] = row[3] ?: "NA"
                pergaminhoSantosInstance.information[4] = row[4] ?: "NA"
                pergaminhoSantosInstance.taskId = session.taskId as String
                pergaminhoSantosInstance.ownerId = session.user.id as long
                pergaminhoSantosInstance.save flush: true
                println(pergaminhoSantosInstance.errors)
            } else {
                error = true
            }
        }

        redirect(action: index(), params: [errorImportInformations:error])
    }

    def exportCSV(){
        /* Funcao que exporta as informacoes selecionadas para um arquivo .csv generico.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Informacao1, Informacao2, Informacao3, Informacao4, Informacao5.
           O separador do arquivo .csv gerado eh o ";" (ponto e virgula)
        */

        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoSantos> informationList = new ArrayList<PergaminhoSantos>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoSantos.findById(list_informationId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportInformationsSantos.csv"), "UTF-8"))

        fw.write(informationList[0].information[0] + ";" + informationList[0].information[1] + ";" + informationList[0].information[2] + ";" + informationList[0].information[3] + ";" + informationList[0].information[4] + "\n")
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportInformationsSantos.csv"
    }
}
