import br.ufscar.sead.loa.remar.Platform
import br.ufscar.sead.loa.remar.RequestMap
import br.ufscar.sead.loa.remar.Role
import br.ufscar.sead.loa.remar.UserRole
import br.ufscar.sead.loa.remar.User
import grails.util.Environment
import org.camunda.bpm.engine.IdentityService
import org.camunda.bpm.engine.identity.Group
import org.codehaus.groovy.grails.io.support.GrailsResourceUtils

import javax.servlet.http.HttpServletRequest

class BootStrap {
    IdentityService identityService
    def grailsApplication

    def init = { servletContext ->

        HttpServletRequest.metaClass.isXhr = {->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }

        def allRoles = Role.findAll()
        def found = allRoles.findAll {it.authority == "ROLE_ADMIN"}
        if (found == []) {
            def adminRole = new Role(authority: "ROLE_ADMIN").save flush: true
            println "ROLE_ADMIN inserted"
        }

        found = allRoles.findAll {it.authority == "ROLE_DEV"}
        if (found == []) {
            def devRole = new Role(authority: "ROLE_DEV").save flush: true
            println "ROLE_DEV inserted"
        }

        def adminUser = User.findByUsername("admin")

        if(adminUser == null) {
            def userInstance = new User (
                username: "admin",
                password: "admin",
                email: "admin@gmail.com",
                name: "Admin",
                enabled: true,
                camunda_id: "admin"
            )

            if(Environment.current == Environment.PRODUCTION) {
                userInstance.password = grailsApplication.config.root.password
            }

            org.camunda.bpm.engine.identity.User camundaUser = identityService.newUser(userInstance.username)

            camundaUser.setEmail(userInstance.email)
            camundaUser.setFirstName(userInstance.name)
            camundaUser.setPassword(userInstance.password)
            camundaUser.setId(userInstance.username)
            identityService.saveUser(camundaUser)

            userInstance.camunda_id = camundaUser.getId()

            userInstance.save flush:true
            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
            UserRole.create(userInstance, Role.findByAuthority("ROLE_DEV"), true)

            println "admin user inserted"
        }

        def guestUser = User.findByUsername("guest")
        println "guestUser: " + guestUser

        if(guestUser == null) {
            def guestUserInstance = new User (
                username: "guest",
                password: "guest",
                email: "guest@gmail.com",
                name: "Guest User",
                enabled: true,
                camunda_id: "guest"
            )

            if(Environment.current == Environment.PRODUCTION) {
                guestUserInstance.password = grailsApplication.config.root.password
            }

            org.camunda.bpm.engine.identity.User camundaGuestUser = identityService.newUser(guestUserInstance.username)

            camundaGuestUser.setEmail(guestUserInstance.email)
            camundaGuestUser.setFirstName(guestUserInstance.name)
            camundaGuestUser.setPassword(guestUserInstance.password)
            camundaGuestUser.setId(guestUserInstance.username)
            identityService.saveUser(camundaGuestUser)

            guestUserInstance.camunda_id = camundaGuestUser.getId()

            guestUserInstance.save flush:true
            UserRole.create(guestUserInstance, Role.findByAuthority("ROLE_PROF"), true)
            UserRole.create(guestUserInstance, Role.findByAuthority("ROLE_DEV"), true)

            println "guest user inserted"
        }

        def platforms = Platform.findAll();

        if (platforms == []) {
            new Platform(name: "Android").save flush: true
            new Platform(name: "Linux").save flush: true
            new Platform(name: "Web").save flush: true
            new Platform(name: "Moodle").save flush: true
        }

        if (Environment.current ==  Environment.DEVELOPMENT) {
            RequestMap.findAll().each { it.delete flush: true }
        }

        for (url in [
                '/', '/index', '/index/info', '/doc/**', '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
                '/**/favicon.ico', '/data/**', '/**/scss/**', '/**/less/**', '/**/fonts/**', '/password/**',
                '/moodle/**', '/exportedGame/**', '/static/**', '/login/**', '/logout/**', '/user/**',
                '/facebook/**']) {
            new RequestMap(url: url, configAttribute: 'permitAll').save()
        }

        new RequestMap(url: '/dashboard', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/resource/**', configAttribute: 'ROLE_DEV').save()
        new RequestMap(url: '/resource/edit', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/resource/review', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/process/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/process/deploy', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/process/undeploy', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/user/index', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/developer/new', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/process/versions', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/exported-resource/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save()

//            new RequestMap(url: '', configAttribute: '').save()


        println "Bootstrap: done"
    }
    def destroy = {
    }
}
