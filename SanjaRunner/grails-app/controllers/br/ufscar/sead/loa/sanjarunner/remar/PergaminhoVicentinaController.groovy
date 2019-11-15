package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoVicentinaController {

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
        //respond PergaminhoVicentina.list(params), model:[pergaminhoVicentinaInstanceCount: PergaminhoVicentina.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new PergaminhoVicentina(params)
        session.user = springSecurityService.currentUser

        def list = PergaminhoVicentina.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new PergaminhoVicentina(information: ["Informação 1", "Informação 2", "Informação 3", "Informação 4"], ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = PergaminhoVicentina.findAllByOwnerId(session.user.id)
        respond list, model: [pergaminhoVicentinaInstanceCount: PergaminhoVicentina.count(), errorImportInformations: params.errorImportInformations]
    }

    def show(PergaminhoVicentina pergaminhoVicentinaInstance) {
        respond pergaminhoVicentinaInstance
    }

    def create() {
        respond new PergaminhoVicentina(params)
    }

    @Transactional
    def save(PergaminhoVicentina pergaminhoVicentinaInstance) {
        if (pergaminhoVicentinaInstance == null) {
            notFound()
            return
        }

        /*if (pergaminhoVicentinaInstance.hasErrors()) {
            respond pergaminhoVicentinaInstance.errors, view:'create'
            return
        }*/

        pergaminhoVicentinaInstance.information[0]= params.information1
        pergaminhoVicentinaInstance.information[1]= params.information2
        pergaminhoVicentinaInstance.information[2]= params.information3
        pergaminhoVicentinaInstance.information[3]= params.information4
        pergaminhoVicentinaInstance.ownerId = session.user.id as long
        pergaminhoVicentinaInstance.taskId = session.taskId as String
        pergaminhoVicentinaInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoVicentina.label', default: 'PergaminhoVicentina'), pergaminhoVicentinaInstance.id])
                redirect pergaminhoVicentinaInstance
            }
            '*'{ respond pergaminhoVicentinaInstance, [status: OK] }
        }*/
    }

    def edit(PergaminhoVicentina pergaminhoVicentinaInstance) {
        respond pergaminhoVicentinaInstance
    }

    @Transactional
    def update(/*PergaminhoVicentina pergaminhoVicentinaInstance*/) {
        /*if (pergaminhoVicentinaInstance == null) {
            notFound()
            return
        }

        if (pergaminhoVicentinaInstance.hasErrors()) {
            respond pergaminhoVicentinaInstance.errors, view:'edit'
            return
        }

        pergaminhoVicentinaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoVicentina.label', default: 'PergaminhoVicentina'), pergaminhoVicentinaInstance.id])
                redirect pergaminhoVicentinaInstance
            }
            '*'{ respond pergaminhoVicentinaInstance, [status: OK] }
        }*/

        PergaminhoVicentina pergaminhoVicentinaInstance = PergaminhoVicentina.findById(Integer.parseInt(params.pergaminhoVicentinaID))
        pergaminhoVicentinaInstance.information[0] = params.information1
        pergaminhoVicentinaInstance.information[1] = params.information2
        pergaminhoVicentinaInstance.information[2] = params.information3
        pergaminhoVicentinaInstance.information[3] = params.information4
        pergaminhoVicentinaInstance.ownerId = session.user.id as long
        pergaminhoVicentinaInstance.taskId = session.taskId as String
        pergaminhoVicentinaInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(PergaminhoVicentina pergaminhoVicentinaInstance) {

        if (pergaminhoVicentinaInstance == null) {
            notFound()
            return
        }

        pergaminhoVicentinaInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PergaminhoVicentina.label', default: 'PergaminhoVicentina'), pergaminhoVicentinaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pergaminhoVicentina.label', default: 'PergaminhoVicentina'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(PergaminhoVicentina pergaminhoVicentinaInstance){
        if (pergaminhoVicentinaInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render pergaminhoVicentinaInstance.information[0] + "%@!" +
                    pergaminhoVicentinaInstance.information[1] + "%@!" +
                    pergaminhoVicentinaInstance.information[2] + "%@!" +
                    pergaminhoVicentinaInstance.information[3] + "%@!" +
                    pergaminhoVicentinaInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportInformations(){

        //cria o txt do pergaminho da fase do Vicentina
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoVicentina> informationList = new ArrayList<PergaminhoVicentina>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoVicentina.findById(list_informationId[i]))

        //cria o txt do pergaminho da fase do Vicentina
        createTxtPergaminho("pergaminhoVicentina.txt", informationList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/pergaminhoVicentina.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"

    }

    void createTxtPergaminho(String fileName, ArrayList<PergaminhoVicentina> informationList){
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
                PergaminhoVicentina pergaminhoVicentinaInstance = PergaminhoVicentina.findById(1)
                pergaminhoVicentinaInstance.information[0] = row[0] ?: "NA"
                pergaminhoVicentinaInstance.information[1] = row[1] ?: "NA"
                pergaminhoVicentinaInstance.information[2] = row[2] ?: "NA"
                pergaminhoVicentinaInstance.information[3] = row[3] ?: "NA"
                pergaminhoVicentinaInstance.taskId = session.taskId as String
                pergaminhoVicentinaInstance.ownerId = session.user.id as long
                pergaminhoVicentinaInstance.save flush: true
                println(pergaminhoVicentinaInstance.errors)
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
        ArrayList<PergaminhoVicentina> informationList = new ArrayList<PergaminhoVicentina>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoVicentina.findById(list_informationId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportInformationsVicentina.csv"), "UTF-8"))

        fw.write(informationList[0].information[0] + ";" + informationList[0].information[1] + ";" + informationList[0].information[2] + ";" + informationList[0].information[3] + "\n")
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportInformationsVicentina.csv"
    }
}
