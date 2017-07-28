package br.ufscar.sead.loa.quimolecula

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
class MoleculeController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def springSecurityService


    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Molecule.findAllByAuthor(session.user.username, [sort: "name"])

        render view: "index", model: [MoleculeInstanceList: list, MoleculeInstanceCount: list.size(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def create(){
        render view: "create"
    }

    @Transactional
    def save(Molecule MoleculeInstance) {
        if (MoleculeInstance.author == null) {
            MoleculeInstance.author = session.user.username
        }

        Molecule newMolecule  = new Molecule();
        newMolecule.id        = MoleculeInstance.id
        newMolecule.xml       = MoleculeInstance.xml
        newMolecule.tip       = MoleculeInstance.tip
        newMolecule.name      = MoleculeInstance.name
        newMolecule.author    = MoleculeInstance.author
        newMolecule.structure = MoleculeInstance.structure

        newMolecule.ownerId   = session.user.id
        newMolecule.taskId    = session.taskId as String

        if (newMolecule.hasErrors()) {
            respond newMolecule.errors, view: 'create' //TODO
            render newMolecule.errors;
            return
        }

        newMolecule.save flush: true

        if (request.xhr) {
            render(contentType: "application/json") {
                JSON.parse("{\"status\": \"SUCCESS\" }")
            }
        }
    }

    @Transactional
    def delete(Molecule MoleculeInstance) {
        if (MoleculeInstance == null) {
            notFound()
            return
        }

        MoleculeInstance.delete flush: true

        if (request.xhr) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + MoleculeInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'Molecule.label', default: 'Molecule'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def send() {
        def i, fileId
        def fileList = ""
        def dataPath = servletContext.getRealPath("/data")
        def moleculeList = Molecule.getAll(params["id[]"])
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()

        for (i = 0; i < moleculeList.size(); i++) {
            File file = new File(String.format("$userPath/%d.xml", i))
            PrintWriter pw = new PrintWriter(file)
            pw.write(moleculeList[i].xml)
            pw.close()
            fileId = MongoHelper.putFile(file.absolutePath)
            fileList += "files=${fileId}&"
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        def url = "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?${fileList}"

        redirect uri: url
    }
}
