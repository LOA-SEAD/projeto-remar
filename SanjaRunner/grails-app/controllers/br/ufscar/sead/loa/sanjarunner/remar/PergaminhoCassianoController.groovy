package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoCassianoController {

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
        //respond PergaminhoCassiano.list(params), model:[pergaminhoCassianoInstanceCount: PergaminhoCassiano.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new PergaminhoCassiano(params)
        session.user = springSecurityService.currentUser

        def list = PergaminhoCassiano.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new PergaminhoCassiano(information: ["Informação 1", "Informação 2", "Informação 3", "Informação 4", "Informação 5"], ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = PergaminhoCassiano.findAllByOwnerId(session.user.id)
        respond list, model: [pergaminhoCassianoInstanceCount: PergaminhoCassiano.count(), errorImportInformations: params.errorImportInformations]
    }

    def show(PergaminhoCassiano pergaminhoCassianoInstance) {
        respond pergaminhoCassianoInstance
    }

    def create() {
        respond new PergaminhoCassiano(params)
    }

    @Transactional
    def save(PergaminhoCassiano pergaminhoCassianoInstance) {
        if (pergaminhoCassianoInstance == null) {
            notFound()
            return
        }

        /*if (pergaminhoCassianoInstance.hasErrors()) {
            respond pergaminhoCassianoInstance.errors, view:'create'
            return
        }*/

        pergaminhoCassianoInstance.information[0]= params.information1
        pergaminhoCassianoInstance.information[1]= params.information2
        pergaminhoCassianoInstance.information[2]= params.information3
        pergaminhoCassianoInstance.information[3]= params.information4
        pergaminhoCassianoInstance.information[4]= params.information5
        pergaminhoCassianoInstance.ownerId = session.user.id as long
        pergaminhoCassianoInstance.taskId = session.taskId as String
        pergaminhoCassianoInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoCassiano.label', default: 'PergaminhoCassiano'), pergaminhoCassianoInstance.id])
                redirect pergaminhoCassianoInstance
            }
            '*'{ respond pergaminhoCassianoInstance, [status: OK] }
        }*/
    }

    def edit(PergaminhoCassiano pergaminhoCassianoInstance) {
        respond pergaminhoCassianoInstance
    }

    @Transactional
    def update(/*PergaminhoCassiano pergaminhoCassianoInstance*/) {
        /*if (pergaminhoCassianoInstance == null) {
            notFound()
            return
        }

        if (pergaminhoCassianoInstance.hasErrors()) {
            respond pergaminhoCassianoInstance.errors, view:'edit'
            return
        }

        pergaminhoCassianoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoCassiano.label', default: 'PergaminhoCassiano'), pergaminhoCassianoInstance.id])
                redirect pergaminhoCassianoInstance
            }
            '*'{ respond pergaminhoCassianoInstance, [status: OK] }
        }*/

        PergaminhoCassiano pergaminhoCassianoInstance = PergaminhoCassiano.findById(Integer.parseInt(params.pergaminhoCassianoID))
        pergaminhoCassianoInstance.information[0] = params.information1
        pergaminhoCassianoInstance.information[1] = params.information2
        pergaminhoCassianoInstance.information[2] = params.information3
        pergaminhoCassianoInstance.information[3] = params.information4
        pergaminhoCassianoInstance.information[4] = params.information5
        pergaminhoCassianoInstance.ownerId = session.user.id as long
        pergaminhoCassianoInstance.taskId = session.taskId as String
        pergaminhoCassianoInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(PergaminhoCassiano pergaminhoCassianoInstance) {

        if (pergaminhoCassianoInstance == null) {
            notFound()
            return
        }

        pergaminhoCassianoInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PergaminhoCassiano.label', default: 'PergaminhoCassiano'), pergaminhoCassianoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pergaminhoCassiano.label', default: 'PergaminhoCassiano'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(PergaminhoCassiano pergaminhoCassianoInstance){
        if (pergaminhoCassianoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render pergaminhoCassianoInstance.information[0] + "%@!" +
                    pergaminhoCassianoInstance.information[1] + "%@!" +
                    pergaminhoCassianoInstance.information[2] + "%@!" +
                    pergaminhoCassianoInstance.information[3] + "%@!" +
                    pergaminhoCassianoInstance.information[4] + "%@!" +
                    pergaminhoCassianoInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportInformations(){

        //cria o txt do pergaminho da fase do Cassiano
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoCassiano> informationList = new ArrayList<PergaminhoCassiano>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoCassiano.findById(list_informationId[i]))

        //cria o txt do pergaminho da fase do Cassiano
        createTxtPergaminho("pergaminhoCassiano.txt", informationList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/pergaminhoCassiano.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"

    }

    void createTxtPergaminho(String fileName, ArrayList<PergaminhoCassiano> informationList){
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
                PergaminhoCassiano pergaminhoCassianoInstance = PergaminhoCassiano.findById(1)
                pergaminhoCassianoInstance.information[0] = row[0] ?: "NA"
                pergaminhoCassianoInstance.information[1] = row[1] ?: "NA"
                pergaminhoCassianoInstance.information[2] = row[2] ?: "NA"
                pergaminhoCassianoInstance.information[3] = row[3] ?: "NA"
                pergaminhoCassianoInstance.information[4] = row[4] ?: "NA"
                pergaminhoCassianoInstance.taskId = session.taskId as String
                pergaminhoCassianoInstance.ownerId = session.user.id as long
                pergaminhoCassianoInstance.save flush: true
                println(pergaminhoCassianoInstance.errors)
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
        ArrayList<PergaminhoCassiano> informationList = new ArrayList<PergaminhoCassiano>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoCassiano.findById(list_informationId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportInformationsCassiano.csv"), "UTF-8"))

        fw.write(informationList[0].information[0] + ";" + informationList[0].information[1] + ";" + informationList[0].information[2] + ";" + informationList[0].information[3] + ";" + informationList[0].information[4] + "\n")
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportInformationsCassiano.csv"
    }
}
