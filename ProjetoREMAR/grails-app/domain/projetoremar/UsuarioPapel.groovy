package projetoremar

import org.apache.commons.lang.builder.HashCodeBuilder

class UsuarioPapel implements Serializable {

	private static final long serialVersionUID = 1

	Usuario usuario
	Papel papel

	boolean equals(other) {
		if (!(other instanceof UsuarioPapel)) {
			return false
		}

		other.usuario?.id == usuario?.id &&
		other.papel?.id == papel?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (usuario) builder.append(usuario.id)
		if (papel) builder.append(papel.id)
		builder.toHashCode()
	}

	static UsuarioPapel get(long usuarioId, long papelId) {
		UsuarioPapel.where {
			usuario == Usuario.load(usuarioId) &&
			papel == Papel.load(papelId)
		}.get()
	}

	static boolean exists(long usuarioId, long papelId) {
		UsuarioPapel.where {
			usuario == Usuario.load(usuarioId) &&
			papel == Papel.load(papelId)
		}.count() > 0
	}

	static UsuarioPapel create(Usuario usuario, Papel papel, boolean flush = false) {
		def instance = new UsuarioPapel(usuario: usuario, papel: papel)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(Usuario u, Papel r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = UsuarioPapel.where {
			usuario == Usuario.load(u.id) &&
			papel == Papel.load(r.id)
		}.deleteAll()

		if (flush) { UsuarioPapel.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(Usuario u, boolean flush = false) {
		if (u == null) return

		UsuarioPapel.where {
			usuario == Usuario.load(u.id)
		}.deleteAll()

		if (flush) { UsuarioPapel.withSession { it.flush() } }
	}

	static void removeAll(Papel r, boolean flush = false) {
		if (r == null) return

		UsuarioPapel.where {
			papel == Papel.load(r.id)
		}.deleteAll()

		if (flush) { UsuarioPapel.withSession { it.flush() } }
	}

	static constraints = {
		papel validator: { Papel r, UsuarioPapel ur ->
			if (ur.usuario == null) return
			boolean existing = false
			UsuarioPapel.withNewSession {
				existing = UsuarioPapel.exists(ur.usuario.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['papel', 'usuario']
		version false
	}
}
