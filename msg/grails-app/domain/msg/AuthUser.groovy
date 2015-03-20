package msg

class AuthUser {

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false, password: true
	}

	static mapping = {
		password column: '`password`'
        tablePerHierarchy false
	}

	Set<AuthRole> getAuthorities() {
		AuthUserAuthRole.findAllByAuthUser(this).collect { it.authRole }
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
}
