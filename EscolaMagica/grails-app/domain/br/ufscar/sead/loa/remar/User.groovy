package br.ufscar.sead.loa.remar

import org.springframework.security.core.GrantedAuthority

class User {

    transient springSecurityService

    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    String email
    String camunda_id
    String name
    String facebookId
    String gender


    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true, nullable: false
        password blank: false, nullable: false
        name blank: false
        email blank: false, email: true, unique: true
        camunda_id nullable: true
        facebookId nullable: true
    }

    static mapping = {
        password column: '`password`'
        datasource 'remar'
        tablePerHierarchy false
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role }
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

    HashSet<GrantedAuthority> test() {
        def roles = UserRole.findAllByUser(this).collect { it.role }
        def auths = new HashSet<GrantedAuthority>()
        roles.each { role ->
            def auth = new GrantedAuthority() {

                @Override
                String getAuthority() {
                    return role.authority
                }
            }
            auths.add(auth)

        } as Set<Role>
        return auths
    }

}
