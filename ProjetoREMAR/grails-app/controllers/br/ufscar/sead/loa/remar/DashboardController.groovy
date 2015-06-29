package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN","ROLE_STUD","ROLE_USER"])
class DashboardController {

    def index() { }
}
