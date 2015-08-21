package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.runtime.ProcessInstance


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

        model.gameInstanceList = Game.findAllByStatus('approved') // change to #findAllByActive?

        def instances = []
        runtimeService.createProcessInstanceQuery().variableValueEquals("ownerId", "1").list().each {instance ->
            def i = []
            i.push(runtimeService.getVariable(instance.processInstanceId, "gameName"))

        }

        render view: "dashboard", model: model


    }
}