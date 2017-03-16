import br.ufscar.sead.loa.labteca.remar.Composto

class BootStrap {

    def init = { servletContext ->

        /*
        def adminRole = Role.findByAuthority("ROLE_ADMIN") ?: new Role(authority: "ROLE_ADMIN").save()

        def admin = new User (
                username: "admin",
                password: "admin",
                firstName: "Ad",
                lastName: "Min",
                email: "admin@admin.com",
                enabled: true
        )
        admin.save()
        if (admin.hasErrors()) {
            println admin.errors
        }
        UserRole.create(admin, adminRole)

        print "populando usuário admin -> ok"
        */


        if (Composto.list().size() == 0) {
            def nacl = new Composto(nome: "Cloreto de Sódio", formula: "NaCl", tipo: Composto.SAL)
            nacl.save()
            if (nacl.hasErrors()) {
                println nacl.errors
            }
        }
        print "populando compostos -> ok"


    }
    def destroy = {
    }
}
