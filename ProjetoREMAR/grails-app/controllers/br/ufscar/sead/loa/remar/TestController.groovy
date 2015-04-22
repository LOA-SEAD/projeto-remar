package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class TestController {

    def springSecurityService

    @Secured(["ROLE_ADMIN"])
    def admin() {
        render springSecurityService.getCurrentUser().toString().replace("\n", "<br>")
    }

    @Secured(["ROLE_PROF"])
    def prof() {
        render springSecurityService.getCurrentUser().toString().replace("\n", "<br>")
    }

    @Secured(["ROLE_STUD"])
    def stud() {
        render springSecurityService.getCurrentUser().toString().replace("\n", "<br>")
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def anon() { // TODO: check if  logged in
        render springSecurityService.getCurrentUser().toString().replace("\n", "<br>")
    }
}
