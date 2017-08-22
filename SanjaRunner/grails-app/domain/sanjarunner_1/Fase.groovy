package sanjarunner_1

class Fase {

    static constraints = {
		nameFase (blank : false , size: 1..40)
		idFase (blank : false , size: 1..40)
    }
	
	String nameFase
	int idFase
}
