package sanjarunner_1

class Pergaminho {

    static constraints = {
		title (blank : false , size: 1..40)
		
    }
	
	String title
	
	
	
	String toString()
	{
		return title
		}
}
