package br.ufscar.sead.loa.remar

import grails.converters.JSON
//import grails.plugin.facebooksdk.FacebookContext
//import grails.plugin.facebooksdk.FacebookGraphClient
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rest.client.RestBuilder

class FacebookController {
//
//    FacebookContext facebookContext

    def springSecurityService
    def facebookGraphService
//    FacebookGraphClient facebookGraphClient
    def auth() {
//
//        if(facebookContext.authenticated){
//            log.debug "Autenticado!"
//            log.debug facebookContext.user.age
//
//            String access_token =  session.facebook.access_token
//            log.debug access_token
//
//           FacebookGraphClient facebookGraphClient = new FacebookGraphClient(access_token)
//           def user = facebookGraphClient.fetchObject("me")
//            log.debug user
//            //facebookContext.getLoginURL('req_perms','email')
//
//
//
//
////            def publishMessageResponse = facebookGraphClient.publish("me/feed", [message:"RestFB test"])
////            log.debug "Published message ID: " + publishMessageResponse.id
//        }

        if (springSecurityService.isLoggedIn()) {
            redirect(controller: 'index', action: 'index')
        } else {

            def details = facebookGraphService.getDetails()
            log.debug details

            if (User.findByFacebookId(details.id)) {
                def currentUser = User.findByFacebookId(details.id)
                SpringSecurityUtils.reauthenticate(currentUser.username, currentUser.password)
                log.debug springSecurityService.getCurrentUser()
                log.debug "Usuario já no banco"

                //redirect(controller: 'index' ,action: 'index')
            } else {
                log.debug session.facebook
                def acess_token = session.facebook.access_token
                // log.debug facebookGraphService.getFacebookProfile(token)
                //facebookGraphService.api("me",HttpMethod.GET,LogCallback)
                //log.debug facebookGraphService.getFacebookProfile(session.facebook.access_token)
                log.debug details.email
                log.debug details.name
                log.debug details.id

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

                newUser.save flush: true
                UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)
                UserRole.create(newUser, Role.findByAuthority("ROLE_FACEBOOK"), true)

                SpringSecurityUtils.reauthenticate(newUser.username, newUser.password)
                log.debug "Novo usuario criado pelo Facebook"
                //redirect(controller: 'index', action: 'index')
            }

            redirect(controller: 'index', action: 'index')
        }

    }
}
