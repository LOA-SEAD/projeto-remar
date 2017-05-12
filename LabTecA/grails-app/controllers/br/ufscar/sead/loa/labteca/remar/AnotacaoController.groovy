package br.ufscar.sead.loa.labteca.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class AnotacaoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportAnotacoes','save', 'update', 'delete']]

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

       def list = Anotacao.findAllByOwnerId(session.user.id)
        println list
        respond list, model: [AnotacaoInstanceCount: Anotacao.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(Anotacao anotacaoInstance) {
        respond anotacaoInstance
    }

    def create() {
        respond new Anotacao(params)
    }


   /* @Transactional
    def newAnotacao(Anotacao anotacaoInstance) {

        Anotacao newQuest = new Anotacao();
        newAnotacao.id = anotacaoInstance.id
        newAnotacao.statement = anotacaoInstance.statement
        newAnotacao.taskId    = session.taskId as String
        newAnotacao.ownerId = session.user.id

        if (newAnotacao.hasErrors()) {
            respond newAnotacao.errors, view: 'create' //TODO
            render newAnotacao.errors;
            return
        }

        newAnotacao.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newAnotacao.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())


    }
*/

    @Transactional
    def save(Anotacao anotacaoInstance) {
        if (anotacaoInstance == null) {
            notFound()
            return
        }

        if (anotacaoInstance.hasErrors()) {
            respond anotacaoInstance.errors, view:'create'
            render anotacaoInstance.errors;
            return
        }
      //anotacaoInstance.informacao[0]= params.informacao
        anotacaoInstance.ownerId = session.user.id as long
      // anotacaoInstance.taskId = session.taskId as String
        anotacaoInstance.save flush:true

        redirect(action: "index")
    }

    def edit(Anotacao anotacaoInstance) {
        respond anotacaoInstance
    }

    @Transactional
    def update() {
        Anotacao anotacaoInstance = Anotacao.findById(Integer.parseInt(params.AnotacaoID))
        anotacaoInstance.informacao= params.anotacao
       // anotacaoInstance.informacao = Integer.parseInt(params.title)

        anotacaoInstance.ownerId = session.user.id as long
        //anotacaoInstance.taskId = session.taskId as String
        anotacaoInstance.save flush:true

        redirect action: "index"
    }


    @Transactional
    def delete(Anotacao anotacaoInstance) {
        if (anotacaoInstance == null) {
            notFound()
            return
        }

        anotacaoInstance.delete flush: true
        redirect action: "index"
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'anotacao.label', default: 'Anotacao'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }



    @Secured(['permitAll'])
    def returnInstance(Anotacao anotacaoInstance){
        if (anotacaoInstance == null) {
            notFound()
            render "null"
        }
        else{
            render anotacaoInstance.informacao + "%@!" + anotacaoInstance.id
        }

    }



@Transactional
def exportAnotacoes(){
    //popula a lista de questoes a partir do ID de cada uma
    ArrayList<Integer> list_anotacaoId = new ArrayList<Integer>() ;
    ArrayList<Anotacao> anotacaoList = new ArrayList<Anotacao>();
    list_anotacaoId.addAll(params.list_id);
    for (int i=0; i<list_anotacaoId.size();i++)
        anotacaoList.add(Anotacao.findById(list_anotacaoId[i]));

    //cria o arquivo json
    createJsonFile("anotacoes.json", anotacaoList)

    // Finds the created file path
    def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
    String id = MongoHelper.putFile("${folder}/anotacoes.json")


    def port = request.serverPort
    if (Environment.current == Environment.DEVELOPMENT) {
        port = 8080
    }

    // Updates current task to 'completed' status
    render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
}

void createJsonFile(String fileName, ArrayList<Anotacao> anotacaoList) {
    def dataPath = servletContext.getRealPath("/data")
    def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
    instancePath.mkdirs()

    File file = new File("$instancePath/" + fileName);
    def bw = new BufferedWriter(new OutputStreamWriter(
            new FileOutputStream(file), "UTF-8"));
    
    bw.write("{\n")
    bw.write("\t\"quantidadeAnotacoes\": [\"" + anotacaoList.size() + "\"],\n")
    for (def i = 0; i < anotacaoList.size(); i++) {
        bw.write("\t\"" + (i + 1) + "\": [\"" + anotacaoList[i].informacao + "\"] ")

        if (i < anotacaoList.size() - 1)
            bw.write(",")
        bw.write("\n")
    }
    bw.write("}");
    bw.close();

    //se o arquivo fases.json nao existe, cria ele com nenhuma fase opcional
    def anotacoesFolder = new File("${dataPath}/${springSecurityService.currentUser.id}/processes/${session.processId}")
    anotacoesFolder.mkdirs()
    File anotacoesJson = new File("$anotacoesFolder/anotacoes.json")
    boolean exists = anotacoesJson.exists()
    if (!exists) {
        PrintWriter printer = new PrintWriter(anotacoesJson);
        printer.write("{\n");
        printer.write("\t\"quantidade\": [\"0\"],\n")
        printer.write("\t\"anotacoes\": [\"1\", \"2\"]\n")
        printer.write("}")
        printer.close();
    }
}
}