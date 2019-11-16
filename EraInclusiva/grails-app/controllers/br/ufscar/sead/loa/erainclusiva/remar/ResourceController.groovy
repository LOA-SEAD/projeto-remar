package br.ufscar.sead.loa.erainclusiva.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class ResourceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def beforeInterceptor = [action: this.&check, only: ['index']]

    def springSecurityService

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

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }

        def list = Resource.findAllByAuthor(session.user.username)

        render view: "index", model: [resourceInstanceList: list, resourceInstanceCount: list.size(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def create() {
        respond new Resource(params)
    }

    @Transactional
    def newResource(Resource resourceInstance) {
        if (resourceInstance.author == null) {
            resourceInstance.author = session.user.username
        }

        Resource newQuest = new Resource();
        newQuest.id = resourceInstance.id
        newQuest.statement = resourceInstance.statement
        newQuest.answer = resourceInstance.answer
        newQuest.author = resourceInstance.author
        newQuest.category = resourceInstance.category
        newQuest.taskId    = session.taskId as String
        newQuest.ownerId = session.user.id

        if (newQuest.hasErrors()) {
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

        newQuest.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newQuest.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())


    }

    @Transactional
    def save(Resource resourceInstance) {
        if (resourceInstance == null) {
            notFound()
            return
        }




        if (resourceInstance.hasErrors()) {
            respond resourceInstance.errors, view: 'create' //TODO
            render resourceInstance.errors;
            return
        }

        resourceInstance.taskId = session.taskId as String

        resourceInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + resourceInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())
    }

    def edit(Resource resourceInstance) {
        respond resourceInstance
    }

    @Transactional
    def update() {

        Resource resourceInstance = Resource.findById(Integer.parseInt(params.resourceID))

        resourceInstance.statement = params.statement
        resourceInstance.answer = params.answer
        resourceInstance.category = params.category
        resourceInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(Resource resourceInstance) {
        if (resourceInstance == null) {
            notFound()
            return
        }

        resourceInstance.delete flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + resourceInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def toJson() {
        def list = Resource.getAll(params.id ? params.id.split(',').toList() : null)
        def builder = new JsonBuilder()
        def json = builder(
                list.collect { p ->
                    ["palavra"     : p.getAnswer().toUpperCase(),
                     "dica"        : p.getStatement(),
                     "contribuicao": p.getAuthor()]
                }
        )

        log.debug builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()

        def fileName = "recursos_biblioteca.json"
        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write('{ "nome" : "A Era Inclusiva","materiais":' + builder.toString() + '}');
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Resource resourceInstance){

        if (resourceInstance == null) {
            notFound()
        }
        else{
            render resourceInstance.statement + "%@!" +
                    resourceInstance.answer + "%@!" +
                    resourceInstance.author + "%@!" +
                    resourceInstance.category + "%@!" +
                    resourceInstance.version + "%@!" +
                    resourceInstance.ownerId + "%@!" +
                    resourceInstance.taskId + "%@!" +
                    resourceInstance.id
        }
    }

    @Transactional
    def generateResources() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username

        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->

            Resource resourceInstance = new Resource()

            try{
                String correct = row[6] ?: "NA";
                int correctAnswer = (correct.toInteger() -1)
                resourceInstance.statement = row[1] ?: "NA";
                resourceInstance.answer = row[(2 + correctAnswer)] ?: "NA";
                resourceInstance.category = row[8] ?: "NA";
            }
            catch (ArrayIndexOutOfBoundsException exception){
                //println("Not default .csv - Model: Title-Answer-Category")
                resourceInstance.statement = row[0] ?: "NA";
                resourceInstance.answer = row[1] ?: "NA";
                resourceInstance.category = row[2] ?: "NA";
            }

            resourceInstance.author = username
            resourceInstance.taskId = session.taskId as String
            resourceInstance.ownerId = session.user.id

            if (resourceInstance.hasErrors()) {

            }
            else{
                resourceInstance.save flush: true
            }

        }

        redirect(action: index())

    }
}
