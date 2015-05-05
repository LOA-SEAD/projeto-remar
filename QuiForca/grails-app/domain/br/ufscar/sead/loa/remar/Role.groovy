package br.ufscar.sead.loa.remar

class Role {

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}

	String toString() {
		String s = ""
		if(authority == "ROLE_ADMIN") {
			s += "Admin"
		}
		else if (authority == "ROLE_PROF") {
			s += "Professor"
		}
		else if (authority == "ROLE_STUD") {
			s += "Student"
		}
	}
}
