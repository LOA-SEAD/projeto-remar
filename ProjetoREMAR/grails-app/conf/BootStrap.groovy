import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.remar.Platform
import br.ufscar.sead.loa.remar.RequestMap
import br.ufscar.sead.loa.remar.Role
import br.ufscar.sead.loa.remar.UserRole
import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.MongoHelper
import br.ufscar.sead.loa.remar.Category

import javax.servlet.http.HttpServletRequest

class BootStrap {
    def grailsApplication

    def init = { servletContext ->

        MongoHelper.instance.init([username: grailsApplication.config.dataSource.username,
                                   password:  grailsApplication.config.dataSource.password])

        Propeller.instance.init([dbName: 'remar-propeller', wipeDb: false,
                                 username: grailsApplication.config.dataSource.username,
                                 authDb: 'admin',
                                 password: grailsApplication.config.dataSource.password])

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
                    email: "admin@remar.dc.ufscar.br",
                    firstName: "Equipe LOA",
                    lastName: "– REMAR",
                    enabled: true
            )

            admin.save flush: true

            UserRole.create admin, Role.findByAuthority("ROLE_ADMIN"), true
            UserRole.create admin, Role.findByAuthority("ROLE_DEV"), true

            log.debug "Users: ok"
        }

        Platform.findOrSaveByName('Android')
        Platform.findOrSaveByName('Linux')
        Platform.findOrSaveByName('Web')
        Platform.findOrSaveByName('Moodle')

        Category.findOrSaveByName("Ação/Aventura")
        Category.findOrSaveByName("Estratégia")
        Category.findOrSaveByName("Saúde")
        Category.findOrSaveByName("RPG")
        Category.findOrSaveByName("Esporte")
        Category.findOrSaveByName("Simulação")
        Category.findOrSaveByName("Puzzle")
        Category.findOrSaveByName("Clássicos")

        for (url in [
                '/dashboard', '/process/**', '/developer/new', '/exported-resource/**', '/exportedResource/**', '/my-profile',
                '/user/update', '/resource/customizableGames', '/resource/show/**', '/moodle/link/**', '/moodle/unlink/**', '/resource/saveRating/**',
                '/resource/updateRating/**', '/resource/deleteRating/**','/group/**','/user-group/**','/group-exported-resources/**'
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'isAuthenticated()')
        }

        RequestMap.findOrSaveByUrlAndConfigAttribute('/frame/**', 'IS_AUTHENTICATED_FULLY')

        for (url in [
                '/', '/index', '/index/project', '/index/info', '/doc/**', '/assets/**',
                '/exportedResource/publicGames', '/exported-resource/searchGame', '/**/js/**', '/**/css/**',
                '/**/images/**', '/**/favicon.ico', '/data/**', '/**/scss/**', '/**/less/**', '/**/fonts/**',
                '/**/font/**', '/password/**', '/moodle/**', '/exportedGame/**', '/static/**', '/login/**',
                '/logout/**', '/signup/**', '/user/**', '/facebook/**', '/published/**'
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'permitAll')
        }

        for (url in [
                '/process/deploy', '/process/undeploy','/category/**','/category/delete/**',"category/update/**"
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'ROLE_ADMIN')
        }

        for (url in [
                '/resource/**'
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'ROLE_DEV')
        }

        log.debug "Bootstrap: done"
    }

    def destroy = {
    }
}
