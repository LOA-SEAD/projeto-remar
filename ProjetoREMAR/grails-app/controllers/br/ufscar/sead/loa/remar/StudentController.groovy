package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_STUD'])
class StudentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def index() {
        render view: 'index'
    }
}