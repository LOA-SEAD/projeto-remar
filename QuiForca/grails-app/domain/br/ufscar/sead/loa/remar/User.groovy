package br.ufscar.sead.loa.remar

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    String firstName
    String lastName

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
        firstName blank: false
        lastName blank: false
	}

	static mapping = {
		password column: '`password`'

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

    String getName() {
        return firstName + " " + lastName
    }

    String toString() {
        String s = "Name: " + getName() + "\n";
        s += "Username: " + getUsername() + "\n"
        s += "Roles: "

        getAuthorities().each {
           s += it.authority + " "
        }
        s += "\n"
    }
}
