package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_PROF'])
class ProfessorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def index() {
        render view: 'index'
    }
}