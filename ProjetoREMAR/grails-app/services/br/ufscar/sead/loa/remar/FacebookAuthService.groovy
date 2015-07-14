package br.ufscar.sead.loa.remar

import com.the6hours.grails.springsecurity.facebook.FacebookAuthToken
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import br.ufscar.sead.loa.remar.User

@Transactional
class FacebookAuthService {
    def facebookGraphService
    def serviceMethod() {

    }
//    void onCreate(FacebookUser user, FacebookAuthToken token) {
//        log.info("Creating user: $user for fb user: $token.uid")
//        println "No create"
//    }

    FacebookUser create(FacebookAuthToken token) {
        log.info("Create domain for facebook user $token.uid")
        User newUser = new User(
                username: "$token.uid",
                camunda_id: "$token.name",
                name: "$token.name",
                email: "Teste@teste.com.br",
                password: '123',
                enabled: true,
                accountExpired: false,
                accountLocked: false,
                passwordExpired: false
        )
        println newUser.username
        println newUser.name
        println newUser.camunda_id
        newUser.save()

        //UserRole.create(newUser, Role.findByAuthority("ROLE_USER"), true)


        FacebookUser fbUser = new FacebookUser(
                uid: token.uid,
                accessToken: token.accessToken,
                user: newUser
        )

        fbUser.save()
        return fbUser
    }

}
