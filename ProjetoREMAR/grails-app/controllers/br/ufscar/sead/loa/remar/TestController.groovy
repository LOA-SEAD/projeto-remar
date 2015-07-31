package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.http.HttpMethod

@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
class TestController {
    def springSecurityService

        def publishGame(){


        }



}
