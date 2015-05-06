package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def index() {
        def user = springSecurityService.currentUser
    	Set<Role> userAuthorities = user.getAuthorities()
    	if (userAuthorities.any { it.authority == "ROLE_ADMIN" }) {
    		redirect controller: "admin"
		}
        else{
            if (userAuthorities.any { it.authority == "ROLE_PROF" }) {
            	redirect controller: "professor"
            }
            else{
            	if (userAuthorities.any { it.authority == "ROLE_STUD" }) {
            		redirect controller: "student"
            	}
            	else{
            		if (userAuthorities.any { it.authority == "ROLE_EDITOR" }) {
            			redirect controller: "editor"
            		}
            	}
            }
        }
    }
}