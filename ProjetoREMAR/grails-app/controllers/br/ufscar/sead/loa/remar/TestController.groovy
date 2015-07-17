package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.http.HttpMethod

@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
class TestController {
    def springSecurityService
    def facebookGraphService
    RedisConnection redisHandler
    def redisService

    def facebookLogin(){
        println "No test controoler"
        def details = facebookGraphService.getDetails()

        if(User.findByFacebookId(details.id)) {
            def currentUser = User.findByFacebookId(details.id)
            SpringSecurityUtils.reauthenticate(currentUser.username, currentUser.password)
            println springSecurityService.getCurrentUser()

            redirect(controller: 'index' ,action: 'index')
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
            User newUser = new User(
                    username: details.name,
                    camunda_id: details.name,
                    name: details.name,
                    facebookId: details.id,
                    email: "Teste2@teste.com.br",
                    password: details.id,
                    enabled: true,
                    accountExpired: false,
                    accountLocked: false,
                    passwordExpired: false
            )

            newUser.save()
            UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)
            UserRole.create(newUser, Role.findByAuthority("ROLE_FACEBOOK"), true)

            redirect(controller: 'index', action: 'index')
        }

//
//        FacebookUser fbUser = new FacebookUser(
//                uid: token.uid,
//                accessToken:token.accessToken.accessToken,
//                accessTokenExpires: token.accessToken.expireAt,
//                user: User.findByUsername("$token.uid")
//        )
//        fbUser.save()

    }

    def index() {
        RedisConnection.reset() // for testing only
        redisHandler = RedisConnection.getInstance(redisService)
    }

    def psubscribe() {
        RedisConnection.getInstance(redisService).pSubscribe("complete*")
    }
}
