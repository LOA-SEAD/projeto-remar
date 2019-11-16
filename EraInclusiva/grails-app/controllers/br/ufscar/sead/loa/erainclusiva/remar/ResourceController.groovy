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

    static List<Resource> resources

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
                                      userName            : session.user.username, userId: session.user.id]

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
        newQuest.name = resourceInstance.name
        newQuest.source = resourceInstance.source
        newQuest.author = resourceInstance.author
        newQuest.category = resourceInstance.category
        newQuest.taskId = session.taskId as String
        newQuest.ownerId = session.user.id

        newQuest.save flush: true

        if (newQuest.hasErrors()) {
            println newQuest.errors
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

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

        resourceInstance.taskId = session.taskId as String

        resourceInstance.save flush: true

        if (resourceInstance.hasErrors()) {
            println resourceInstance.errors
            respond resourceInstance.errors, view: 'create' //TODO
            render resourceInstance.errors;
            return
        }

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

        resourceInstance.name = params.name
        resourceInstance.source = params.source
        resourceInstance.category = params.category
        resourceInstance.save flush: true

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

        if (resources == null) {
            File csvDir = new File(servletContext.getRealPath("csv"))

            BufferedReader
            if (csvDir.exists()) {

                resources = new ArrayList<Resource>()

                File csvFile = new File(servletContext.getRealPath("csv/resources.csv"))

                BufferedReader reader = new BufferedReader(new InputStreamReader(
                        new FileInputStream(csvFile), "UTF-8"))

                reader.splitEachLine(";") { fields ->

                    def resource = new Resource(
                            name: fields[0],
                            source: fields[1],
                            category: fields[2]
                    )

                    resources.add(resource)
                }
            }
        }

        List<Resource> list = Resource.getAll(params.id ? params.id.split(',').toList() : null)

        resources.addAll(list)

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < resources.size(); i++) {
            Resource r = resources.get(i)
            sb.append("{\n");
            sb.append("\"name\": \"" + r.getName() + "\",\n")
            sb.append("\"src\": \"" + r.getSource() + "\",\n")
            sb.append("\"type\": \"url\",\n")
            sb.append("\"category\": \"" + r.getCategory() + "\"\n")
            if (i != resources.size() - 1) {
                sb.append("},\n")
            } else {
                sb.append("}\n")
            }
        }

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()

        def fileName = "recursos_biblioteca.json"
        File file = new File("$userPath/$fileName");

        def bw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))

        bw.write('{\n\"Recursos\" : [\n' + sb.toString() + '] \n}');
        bw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Resource resourceInstance) {

        if (resourceInstance == null) {
            notFound()
        } else {
            render resourceInstance.name + "%@!" +
                    resourceInstance.source + "%@!" +
                    resourceInstance.author + "%@!" +
                    resourceInstance.category + "%@!" +
                    resourceInstance.version + "%@!" +
                    resourceInstance.ownerId + "%@!" +
                    resourceInstance.taskId + "%@!" +
                    resourceInstance.id
        }
    }
}
