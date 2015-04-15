package projetoremar

class Usuario{

    transient springSecurityService

    String username
    String password
    String name
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        name blank: false
    }

    static mapping = {
        password column: '`password`'

        tablePerHierarchy false
    }

    Set<Papel> getAuthorities() {
        UsuarioPapel.findAllByUsuario(this).collect { it.papel }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    String toString() {
        return username + "uehauea"
    }

    String getName() {
        return name;
    }

}
