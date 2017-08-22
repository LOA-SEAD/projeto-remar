package sanjarunner_1

class Quiz {

	static constraints = {
		title (blank : false , size: 1..40)
		answers (blank : false , size: 1..40)
		correctAnswer (blank : false , size: 40)
	}
	
	String title
	String[] answers = new String[4]
	int correctAnswer
	
}
