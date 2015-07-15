package br.ufscar.sead.loa.remar

import com.daureos.facebook.FacebookGraphService
import com.the6hours.grails.springsecurity.facebook.FacebookAuthDao
import com.the6hours.grails.springsecurity.facebook.FacebookAuthToken
import com.the6hours.grails.springsecurity.facebook.FacebookAuthUtils
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import br.ufscar.sead.loa.remar.User

@Transactional
class FacebookAuthService {
    def facebookGraphService
    FacebookUser facebookUser
    def serviceMethod() {

    }
//    void onCreate(FacebookUser user, FacebookAuthToken token) {
//        log.info("Creating user: $user for fb user: $token.uid")
//        println "No create"
//        println facebookGraphService.getEvents()
//        println user.uid
//        println user.accessToken
//        println user.getAccessTokenExpires()
//        println token.name
//        println token.credentials
//    }

    @Transactional(readOnly=false)
    FacebookUser create(FacebookAuthToken token) {

        User newUser = new User(
                username: "$token.uid",
                camunda_id: "CamundaIDTESTE",
                name: "Nome TESTE",
                email: "Teste@teste.com.br",
                password: '123',
                enabled: true,
                accountExpired: false,
                accountLocked: false,
                passwordExpired: false
        )

        newUser.save()
        UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)


        FacebookUser fbUser = new FacebookUser(
                uid: token.uid,
                accessToken:token.accessToken.accessToken,
                accessTokenExpires: token.accessToken.expireAt,
                user: User.findByUsername("$token.uid")
        )
        fbUser.save()
        println "------------------------------------"
        println "token:" + token.uid
        println "acess:" + token.accessToken.accessToken
        println "name: " + token.name
        println "------------------------------------"




//        def fbProfile = facebookGraphService.getFacebookProfile(token.accessToken.accessToken)
//        log.info("Create domain for facebook user $token.uid")
//
//
//
//        FacebookUser fbUser = new FacebookUser(
//                uid: token.uid,
//                accessToken: token.accessToken,
//                user: newUser
//        )
//
//        fbUser.save()

    }

}
