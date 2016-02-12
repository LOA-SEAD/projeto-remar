package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.util.Environment
import groovyx.net.http.HTTPBuilder
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.springframework.web.multipart.MultipartFile

import java.security.MessageDigest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class ResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def springSecurityService

    def index(Integer max) {

        if (request.isUserInRole("ROLE_ADMIN")) {
            render view: 'index', model:[resourceInstanceList: Resource.list(), resourceInstanceCount: Resource.count()]
        } else {
            render view: 'index', model:[resourceInstanceList: Resource.findAllByOwner(springSecurityService.currentUser as User), resourceInstanceCount: Resource.count()]
        }

    }


    def create() {
        render view: "create", model: [id: params.id]
    }

    @Transactional
    def update(Resource instance){
        def path = new File(servletContext.getRealPath("/data/resources/assets/${instance.uri}"))
        path.mkdirs()

        MultipartFile img1 = request.getFile('img1')
        MultipartFile img2 = request.getFile('img2')
        MultipartFile img3 = request.getFile('img3')

        def file1, file2, file3

        file1 = new File(path, "description-1")
        img1.transferTo(file1)

        file2 = new File(path, "description-2")
        img2.transferTo(file2)

        file3 = new File(path, "description-3")
        img3.transferTo(file3)

        instance.description = params.description
        instance.name = params.name
        instance.comment = "Em avaliação"
        //TODO colocar a categoria

        instance.save flush: true

        redirect action: "index"
//       redirect action: "index", params: [id: resourceInstance.id]
    }

    @Transactional
    def save(Resource resourceInstance) { // saves and verifies WAR file
        def username = springSecurityService.currentUser.username
        MultipartFile war = params.war
        def fileName = MessageDigest.getInstance("MD5").digest(war.bytes).encodeHex().toString()
        resourceInstance.submittedAt = new Date()
        resourceInstance.owner       = springSecurityService.currentUser as User
        resourceInstance.status      = "pending"
        resourceInstance.valid       = true

        // move to wars folder
        def file = new File(servletContext.getRealPath("/wars/${username}"), fileName + ".war")
        file.mkdirs()
        war.transferTo(file)

        // unzip
        "chmod -R a+x ${servletContext.getRealPath('/scripts')}".execute().waitFor()
        def unzip = "${servletContext.getRealPath("/scripts")}/unzip.sh ${servletContext.getRealPath("/wars/${username}")} ${fileName}"
        unzip.execute().waitFor()

        file = new File(servletContext.getRealPath("/wars/${username}/${fileName}/WEB-INF"))
        if (!file.exists()) { // file is a WAR?
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = war.originalFilename + " isn't a war!"
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "not war"
            return
        }

        file = new File(servletContext.getRealPath("/wars/${username}/${fileName}/data/manifest.json"))
        if (!file.exists()) { // WAR has a manifest.json?
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = war.originalFilename + " doesn't contain a manifest.json."
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "missng manifest"
            return
        }

        def manifest = JSON.parse(file.getText('UTF-8'))

        // manifest is valid?
        if (manifest.name  == null || manifest.android  == null || manifest.linux  == null || manifest.moodle  == null
            || manifest.bpmn  == null || manifest.uri == null) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status = "rejected"
            resourceInstance.comment = war.originalFilename + " doesn't contain a valid manifest.json."
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "invalid manifest"
            return
        }

        resourceInstance.name       = manifest.name
        resourceInstance.uri        = manifest.uri
        resourceInstance.android    = manifest.android
        resourceInstance.linux      = manifest.linux
        resourceInstance.moodle     = manifest.moodle
        resourceInstance.files      = manifest.files
        resourceInstance.moodleJson = manifest.moodlejson

        if (!manifest.width) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status = "rejected"
            resourceInstance.comment = "Missing 'width' property in manifest.json."
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "invalid manifest"
            return
        }
        else {
            resourceInstance.width   = manifest.width
        }

        if (!manifest.height) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status = "rejected"
            resourceInstance.comment = "Missing 'height' property in manifest.json."
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "invalid manifest"
            return
        }
        else {
            resourceInstance.height   = manifest.height
        }


        //read the file that describes the game DB and creates a collection with the corresponding name
        def bd = new File(servletContext.getRealPath("/wars/${username}/${fileName}/data/bd.json"))

        if (!bd.exists()) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = "bd.json file not found"
            resourceInstance.save flush: true
            log.debug "moodleBD.json file not found"
            redirect action: "index"
            return
        }
        else {
            new AntBuilder().copy(file: servletContext.getRealPath("/wars/${username}/${fileName}/data/bd.json"),
                    tofile: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}/bd.json"))

            def json = JSON.parse(bd.text)
            MongoHelper.createCollection(json['collection_name'])
        }


        def cmd = servletContext.getRealPath("/scripts") + "/verify-banner.sh ${servletContext.getRealPath("/wars/${username}")}/${fileName} ${manifest.uri}-banner"
        def foundBanner = cmd.execute().text.toInteger()

        // has banner?
        if (!foundBanner) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = "${manifest.uri}-banner.png not found!"
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "banner not found"
            return
        }

        // copy banner to /assets

        cmd = servletContext.getRealPath("/scripts") + "/verify-bpmn.sh ${servletContext.getRealPath("/wars/${username}")}/${fileName} ${manifest.bpmn}"
        def foundBpmn = cmd.execute().text.toInteger()

        // has bpmn?
        if (!foundBpmn) {
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = "${manifest.bpmn}.bpmn not found!"
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "bpmn not found"
            return
        }

        file = new File(servletContext.getRealPath("/wars/${username}/${fileName}/data/source"))
        if (!file.exists()) { // source folder exists?
            resourceInstance.valid = false
            resourceInstance.name = war.originalFilename
            resourceInstance.uri = ""
            resourceInstance.status  = "rejected"
            resourceInstance.comment = "source folder not found"
            resourceInstance.save flush: true
            redirect action: "index"
            log.debug "source folder not found"
            return
        }

        resourceInstance.web = true //default
        resourceInstance.bpmn = manifest.bpmn
        resourceInstance.comment = "Esperando Formulário"

        new File(servletContext.getRealPath("/wars/${username}"), fileName + ".war")
                       .renameTo(servletContext.getRealPath("/wars/${username}") + "/" + manifest.uri + ".war")

        resourceInstance.save flush:true


        if(resourceInstance.hasErrors()) {
            log.debug resourceInstance.errors
            respond resourceInstance.errors, view:"create"
        } else {

            new AntBuilder().copy(todir: servletContext.getRealPath("/data/resources/sources/${resourceInstance.uri}")) {
                fileset(dir: file)
            }
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), resourceInstance.id])
//            redirect action: "create", params: [id: resourceInstance.id]
            render resourceInstance as JSON
        }

    }

    def test() {
        "chmod a+x ${servletContext.getRealPath("/scripts/test.sh")}".execute().waitFor()
        render "${servletContext.getRealPath("/scripts/test.sh")}".execute().text
    }

    def newDeveloper(){


    }

    def review() {
        def resourceInstance = Resource.findById(params.id)
        String status  = params.status
        String comment = params.comment

        if(!status) {
            resourceInstance.comment = comment
            if(resourceInstance.status == "rejected") {
                Util.sendEmail(resourceInstance.owner.email,
                        "REMAR – O seu WAR \"${resourceInstance.name}\" foi rejeitado!",
                        "<h3>O seu WAR \"${resourceInstance.name}\" foi rejeitado pois ${comment}</h3> <br> "
                )
                render 'success'
            }
        }

        if (status == "approve" && resourceInstance.status != "approved") {

            "${servletContext.getRealPath("/scripts/db.sh")} ${resourceInstance.uri}".execute().waitFor()

            if (Environment.current == Environment.DEVELOPMENT) {
                resourceInstance.status  = "approved"
                resourceInstance.active = true
                resourceInstance.version = 0
                resourceInstance.save flush: true

                redirect controller: "process", action: "deploy", id: resourceInstance.bpmn
                return
            }

            def http = new HTTPBuilder("http://root:${grailsApplication.config.root.password}@localhost:8080")
            def resp = http.get(path: '/manager/text/deploy',
                    query: [path: "/${resourceInstance.uri}",
                            war: servletContext.getRealPath("/wars/${springSecurityService.currentUser.username}/${resourceInstance.uri}.war") ])
            resp = GrailsIOUtils.toString(resp)
            if(resp.indexOf('OK') != -1) {
                resourceInstance.status  = "approved"
                resourceInstance.active = true
                resourceInstance.version = 0
                resourceInstance.save flush: true

                //noinspection GroovyAssignabilityCheck
                Util.sendEmail(resourceInstance.owner.email,
                        "REMAR – O seu WAR \"${resourceInstance.name}\" foi aprovado!",
                        '<h3>O seu WAR \"${resourceInstance.name}\" foi aprovado! :)</h3> <br>'
                )

                redirect controller: "process", action: "deploy", id: resourceInstance.bpmn
            } else {
                response.status = 500
                render resp

            }
            // probably we don't need this anymore because when the WAR is deployed the bpmn is deployed too
            // redirect controller: "process", action: "deploy", id: resourceInstance.bpmn
        } else if (status == "reject" && resourceInstance.status != "rejected") {
            resourceInstance.status  = "rejected"

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

        if (resourceInstance.owner == springSecurityService.currentUser || springSecurityService.currentUser == User.findByUsername('admin')) {
            resourceInstance.delete flush: true
            log.debug "Resource Deleted"
        }
        else {
            log.debug "Someone is trying to delete a resource that belongs to other user"
        }

        render "success"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'deploy.label', default: 'Deploy'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def show(Resource instance){
        render view: "show", model: [resourceInstance : instance]
    }

    def customizableGames(){
        def model = [:]

        model.gameInstanceList = Resource.findAllByStatus('approved') // change to #findAllByActive?

        render view: "customizableGames", model: model
    }


    def edit(Resource resourceInstance) {

        def resourceJson = resourceInstance as JSON

        render view: 'edit', model:[resourceInstance: resourceInstance]
    }

    def getResourceInstance(long id){

        def r = Resource.findById(id) as JSON

        render r;
    }
}
