import msg.AuthRole
import msg.AuthUserAuthRole
import msg.User

class BootStrap {

    def init = { servletContext ->
        def adminRole = new AuthRole(authority: 'ROLE_ADMIN').save flush:true
        def admin     = new User(name: 'Matheus', screenName: "matheus", email: 'matheus.frndes@gmail.com',
                                 username: 'matheus', password: 'matheus').save flush: true
        def admin2     = new User(name: 'admin', screenName: "admin", email: 'admin@admin.com',
                                 username: 'admin', password: 'admin').save flush: true
        AuthUserAuthRole.create admin, adminRole, true
        AuthUserAuthRole.create admin2, adminRole, true


    }
    def destroy = {
    }
}
