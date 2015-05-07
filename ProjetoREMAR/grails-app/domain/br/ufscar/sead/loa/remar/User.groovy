package br.ufscar.sead.loa.remar

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

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		name blank: false
		email blank: false, email: true
		camunda_id nullable: true
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
		return name
	}

	String getRoles() {
		String s = "-"
		getAuthorities().each {
			if (s == "-") {
				s = it.toString()
			}
			else {
				s += ", " + it.toString()
			}
		}

		s
	}

	boolean isAdmin() {
		def found = false
		getAuthorities().each {
			if (it.authority == "ROLE_ADMIN") {
				found = true;
			}
		}
		found
	}

	boolean isProf() {
		def found = false
		getAuthorities().each {
			if (it.authority == "ROLE_PROF") {
				found = true
			}
		}
		found
	}

	boolean isStud() {
		def found = false
		getAuthorities().each {
			if (it.authority == "ROLE_STUD") {
				found = true
			}
		}
		found
	}

	boolean isEditor() {
		def found = false
		getAuthorities().each {
			if (it.authority == "ROLE_EDITOR") {
				found = true
			}
		}
		found
	}
}
