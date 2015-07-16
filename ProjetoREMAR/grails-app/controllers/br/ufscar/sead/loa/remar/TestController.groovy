package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.http.HttpMethod

@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
class TestController {
    def facebookGraphService
    RedisConnection redisHandler
    def redisService

    def facebookLogin(){
        println "No test controoler"
        println session.facebook
        println session.facebook.access_token
        def details = facebookGraphService.getDetails()
        //facebookGraphService.api("me",HttpMethod.GET,LogCallback)
        println facebookGraphService.getFacebookProfile(session.facebook.access_token)
        println details.email
        println details.name
//        User newUser = new User(
//                username: details.name,
//                camunda_id: details.name,
//                name: details.name,
//                email: "Teste2@teste.com.br",
//                password: '123',
//                enabled: true,
//                accountExpired: false,
//                accountLocked: false,
//                passwordExpired: false
//        )

//        newUser.save()
//        UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)
//        SpringSecurityUtils.reauthenticate(newUser.username, newUser.password)
//        println springSecurityService.getCurrentUser()
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
