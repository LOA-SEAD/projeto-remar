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
	String firstName
	String lastName
    String facebookId
    String moodleUsername
	String gender


	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true, nullable: false
		password blank: false, nullable: false
		firstName blank: false
		lastName blank: true
		email blank: false, email: true, unique: true
		camunda_id nullable: true
        facebookId nullable: true
        moodleUsername nullable: true
		gender blank: false

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

}
