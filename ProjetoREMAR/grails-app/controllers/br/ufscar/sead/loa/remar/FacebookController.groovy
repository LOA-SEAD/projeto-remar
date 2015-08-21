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
//            println "Autenticado!"
//            println facebookContext.user.age
//
//            String access_token =  session.facebook.access_token
//            println access_token
//
//           FacebookGraphClient facebookGraphClient = new FacebookGraphClient(access_token)
//           def user = facebookGraphClient.fetchObject("me")
//            println user
//            //facebookContext.getLoginURL('req_perms','email')
//
//
//
//
////            def publishMessageResponse = facebookGraphClient.publish("me/feed", [message:"RestFB test"])
////            println "Published message ID: " + publishMessageResponse.id
//        }

        if (springSecurityService.isLoggedIn()) {
            redirect(controller: 'index', action: 'index')
        } else {

            def details = facebookGraphService.getDetails()
            println details

            if (User.findByFacebookId(details.id)) {
                def currentUser = User.findByFacebookId(details.id)
                SpringSecurityUtils.reauthenticate(currentUser.username, currentUser.password)
                println springSecurityService.getCurrentUser()
                println "Usuario já no banco"

                //redirect(controller: 'index' ,action: 'index')
            } else {
                println session.facebook
                def acess_token = session.facebook.access_token
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

                newUser.save flush: true
                UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)
                UserRole.create(newUser, Role.findByAuthority("ROLE_FACEBOOK"), true)

                SpringSecurityUtils.reauthenticate(newUser.username, newUser.password)
                println "Novo usuario criado pelo Facebook"
                //redirect(controller: 'index', action: 'index')
            }

            redirect(controller: 'index', action: 'index')
        }

    }
}
