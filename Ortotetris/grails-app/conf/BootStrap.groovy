import br.ufscar.sead.loa.remar.*
class BootStrap {

    def init = { servletContext ->

        def allRoles = Role.findAll()
        def found = allRoles.findAll { it.authority == "ROLE_ADMIN" }
        if (found == []) {
            def adminRole = new Role(authority: "ROLE_ADMIN").save flush: true
            println "ROLE_ADMIN inserted"
        }

        if (found == []) {
            def adminRole = new Role(authority: "ROLE_FACEBOOK").save flush: true
            println "ROLE_FACEBOOK inserted"
        }

        found = allRoles.findAll { it.authority == "ROLE_USER" }
        if (found == []) {
            def profRole = new Role(authority: "ROLE_USER").save flush: true
            println "ROLE_USER inserted"
        }

        def allUsers = User.findAll()
        def userExists = allUsers.findAll {it.username == "admin"}


        if (userExists == []) {
            def userInstance = new User(
                    username: "admin",
                    password: "admin",
                   // email: "admin@gmail.com",
                    //name: "Admin",
                    enabled: true
            )

            userInstance.save flush: true

            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
            UserRole.create(userInstance, Role.findByAuthority("ROLE_USER"), true)
            UserRole.create(userInstance, Role.findByAuthority("ROLE_FACEBOOK"), true)


        }
    }
    def destroy = {
    }
}
