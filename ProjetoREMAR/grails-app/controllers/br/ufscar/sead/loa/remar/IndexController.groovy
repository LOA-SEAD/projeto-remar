package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured


class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        if (springSecurityService.isLoggedIn()) {
            render view:"dashboard"
        } else {
            render view: "index"
        }
    }
}