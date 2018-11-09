import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.remar.Platform
import br.ufscar.sead.loa.remar.RequestMap
import br.ufscar.sead.loa.remar.Role
import br.ufscar.sead.loa.remar.UserRole
import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.MongoHelper
import br.ufscar.sead.loa.remar.Category

import br.ufscar.sead.loa.remar.Group
import br.ufscar.sead.loa.remar.UserGroup

import javax.servlet.http.HttpServletRequest

class BootStrap {
    def grailsApplication

    def init = { servletContext ->

        MongoHelper.instance.init([dbHost  : grailsApplication.config.dataSource.dbHost,
                                   username: grailsApplication.config.dataSource.username,
                                   password: grailsApplication.config.dataSource.password])

        Propeller.instance.init([dbHost  : grailsApplication.config.dataSource.dbHost, dbName: 'remar-propeller', wipeDb: false,
                                 username: grailsApplication.config.dataSource.username,
                                 authDb  : 'admin',
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
                    email: "remar@sead.ufscar.br",
                    firstName: "Administrador ",
                    lastName: "– REMAR",
                    enabled: true
            )
            admin.save flush: true

            UserRole.create admin, Role.findByAuthority("ROLE_ADMIN"), true
            UserRole.create admin, Role.findByAuthority("ROLE_DEV"), true

            def loa = new User(
                    username: "loa",
                    password: grailsApplication.config.users.password,
                    email: "loa@sead.ufscar.br",
                    firstName: "Equipe LOA",
                    lastName: "– REMAR",
                    enabled: true
            )
            loa.save flush: true

            UserRole.create loa, Role.findByAuthority("ROLE_DEV"), true

            log.debug "Users: ok"
        }


        File csvDir = new File(servletContext.getRealPath("csv"))

        if (csvDir.exists()) {

            int lines = 0;
            int created = 0;
            int exists = 0;

            new File(servletContext.getRealPath("csv/users.csv")).splitEachLine(";") { fields ->

                lines++;
                if (User.countByUsername(fields[0]) == 0) {

                    def user = new User(
                            username: fields[0],
                            password: fields[1],
                            email: fields[2],
                            firstName: fields[3],
                            lastName: fields[4],
                            enabled: true
                    )

                    user.save flush: true

                    if (user.hasErrors()) {
                        println user.errors
                    } else {
                        created++;
                    }
                } else {
                    exists++;
                }
            }

            log.debug 'Users & Groups (via csv): ' + created + ' usuários criados (arquivo csv com ' + lines + ' linhas)'
            log.debug 'Users & Groups (via csv): ' + exists + ' usuários já existentes (arquivo csv com ' + lines + ' linhas)'

            File dir = new File(servletContext.getRealPath("csv/grupos"))

            for (final File fileEntry : dir.listFiles()) {
                String fileName = fileEntry.getName();
                String groupName = fileName.substring(0, fileName.size() - 4)
                def owner = User.findById(1)
                if (Group.countByNameAndOwner(groupName, owner) == 0) {
                    Group group = new Group(name: groupName, owner: owner, token: groupName)
                    group.save flush: true

                    if (group.hasErrors()) {
                        println group.errors
                    } else {
                        lines = 0;
                        new File(servletContext.getRealPath("csv/grupos/" + fileName)).splitEachLine(";") { fields ->
                            def userName = fields[0]
                            def user = User.findByUsername(userName)

                            if (user) {
                                def userGroup = new UserGroup()
                                userGroup.group = group
                                userGroup.user = user
                                userGroup.admin = (fields[1].toUpperCase() == 'S')
                                userGroup.save flush: true
                                lines++
                            }
                        }
                        log.debug 'Users & Groups (via csv): Grupo ' + groupName + ' criado com ' + lines + ' usuários.'
                    }
                } else {
                    log.debug 'Users & Groups (via csv): Grupo ' + groupName + ' já existe.'
                }
            }
            log.debug "Users & Groups (via csv): ok"
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
                '/user/update', '/userProfile', '/userProfile/**', '/moodle/link/**', '/moodle/unlink/**', '/resource/saveRating/**',
                '/resource/updateRating/**', '/resource/deleteRating/**', '/group/**', '/group/user-stats/**', '/group/stats/**', '/user-group/**', '/group-exported-resources/**',
                '/dspace/**', '/resource/customizableGames', '/resource/show/**', '/stats/**'
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'isAuthenticated()')
        }

        RequestMap.findOrSaveByUrlAndConfigAttribute('/frame/**', 'IS_AUTHENTICATED_FULLY')

        for (url in [
                '/', '/index', '/index/apresentacao', '/index/arquitetura', '/index/equipe', '/index/publicacoes',
                '/index/contato', '/doc/**', '/assets/**',
                '/exportedResource/publicGames', '/exported-resource/searchGameByCategoryAndName', '/**/js/**', '/**/css/**',
                '/**/images/**', '/**/favicon.ico', '/data/**', '/**/scss/**', '/**/less/**', '/**/fonts/**',
                '/**/font/**', '/password/**', '/moodle/**', '/exportedGame/**', '/static/**', '/login/**',
                '/logout/**', '/signup/**', '/user/**', '/facebook/**', '/published/**', '/group/isLogged'
        ]) {
            RequestMap.findOrSaveByUrlAndConfigAttribute(url, 'permitAll')
        }

        for (url in [
                '/process/deploy', '/process/undeploy', '/category/**', '/category/delete/**', "category/update/**"
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
