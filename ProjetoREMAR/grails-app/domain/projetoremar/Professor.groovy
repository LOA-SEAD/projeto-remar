package projetoremar

class Professor extends Usuario {

    static constraints = {
	username(blank: false, unique: true)
	password(password: true, blank: false)
    }

    String nome
}
