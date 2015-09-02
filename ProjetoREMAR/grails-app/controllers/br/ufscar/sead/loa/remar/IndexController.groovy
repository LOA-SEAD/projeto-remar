package br.ufscar.sead.loa.remar

import org.camunda.bpm.engine.RuntimeService

class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    RuntimeService runtimeService

    def index() {
        if (springSecurityService.isLoggedIn()) {
            session.user = springSecurityService.currentUser
            redirect uri: "/dashboard"
        } else {
            render view: "index"
        }
    }

    def dashboard() {
        def model = [:]

        model.gameInstanceList = Resource.findAllByStatus('approved') // change to #findAllByActive?
        model.userName = session.user.name

        def instances = []
        runtimeService.createProcessInstanceQuery().variableValueEquals("ownerId", "1").list().each {instance ->
            def i = []
            i.push(runtimeService.getVariable(instance.processInstanceId, "gameName"))

        }
        render view: "dashboard", model: model
    }
}