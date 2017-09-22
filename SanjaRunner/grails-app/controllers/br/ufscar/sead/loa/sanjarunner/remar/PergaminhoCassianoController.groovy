package br.ufscar.sead.loa.sanjarunner.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment

@Secured(["isAuthenticated()"])
class PergaminhoCassianoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", exportInformations: "POST", returnInstance: "GET"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportInformations','save', 'update', 'delete']]

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
        respond list, model: [pergaminhoCassianoInstanceCount: PergaminhoCassiano.count(), errorImportQuestions:params.errorImportQuestions]
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
}
