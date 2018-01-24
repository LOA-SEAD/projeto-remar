package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.propeller.domain.ProcessDefinition
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap
import org.mongodb.morphia.Datastore
import grails.converters.JSON
import grails.util.Environment
import groovyx.net.http.HTTPBuilder
import org.apache.commons.lang.RandomStringUtils
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartFile

import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.security.MessageDigest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class ResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def springSecurityService
    def beforeInterceptor = [action: this.&check, only: ['index']]

    static final int THRESHOLD = 6

    private check() {
        if (!session.user) {
            log.debug "Logout: session.user is NULL !"
            redirect controller: "logout", action: "index"
            return false
        }
    }

    def index(Integer max) {
        if (request.isUserInRole("ROLE_ADMIN")) {
            render view: 'index', model: [resourceInstanceList: Resource.list(), resourceInstanceCount: Resource.count()]
        } else {
            render view: 'index', model: [resourceInstanceList: Resource.findAllByOwner(springSecurityService.currentUser as User), resourceInstanceCount: Resource.count()]
        }
    }


    def create() {
        render view: "create", model: [id: params.id, categories: Category.list(sort: "name"), defaultCategory: Category.findByName('Clássicos')]
    }

    @Transactional
    update(Resource instance) {
        def path = new File(servletContext.getRealPath("/data/resources/assets/${instance.uri}"))
        path.mkdirs()

        if (params.shareable == "yes")
            instance.shareable = true;

        if (params.img1 != null && params.img1 != "") {
            log.debug("entrou img1" + params.img1)
            def img1 = new File(servletContext.getRealPath("${params.img1}"))
            img1.renameTo(new File(path, "description-1"))
        }

        if (params.img2 != null && params.img2 != "") {
            def img2 = new File(servletContext.getRealPath("${params.img2}"))
            img2.renameTo(new File(path, "description-2"))
        }

        if (params.img3 != null && params.img3 != "") {
            def img3 = new File(servletContext.getRealPath("${params.img3}"))
            img3.renameTo(new File(path, "description-3"))
        }
        instance.comment = "Em avaliação"

        instance.save flush: true
        render true;
    }

    @Transactional
    save(Resource resourceInstance) { // saves and verifies WAR file
        String username = session.user.username
        MultipartFile submitedWar = params.war
        String fileName = MessageDigest.getInstance("MD5").digest(submitedWar.bytes).encodeHex().toString()
        File savedWar = new File(servletContext.getRealPath("/wars/${username}"), fileName + ".war")
        String expandedWarPath = savedWar.parent + "/" + fileName
        File tmp
        AntBuilder ant = new AntBuilder()

        resourceInstance.submittedAt = new Date()
        resourceInstance.owner = springSecurityService.currentUser as User
        resourceInstance.status = "pending"
        resourceInstance.valid = true
        resourceInstance.license = params.license
        resourceInstance.customizableItems = ""

        // Move .war to /wars and unzip it
        savedWar.mkdirs()
        submitedWar.transferTo(savedWar)
        ant.mkdir(dir: expandedWarPath)
        ant.unzip(src: savedWar.path, dest: expandedWarPath, overwrite: true)
        println "done"
        println expandedWarPath
        tmp = new File(expandedWarPath + "/WEB-INF")
        println tmp
        if (!tmp.exists()) { // file is not a WAR
            resourceInstance.name = submitedWar.originalFilename
            this.rejectWar(resourceInstance, "File is not a WAR")
            redirect action: "index"
            return
        }

        tmp = new File("${expandedWarPath}/remar/process.json")
        if (!tmp.exists()) { // process.json not found
            this.rejectWar(resourceInstance, 'process.json not found')
            redirect action: "index"
            return
        } else {
            def json = JSON.parse(tmp.getText('UTF-8'))

            resourceInstance.name = json.name
            resourceInstance.uri = json.uri
            resourceInstance.android = 'android' in json.outputs
            resourceInstance.desktop = 'desktop' in json.outputs
            resourceInstance.moodle = 'moodle' in json.outputs
            resourceInstance.web = 'web' in json.outputs
            resourceInstance.type = json.type ? json.type.toLowerCase() : "html"
            resourceInstance.width = json.vars.width
            resourceInstance.height = json.vars.height

            ant.mkdir(dir: servletContext.getRealPath("/propeller"))
            ant.copy(file: tmp, todir: servletContext.getRealPath("/propeller/${resourceInstance.uri}"))
        }

        // read the file that describes the game DB and creates a collection with the corresponding name
        def bd = new File(expandedWarPath + "/remar/bd.json")

        if (!bd.exists()) {
            this.rejectWar(resourceInstance, 'bd.json not found')
            redirect action: "index"
            return
        }

        ant.copy(file: expandedWarPath + "/remar/bd.json",
                tofile: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}/bd.json"))

        def json = JSON.parse(bd.text)
        def collectionName = json['collection_name'] as String
        MongoHelper.instance.createCollection(collectionName)

        tmp = new File("${expandedWarPath}/remar/images/${resourceInstance.uri}-banner.png")
        if (!tmp.exists()) { // {uri}-banner.png not found
            this.rejectWar(resourceInstance, 'banner not found')
            redirect action: "index"
            return
        } else {
            ant.copy(file: tmp, todir: servletContext.getRealPath("/images"))
        }

        tmp = new File("${expandedWarPath}/remar/source")
        if (!tmp.exists()) { // source folder exists?
            this.rejectWar(resourceInstance, "game's source folder not found")
            redirect action: "index"
            return
        } else {
            ant.copy(todir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}/base")) {
                fileset(dir: tmp)
            }
        }

        resourceInstance.comment = "Esperando Formulário"

        // rename war to a human readable name – instead of a MD5 name
        savedWar.renameTo(servletContext.getRealPath("/wars/${username}") + "/${resourceInstance.uri}.war")

        resourceInstance.category = Category.findByName("Clássicos")

        // set ratings variables
        resourceInstance.sumUser = 0
        resourceInstance.sumStars = 0
        resourceInstance.shareable = false
        resourceInstance.repository = true

        resourceInstance.save flush: true

        if (resourceInstance.hasErrors()) {
            log.error "War submited by " + session.user.username + " rejected by Grails. Reason:"
            log.error resourceInstance.errors

            respond resourceInstance.errors, view: "create"
        } else {
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), resourceInstance.id])
            render resourceInstance as JSON
        }

    }

    def newDeveloper() {}

    @SuppressWarnings("GroovyUnreachableStatement")
    review() {
        def resourceInstance = Resource.findById(params.id)
        String status = params.status
        String comment = params.comment

        if (!status) {
            resourceInstance.comment = comment
            if (resourceInstance.status == "rejected") {
                Util.sendEmail(resourceInstance.owner.email,
                        "REMAR – O seu WAR \"${resourceInstance.name}\" foi rejeitado!",
                        "<h3>O seu WAR \"${resourceInstance.name}\" foi rejeitado pois ${comment}</h3> <br> "
                )
            }
            response.status = 204
            render 204
        }

        if (status == "approve" && resourceInstance.status != "approved") {
            def ant = new AntBuilder()
            def rootPath = servletContext.getRealPath('/')
            def scriptElectron = "${rootPath}/scripts/electron/build.sh"
            def scriptUnity = "${rootPath}/scripts/unity/decompress.sh"
            def scriptCreateDatabase = "${rootPath}/scripts/create_game_database.sh"

            log.debug "Running Script for Creating DataBase ${resourceInstance.uri}."
            ant.sequential {
                chmod(perm: "+x", file: scriptCreateDatabase)
                exec(executable: scriptCreateDatabase) {
                    arg(value: resourceInstance.uri)
                }
            }

            // Pré-processamento do código-fonte do jogo dependente do tipo
            if (resourceInstance.desktop && resourceInstance.comment != "test") {
                switch (resourceInstance.type) {
                    case "html":
                        log.debug "Running Electron Script for HTML desktop resource."
                        ant.sequential {
                            chmod(perm: "+x", file: scriptElectron)
                            exec(executable: scriptElectron) {
                                arg(value: rootPath)
                                arg(value: resourceInstance.uri)
                                arg(value: resourceInstance.name.replaceAll("\\s+", ""))
                            }
                        }
                        break
                    case "unity":
                        log.debug "Running Decompression Script for Unity desktop resource."
                        ant.sequential {
                            chmod(perm: "+x", file: scriptUnity)
                            exec(executable: scriptUnity) {
                                arg(value: rootPath)
                                arg(value: resourceInstance.uri)
                            }
                        }
                        break
                    default:
                        log.debug "No additional source code pre-processing needed for resource of type [" + resourceInstance.type + "]."
                        break
                }
            } else if (!resourceInstance.desktop) {
                log.debug "No additional source code pre-processing needed. Resource is not for desktop."
            }

            if (Environment.current == Environment.DEVELOPMENT) {
                resourceInstance.status = "approved"
                resourceInstance.active = true
                resourceInstance.version = 0
                resourceInstance.comment = "Aprovado"
                resourceInstance.save flush: true

                redirect controller: "process", action: "deploy", id: resourceInstance.uri
                return
            }

            def http = new HTTPBuilder("http://root:root@localhost:8080")
            def resp = http.get(path: '/manager/text/deploy',
                    query: [path: "/${resourceInstance.uri}",
                            war : servletContext.getRealPath("/wars/${resourceInstance.owner.username}/${resourceInstance.uri}.war")])
            resp = GrailsIOUtils.toString(resp)
            if (resp.indexOf('OK') != -1) {
                resourceInstance.status = "approved"
                resourceInstance.active = true
                resourceInstance.version = 0
                resourceInstance.comment = "Aprovado"
                resourceInstance.save flush: true

                if (resourceInstance.owner.username != 'admin') {

                    // noinspection GroovyAssignabilityCheck
                    Util.sendEmail(resourceInstance.owner.email,
                            "REMAR – O seu WAR \"${resourceInstance.name}\" foi aprovado!",
                            "<h3>O seu WAR \"${resourceInstance.name}\" foi aprovado! :)</h3> <br>"
                    )
                }

                redirect controller: "process", action: "deploy", id: resourceInstance.uri
            } else {
                response.status = 500
                render resp
            }

            // probably we don't need this anymore because when the WAR is deployed the bpmn is deployed too
            // redirect controller: "process", action: "deploy", id: resourceInstance.bpmn
        } else if (status == "reject" && resourceInstance.status != "rejected") {
            resourceInstance.status = "rejected"
            resourceInstance.comment = "Rejeitado"


            render "success"
        }
        resourceInstance.save flush: true
    }

    @Transactional
    delete(Resource resourceInstance) {
        if (resourceInstance == null) {
            log.debug "Trying to delete a resource, but that was not found."
            response.status = 404
            render "Not found"
            return
        }

        if (resourceInstance.owner == session.user || session.user.username == 'admin') {

            try {
                // Verifica se não há jogos "em customização" do modelo
                def processes = Propeller.instance.getProcessInstancesByOwner(session.user.id as long)

                for (process in processes) {
                    if (process.definition.uri == resourceInstance.uri &&
                            process.getVariable("inactive") != "1" &&
                            process.getVariable("exportedResourceId") == null) {
                        // Se houver algum jogo em customização, lança uma exceção
                        throw new Exception("pendingProcessError")
                    }
                }

                resourceInstance.delete flush: true

                new AntBuilder().sequential {
                    delete(dir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}"))
                    delete(dir: servletContext.getRealPath("/propeller/${resourceInstance.uri}"))
                }

                // Só realiza o undeploy se o deploy foi dado de fato (quando é aprovado)
                Datastore ds = Propeller.instance.getDs()
                if (ds.createQuery(ProcessDefinition.class).field('uri').equal(resourceInstance.uri).get()) {
                    Propeller.instance.undeploy(resourceInstance.uri)

                    def http = new HTTPBuilder("http://root:root@localhost:8080")
                    def resp = http.get(path: '/manager/text/undeploy', query: [path: "/${resourceInstance.uri}"])
                    resp = GrailsIOUtils.toString(resp)
                    if (resp.indexOf('OK') != -1) log.debug "Resource successfully undeployed"
                    else log.debug "ERROR: Failed trying to undeploy resource"
                } else log.debug "WARNING: Skipped undeploy"

                if (grailsApplication.config.dspace.restUrl) { //se existir dspace
                    MongoHelper.instance.removeDataFromUri('resource_dspace', resourceInstance.uri)
                }

                response.status = 205
                render 205
            } catch (Exception e) {
                if (e.message == "pendingProcessError")
                    render "pendingProcessError"
                else
                    render "sqlError"
            }
        } else {
            log.debug "WARNING: Someone is trying to delete a resource that belongs to other user"
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'deploy.label', default: 'Deploy'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def show(Resource instance) {
        render view: "show", model: [resourceInstance: instance, today: new Date()]
    }

    def showURI() {
        def instance = Resource.findByUri(params.uri)
        render view: "show", model: [resourceInstance: instance, today: new Date()]
    }

    def customizableGames() {
        def model = [:]

        params.order = "asc"
        params.sort = "name"
        params.max = params.max ? Integer.valueOf(params.max) : THRESHOLD
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        params.text = params.text ? params.text : ''
        params.category = params.category ? Integer.valueOf(params.category) : -1
        params.mode = params.mode ? params.mode : 'firstAccess'

        log.debug("params = " + params)

        def query

        if (params.category != -1) {
            log.debug("searchByCategoria");
            Category c = Category.findById(Integer.valueOf(params.category))

            query = Resource.where {
                (status == 'approved' && category == c && name =~ "%" + params.text + "%")
            }
        } else {
            log.debug("searchAll");
            query = Resource.where {
                (status == 'approved' && name =~ "%" + params.text + "%")
            }
        }

        model.resourceInstanceList = query.list(params)

        log.debug("resourceList = " + model.resourceInstanceList)

        int maxInstances =  query.count()

        log.debug("maxInstances = " + maxInstances)

        model.max = params.max
        model.threshold = THRESHOLD
        model.pageCount = Math.ceil(maxInstances / params.max) as int
        model.currentPage = (params.offset + THRESHOLD) / THRESHOLD
        model.hasNextPage = params.offset + THRESHOLD < model.resourceInstanceList.size()
        model.hasPreviousPage = params.offset > 0

        model.categories = Category.list(sort: "name")

        if (params.mode == 'firstAccess') {
            render view: "customizableGames", model: model
        } else {
            render view: "_gameModelCard", model: model
        }
    }

    def edit(Resource resourceInstance) {
        def resourceJson = resourceInstance as JSON

        render view: 'edit', model: [resourceInstance: resourceInstance, categories: Category.list(sort: "name"),
                                     defaultCategory : resourceInstance.category]
    }

    def getResourceInstance(long id) {

        def r = Resource.findById(id) as JSON

        render r;
    }

    @Transactional
    saveRating(Resource instance) {
        Rating r = new Rating(user: session.user, stars: params.stars * 0.5, comment: params.commentRating, date: new Date())
        instance.addToRatings(r)
        instance.sumStars += r.stars * 0.5
        instance.sumUser++

        instance.save flush: true

        render view: "_comment", model: [rating  : r, mediumStars: (instance.sumStars / instance.sumUser),
                                         sumUsers: instance.sumUser, today: new Date()]
    }

    @Transactional
    asyncSaveRating() {
        def user = User.findById(params.userid)
        def resource = Resource.findById(params.resourceid)
        def rating = new Rating()

        rating.user = user
        rating.resource = resource
        rating.stars = Float.parseFloat(params.rating)
        rating.comment = '' /* TODO */
        rating.date = new Date()
        rating.save flush: true

        resource.sumStars += Float.parseFloat(params.rating)
        resource.sumUser++

        render status: 200, text: 'save'
    }


    @Transactional
    updateRating(Rating rating) {

        def old_stars = rating.getPersistentValue("stars")

        // atualiza a data do rating
        rating.date = new Date()

        // retira da soma de estrelas a quantidade de estrelas anterior do rating
        rating.resource.sumStars -= old_stars

        // soma a nova quantidade de estrelas a soma de estrelas do rating
        rating.resource.sumStars += rating.stars * 0.5

        rating.save flush: true

        render view: "_comment", model: [rating  : rating, mediumStars: (rating.resource.sumStars / rating.resource.sumUser),
                                         sumUsers: rating.resource.sumUser, today: new Date()]

    }

    @Transactional
    asyncUpdateRating() {
        def user = User.findById(params.userid)
        def resource = Resource.findById(params.resourceid)
        def rating = Rating.findByUserAndResource(user, resource)

        resource.sumStars += (Float.parseFloat(params.rating) - rating.stars)
        rating.stars = Float.parseFloat(params.rating)

        render status: 200, text: 'update'
    }


    @Transactional
    deleteRating() {

        int id = Integer.parseInt(params.id)
        Rating rating = Rating.findById(id)

        if (rating != null) {
            Resource resource = rating.resource

            // retira da soma de estrelas a quantidade de estrelas anterior do rating
            resource.sumStars -= rating.stars
            rating.delete flush: true;
            resource.sumUser = resource.ratings.size()
            resource.save flush: true

            render resource as JSON
        } else
            render "null"

    }

    def croppicture() {
        def root = servletContext.getRealPath("/")
        def f = new File("${root}data/tmp")
        f.mkdirs()
        def destination = new File(f, RandomStringUtils.random(50, true, true))
        def photo = params.photo as CommonsMultipartFile
        photo.transferTo(destination)

        def x = Math.round(params.float('x'))
        def y = Math.round(params.float('y'))
        def w = Math.round(params.float('w'))
        def h = Math.round(params.float('h'))
        BufferedImage img = ImageIO.read(destination)
        ImageIO.write(img.getSubimage(x, y, w, h),
                photo.contentType.contains('png') ? 'png' : 'jpg', destination)
        println destination.name
        render destination.name
    }

    def rejectWar(Resource instance, String reason) {
        instance.valid = false
        instance.uri = ""
        instance.status = "rejected"
        instance.comment = reason
        instance.save flush: true
        log.debug "War submited by " + session.user.username + " rejected. Reason: " + reason
    }

    def findResource() {
        render Resource.findByName(params.name)
    }

    @Transactional
    importData() {
        CommonsMultipartFile file = request.getFile("spreadsheet-file")
        def dataFill = []

        if (!file.empty) {
            switch (file.contentType) {
                case "application/vnd.ms-excel":
                case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                    ExcelUtil converter = new ExcelUtil()
                    converter.getObjectsFromExcelFile(file).each {
                        dataFill.add(it)
                    }
                    break
                case "text/csv":
                    Util.readCSV(file, ';', 'UTF-8').each {
                        dataFill.add(it)
                    }
                    break
                default:
                    flash.message = g.message("Erro de importação de conteúdo")
                    //flash.message = g.message(code: "admin.users.import.error.contentType")
                    break
            }
        } else {
            flash.message = g.message("Arquivo vazio")
            //flash.message = g.message(code: "default.errors.fileEmpty")
        }

        render dataFill as JSON
    }


}
