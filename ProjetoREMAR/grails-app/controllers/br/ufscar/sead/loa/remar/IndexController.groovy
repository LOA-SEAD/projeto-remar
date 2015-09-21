package br.ufscar.sead.loa.remar

import grails.util.Environment
import org.camunda.bpm.engine.RuntimeService

class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    RuntimeService runtimeService

    def index() {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: "/dashboard"
        } else {
            render view: "index"
        }
    }

    def dashboard() {
        def model = [:]

        model.gameInstanceList = Resource.findAllByStatus('approved') // change to #findAllByActive?
        model.userName = session.user.name
        model.userGender = User.findById(session.user.id).gender
        model.publicExportedResourcesList = ExportedResource.findAllByType('public')
        model.myExportedResourcesList = ExportedResource.findAllByTypeAndOwner('public', User.get(session.user.id))

        println model.userGender
        println "RESULT: " + model.publicExportedResourcesList.size()

        def instances = []
        runtimeService.createProcessInstanceQuery().variableValueEquals("ownerId", "1").list().each {instance ->
            def i = []
            i.push(runtimeService.getVariable(instance.processInstanceId, "gameName"))

        }
        render view: "dashboard", model: model
    }

    def frame() {
        def model = [:]
        model.development = Environment.current == Environment.DEVELOPMENT
        model.uri = params.remove('uri')

        params.remove("controller")
        params.remove("action")
        params.remove("format")

        model.uri += "?" + params.collect { k,v -> "$k=$v" }.join('&')

        if (model.development) {
            if (model.uri.indexOf('escola') != -1) {
                model.uri = "http://localhost:7070${model.uri}"
            } else if (model.uri.indexOf('forca') != -1) {
                model.uri = "http://localhost:8080${model.uri}"
            }
        }

        model.uri += "&h=" + (session.user.username as String).bytes.encodeBase64().toString()

        render view: "frame", model: model
    }
}