import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.remar.Platform
import br.ufscar.sead.loa.remar.RequestMap
import br.ufscar.sead.loa.remar.Role
import br.ufscar.sead.loa.remar.UserRole
import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.MongoHelper
import grails.util.Environment
import br.ufscar.sead.loa.remar.Category

import javax.servlet.http.HttpServletRequest

class BootStrap {
    def grailsApplication

    def init = { servletContext ->

        MongoHelper.instance.init()

        Propeller.instance.init([dbName: 'remar-propeller', wipeDb: false])

        HttpServletRequest.metaClass.isXhr = { ->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }

        if (!Role.list()) {
            new Role(authority: "ROLE_ADMIN").save flush: true
            new Role(authority: "ROLE_DEV").save flush: true

            log.debug "Roles: ok"
        }

        if (!User.list()) {
            def admin = new User(
                    username: "admin",
                    password: grailsApplication.config.users.password,
                    email: "admin@gmail.com",
                    firstName: "Admin",
                    lastName: "User",
                    gender: 'male',
                    enabled: true
            )

            def guest = new User(
                    username: "guest",
                    password: grailsApplication.config.users.password,
                    email: "guest@gmail.com",
                    firstName: "Guest",
                    lastName: "User",
                    gender: 'female',
                    enabled: true,
            )

            admin.save flush: true
            guest.save flush: true

            UserRole.create admin, Role.findByAuthority("ROLE_ADMIN"), true
            UserRole.create admin, Role.findByAuthority("ROLE_DEV"), true

            log.debug "Users: ok"
        }

        def platforms = Platform.findAll();

        if (!platforms) {
            new Platform(name: "Android").save flush: true
            new Platform(name: "Linux").save flush: true
            new Platform(name: "Web").save flush: true
            new Platform(name: "Moodle").save flush: true

            log.debug "Platforms: ok"
        }

        def category = Category.findAll();

        if(!category){
            new Category(name: "Ação/Aventura",description:  "jogos de ação e aventura").save flush: true
            new Category(name: "Estratégia", description: "jogos de estratégia").save flush: true
            new Category(name: "Saúde", description: "jogos da area de saúde").save flush: true
            new Category(name: "RPG", description: "jogos de RPG").save flush: true
            new Category(name: "Esporte", description: "jogos de esporte").save flush: true
            new Category(name: "Simulação", description: "jogos de simulação").save flush: true
            new Category(name: "Puzzle", description: "jogos de puzzle").save flush: true
            new Category(name: "Clássicos", description: "jogos clássicos").save flush: true


            log.debug "Category: ok"
        }

        if (Environment.current == Environment.DEVELOPMENT) {
            RequestMap.findAll().each { it.delete flush: true }
        }

        if (!RequestMap.list()) { // will be true if env == dev or if first run in production
            for (url in [
                    '/dashboard', '/process/**', '/developer/new', '/exported-resource/**', '/exportedResource/**', '/frame/**', '/my-profile',
                    '/user/update', '/resource/customizableGames','/resource/show/**', '/moodle/link/**', '/moodle/unlink/**', '/resource/saveRating/**',
                    '/resource/updateRating/**',  '/resource/deleteRating/**'
            ]) {
                new RequestMap(url: url, configAttribute: 'IS_AUTHENTICATED_FULLY').save()
            }

            for (url in [
                    '/', '/index', '/index/project' , '/index/info', '/doc/**', '/assets/**', '/exportedResource/publicGames' , '/exported-resource/searchGame', '/**/js/**', '/**/css/**', '/**/images/**',
                    '/**/favicon.ico', '/data/**', '/**/scss/**', '/**/less/**', '/**/fonts/**', '/**/font/**',
                    '/password/**', '/moodle/**', '/exportedGame/**', '/static/**', '/login/**', '/logout/**', '/signup/**', '/user/**',
                    '/facebook/**', '/published/**']) {
                new RequestMap(url: url, configAttribute: 'permitAll').save()
            }



        new RequestMap(url: '/resource/**', configAttribute: 'ROLE_DEV').save()
        new RequestMap(url: '/resource/edit', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/resource/review', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/process/deploy', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/process/undeploy', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/user/index', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/reset', configAttribute: 'ROLE_ADMIN').save()
            for (url in [
                    '/resource/edit', '/resource/review', '/process/deploy', '/process/undeploy',
            ]) {
                new RequestMap(url: url, configAttribute: 'ROLE_ADMIN').save()
            }

            for (url in [
                    '/resource/**'
            ]) {
                new RequestMap(url: url, configAttribute: 'ROLE_DEV').save()
            }

            log.debug "RequestMaps: ok"
        }

        log.debug "Bootstrap: done"
    }
    def destroy = {
    }
}
