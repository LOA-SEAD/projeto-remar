package msg

import org.apache.commons.lang.builder.HashCodeBuilder

class AuthUserAuthRole implements Serializable {

	private static final long serialVersionUID = 1

	AuthUser authUser
	AuthRole authRole

	boolean equals(other) {
		if (!(other instanceof AuthUserAuthRole)) {
			return false
		}

		other.authUser?.id == authUser?.id &&
		other.authRole?.id == authRole?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (authUser) builder.append(authUser.id)
		if (authRole) builder.append(authRole.id)
		builder.toHashCode()
	}

	static AuthUserAuthRole get(long authUserId, long authRoleId) {
		AuthUserAuthRole.where {
			authUser == AuthUser.load(authUserId) &&
			authRole == AuthRole.load(authRoleId)
		}.get()
	}

	static boolean exists(long authUserId, long authRoleId) {
		AuthUserAuthRole.where {
			authUser == AuthUser.load(authUserId) &&
			authRole == AuthRole.load(authRoleId)
		}.count() > 0
	}

	static AuthUserAuthRole create(AuthUser authUser, AuthRole authRole, boolean flush = false) {
		def instance = new AuthUserAuthRole(authUser: authUser, authRole: authRole)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(AuthUser u, AuthRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = AuthUserAuthRole.where {
			authUser == AuthUser.load(u.id) &&
			authRole == AuthRole.load(r.id)
		}.deleteAll()

		if (flush) { AuthUserAuthRole.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(AuthUser u, boolean flush = false) {
		if (u == null) return

		AuthUserAuthRole.where {
			authUser == AuthUser.load(u.id)
		}.deleteAll()

		if (flush) { AuthUserAuthRole.withSession { it.flush() } }
	}

	static void removeAll(AuthRole r, boolean flush = false) {
		if (r == null) return

		AuthUserAuthRole.where {
			authRole == AuthRole.load(r.id)
		}.deleteAll()

		if (flush) { AuthUserAuthRole.withSession { it.flush() } }
	}

	static constraints = {
		authRole validator: { AuthRole r, AuthUserAuthRole ur ->
			if (ur.authUser == null) return
			boolean existing = false
			AuthUserAuthRole.withNewSession {
				existing = AuthUserAuthRole.exists(ur.authUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['authRole', 'authUser']
		version false
	}
}
