package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoBanhadoController {

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
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)
        //respond PergaminhoBanhado.list(params), model:[pergaminhoBanhadoInstanceCount: PergaminhoBanhado.count()]
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        //respond new PergaminhoBanhado(params)
        session.user = springSecurityService.currentUser

        def list = PergaminhoBanhado.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new PergaminhoBanhado(information: ["Informação 1", "Informação 2", "Informação 3", "Informação 4"], ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = PergaminhoBanhado.findAllByOwnerId(session.user.id)
        respond list, model: [pergaminhoBanhadoInstanceCount: PergaminhoBanhado.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(PergaminhoBanhado pergaminhoBanhadoInstance) {
        respond pergaminhoBanhadoInstance
    }

    def create() {
        respond new PergaminhoBanhado(params)
    }

    @Transactional
    def save(PergaminhoBanhado pergaminhoBanhadoInstance) {
        if (pergaminhoBanhadoInstance == null) {
            notFound()
            return
        }

        /*if (pergaminhoBanhadoInstance.hasErrors()) {
            respond pergaminhoBanhadoInstance.errors, view:'create'
            return
        }*/

        pergaminhoBanhadoInstance.information[0]= params.information1
        pergaminhoBanhadoInstance.information[1]= params.information2
        pergaminhoBanhadoInstance.information[2]= params.information3
        pergaminhoBanhadoInstance.information[3]= params.information4
        pergaminhoBanhadoInstance.ownerId = session.user.id as long
        pergaminhoBanhadoInstance.taskId = session.taskId as String
        pergaminhoBanhadoInstance.save flush:true
        redirect(action: "index")

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoBanhado.label', default: 'PergaminhoBanhado'), pergaminhoBanhadoInstance.id])
                redirect pergaminhoBanhadoInstance
            }
            '*'{ respond pergaminhoBanhadoInstance, [status: OK] }
        }*/
    }

    def edit(PergaminhoBanhado pergaminhoBanhadoInstance) {
        respond pergaminhoBanhadoInstance
    }

    @Transactional
    def update(/*PergaminhoBanhado pergaminhoBanhadoInstance*/) {
        /*if (pergaminhoBanhadoInstance == null) {
            notFound()
            return
        }

        if (pergaminhoBanhadoInstance.hasErrors()) {
            respond pergaminhoBanhadoInstance.errors, view:'edit'
            return
        }

        pergaminhoBanhadoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PergaminhoBanhado.label', default: 'PergaminhoBanhado'), pergaminhoBanhadoInstance.id])
                redirect pergaminhoBanhadoInstance
            }
            '*'{ respond pergaminhoBanhadoInstance, [status: OK] }
        }*/

        PergaminhoBanhado pergaminhoBanhadoInstance = PergaminhoBanhado.findById(Integer.parseInt(params.pergaminhoBanhadoID))
        pergaminhoBanhadoInstance.information[0] = params.information1
        pergaminhoBanhadoInstance.information[1] = params.information2
        pergaminhoBanhadoInstance.information[2] = params.information3
        pergaminhoBanhadoInstance.information[3] = params.information4
        pergaminhoBanhadoInstance.ownerId = session.user.id as long
        pergaminhoBanhadoInstance.taskId = session.taskId as String
        pergaminhoBanhadoInstance.save flush:true
        redirect(action: "index")
    }

    @Transactional
    def delete(PergaminhoBanhado pergaminhoBanhadoInstance) {

        if (pergaminhoBanhadoInstance == null) {
            notFound()
            return
        }

        pergaminhoBanhadoInstance.delete flush:true
        render "delete OK"

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PergaminhoBanhado.label', default: 'PergaminhoBanhado'), pergaminhoBanhadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pergaminhoBanhado.label', default: 'PergaminhoBanhado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(PergaminhoBanhado pergaminhoBanhadoInstance){
        if (pergaminhoBanhadoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render pergaminhoBanhadoInstance.information[0] + "%@!" +
                    pergaminhoBanhadoInstance.information[1] + "%@!" +
                    pergaminhoBanhadoInstance.information[2] + "%@!" +
                    pergaminhoBanhadoInstance.information[3] + "%@!" +
                    pergaminhoBanhadoInstance.id
        }

    }

    @Secured(['permitAll'])
    def exportInformations(){

        //cria o txt do pergaminho da fase do Banhado
        //popula a lista de questoes a partir do ID de cada uma
        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoBanhado> informationList = new ArrayList<PergaminhoBanhado>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoBanhado.findById(list_informationId[i]))

        //cria o txt do pergaminho da fase do Banhado
        createTxtPergaminho("pergaminhoBanhado.txt", informationList)

        // Finds the created file path
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        String id = MongoHelper.putFile("${folder}/pergaminhoBanhado.txt")

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"

    }

    void createTxtPergaminho(String fileName, ArrayList<PergaminhoBanhado> informationList){
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
                PergaminhoBanhado pergaminhoBanhadoInstance = PergaminhoBanhado.findById(1)
                pergaminhoBanhadoInstance.information[0] = row[0] ?: "NA"
                pergaminhoBanhadoInstance.information[1] = row[1] ?: "NA"
                pergaminhoBanhadoInstance.information[2] = row[2] ?: "NA"
                pergaminhoBanhadoInstance.information[3] = row[3] ?: "NA"
                pergaminhoBanhadoInstance.taskId = session.taskId as String
                pergaminhoBanhadoInstance.ownerId = session.user.id as long
                pergaminhoBanhadoInstance.save flush: true
                println(pergaminhoBanhadoInstance.errors)
            } else {
                error = true
            }
        }

        redirect(action: index(), params: [errorImportInformations:error])
    }

    def exportCSV(){
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Informacao1, Informacao2, Informacao3, Informacao4.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_informationId = new ArrayList<Integer>()
        ArrayList<PergaminhoBanhado> informationList = new ArrayList<PergaminhoBanhado>()
        list_informationId.addAll(params.list_id)
        for (int i=0; i<list_informationId.size();i++)
            informationList.add(PergaminhoBanhado.findById(list_informationId[i]))

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportInformationsBanhado.csv"), "UTF-8"))

        fw.write(informationList[0].information[0] + ";" + informationList[0].information[1] + ";" + informationList[0].information[2] + ";" + informationList[0].information[3] + "\n")
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/sanjarunner/samples/export/exportInformationsBanhado.csv"
    }
}
