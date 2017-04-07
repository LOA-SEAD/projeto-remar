package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.propeller.domain.ProcessDefinition
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
    def update(Resource instance) {
        def path = new File(servletContext.getRealPath("/data/resources/assets/${instance.uri}"))
        path.mkdirs()

        if(params.shareable == "yes")
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
    def save(Resource resourceInstance) { // saves and verifies WAR file
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
    def review() {
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
            def scriptCrosswalk = "${rootPath}/scripts/crosswalk/build.sh"

            if (resourceInstance.desktop && resourceInstance.comment != "test") {
                ant.sequential {
                    chmod(perm: "+x", file: scriptElectron)
                    exec(executable: scriptElectron) {
                        arg(value: rootPath)
                        arg(value: resourceInstance.uri)
                        arg(value: resourceInstance.name.replaceAll("\\s+",""))
                    }
                }
            }

            if (resourceInstance.android && resourceInstance.comment != "test") {
                ant.sequential {
                    chmod(perm: "+x", file: scriptCrosswalk)
                    exec(executable: scriptCrosswalk) {
                        arg(value: rootPath)
                        arg(value: resourceInstance.uri)
                        arg(value: resourceInstance.name)
                    }
                }
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

            def http = new HTTPBuilder("http://root:${grailsApplication.config.users.password}@localhost:8080")
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
    def delete(Resource resourceInstance) {
        if (resourceInstance == null) {
            log.debug "Trying to delete a resource, but that was not found."
            response.status = 404
            render "Not found"
            return
        }

        if (resourceInstance.owner == session.user || session.user.username == 'admin') {

           try{
               resourceInstance.delete flush: true

               new AntBuilder().sequential {
                   delete(dir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}"))
                   delete(dir: servletContext.getRealPath("/propeller/${resourceInstance.uri}"))
               }

               // Só realiza o undeploy se o deploy foi dado de fato (quando é aprovado)
               Datastore ds = Propeller.instance.getDs()
               if (ds.createQuery(ProcessDefinition.class).field('uri').equal(resourceInstance.uri).get()) {
                   Propeller.instance.undeploy(resourceInstance.uri)

                   def http = new HTTPBuilder("http://root:${grailsApplication.config.users.password}@localhost:8080")
                   def resp = http.get(path: '/manager/text/undeploy', query: [path: "/${resourceInstance.uri}"])
                   resp = GrailsIOUtils.toString(resp)
                   if (resp.indexOf('OK') != -1) log.debug "Resource successfully undeployed"
                   else log.debug "Failed trying to undeploy resource"
               }
               else log.debug "Skipped undeploy"

               if(grailsApplication.config.dspace.restUrl) { //se existir dspace
                   MongoHelper.instance.removeDataFromUri('resource_dspace',resourceInstance.uri)
               }

               response.status = 205
               render 205
           }catch (Exception e) {
                    render "sqlError"
           }
        } else {
            log.debug "Someone is trying to delete a resource that belongs to other user"
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

    def customizableGames() {
        def model = [:]
        def threshold = 12

        params.order = "desc"
        params.sort = "id"

        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold

        model.resourceInstanceList = Resource.findAllByStatus('approved',params) // change to #findAllByActive?

        model.pageCount = Math.ceil(model.resourceInstanceList.size() / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        model.categories = Category.list(sort:"name")

        log.debug(model.resourceInstanceList.size())

        render view: "customizableGames", model: model
    }

    @SuppressWarnings("GroovyAssignabilityCheck")
    def searchResource(){
        def model = [:]

        def threshold = 12
        def maxInstances = 0

        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : threshold
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0

        model.max = params.max
        model.threshold = threshold

        log.debug("type: " + params.typeSearch)
        log.debug("text: " +params.text)

        model.resourceInstanceList = null

        if(params.category.equals("-1")){ // busca pelo nome
            model.resourceInstanceList = Resource.findAllByStatusAndNameIlike('approved', "%${params.text}%",params)
            maxInstances = Resource.findAllByStatusAndNameIlike('approved', "%${params.text}%").size()
        }
        else{
            Category c = Category.findById(params.category)
            model.resourceInstanceList = Resource.findAllByCategoryAndNameIlike(c, "%${params.text}%" ,params)
            maxInstances = model.resourceInstanceList.size()
        }

        model.pageCount = Math.ceil(maxInstances / params.max) as int
        model.currentPage = (params.offset + threshold) / threshold
        model.hasNextPage = params.offset + threshold < model.instanceCount
        model.hasPreviousPage = params.offset > 0

        log.debug(model.resourceInstanceList.size())

        render view: "_custCards", model: model
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

    def saveRating(Resource instance) {
        log.debug(params)

        Rating r = new Rating(user: session.user, stars: params.stars, comment: params.commentRating, date: new Date())
        instance.addToRatings(r)
        instance.sumStars += r.stars;
        instance.sumUser++

        instance.save flush: true

        render view: "_comment", model: [rating  : r, mediumStars: (instance.sumStars / instance.sumUser),
                                         sumUsers: instance.sumUser, today: new Date()]
    }

    def updateRating(Rating rating) {

        def old_stars = rating.getPersistentValue("stars")

        print(rating.getPersistentValue("comment"))
        print(old_stars)
        print(rating)
        print(params)

        // atualiza a data do rating
        rating.date = new Date()

        // retira da soma de estrelas a quantidade de estrelas anterior do rating
        rating.resource.sumStars -= old_stars

        // soma a nova quantidade de estrelas a soma de estrelas do rating
        rating.resource.sumStars += rating.stars

        rating.save flush: true

        render view: "_comment", model: [rating  : rating, mediumStars: (rating.resource.sumStars / rating.resource.sumUser),
                                         sumUsers: rating.resource.sumUser, today: new Date()]

    }

    @Transactional
    def deleteRating() {

        int id = Integer.parseInt(params.id)
        Rating rating = Rating.findById(id)

        if(rating!=null){
            Resource resource = rating.resource

            // retira da soma de estrelas a quantidade de estrelas anterior do rating
            resource.sumStars -= rating.stars
            rating.delete flush: true;
            resource.sumUser = resource.ratings.size()
            resource.save flush: true

            render resource as JSON
        }
        else
            render "null"

    }

    def croppicture(){
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



}
