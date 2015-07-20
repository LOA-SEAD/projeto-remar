package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
class FacebookController {
    def springSecurityService
    def facebookGraphService
    def auth() {

        def details = facebookGraphService.getDetails()

        if(User.findByFacebookId(details.id)) {
            def currentUser = User.findByFacebookId(details.id)
            SpringSecurityUtils.reauthenticate(currentUser.username, currentUser.password)
            println springSecurityService.getCurrentUser()

            //redirect(controller: 'index' ,action: 'index')
        }
        else{
            println session.facebook
            def acess_token =  session.facebook.access_token
            // println facebookGraphService.getFacebookProfile(token)
            //facebookGraphService.api("me",HttpMethod.GET,LogCallback)
            //println facebookGraphService.getFacebookProfile(session.facebook.access_token)
            println details.email
            println details.name
            println details.id

            def n = Math.abs(new Random().nextInt() % 5000) + 1
            User newUser = new User(
                    username: details.name,
                    camunda_id: details.name,
                    name: details.name,
                    facebookId: details.id,
                    email: "Teste$n@teste.com.br",
                    password: details.id,
                    enabled: true,
                    accountExpired: false,
                    accountLocked: false,
                    passwordExpired: false
            )

            newUser.save()
            UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)
            UserRole.create(newUser, Role.findByAuthority("ROLE_FACEBOOK"), true)

            //redirect(controller: 'index', action: 'index')
        }

        redirect(controller: 'index', action: 'index')
    }
}
