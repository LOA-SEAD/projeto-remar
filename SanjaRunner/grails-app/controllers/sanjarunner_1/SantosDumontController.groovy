package sanjarunner_1

import grails.transaction.Transactional
//import grails.plugin.springsecurity.annotation.Secured //Com defeito
import grails.util.Environment
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class SantosDumontController {

	def springSecurityService
	
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", returnInstance: "GET"]
	
	def index(Integer max) { 
				
		params.max = Math.min(max ?: 10, 100)
		respond Quiz.list(), model: [quizInstanceCount: Quiz.count(), pergaminhoInstanceList: Pergaminho.list(), quizInstanceCount: Pergaminho.count(), errorImportQuestions:params.errorImportQuestions]
	}
	
	def showQuiz(Quiz quizInstance) {
		respond quizInstance
	}
	
	def showPergaminho(Pergaminho pergaminhoInstance) {
		respond pergaminhoInstance
	}
	
	def createPergaminho() {
		respond new Pergaminho(params)
	}
	
	def createQuiz() {
		respond new Quiz(params)
	}
	
	@Transactional
	def saveQuiz(Quiz quizInstance) {
		if (quizInstance == null) {
			notFound()
			return
		}

		if (quizInstance.hasErrors()) {
			respond quizInstance.errors, view:'createQuiz'
			return
		}

		quizInstance.answers[0]= params.answers1
		quizInstance.answers[1]= params.answers2
		quizInstance.answers[2]= params.answers3
		quizInstance.answers[3]= params.answers4
		quizInstance.save flush:true
		
		redirect(action: "index")
	}
	
	@Transactional
	def savePergaminho(Pergaminho pergaminhoInstance) {
		if (pergaminhoInstance == null) {
			notFound()
			return
		}
				println pergaminhoInstance

		if (pergaminhoInstance.hasErrors()) {
			respond pergaminhoInstance.errors, view:'createPergaminho'
			return
		}

		pergaminhoInstance.title= params.title
		
		pergaminhoInstance.save flush:true
		
		redirect(action: "index")
	}
	
	
	def editQuiz(Quiz quizInstance) {
		respond quizInstance
	}
	def editPergaminho(Pergaminho pergaminhoInstance) {
		respond pergaminhoInstance
	}
	
	@Transactional
	def updateQuiz() {
		Quiz quizInstance/* = Quiz.findById(Integer.parseInt(params.title))*/
		quizInstance.title = params.title
		quizInstance.answers[0]= params.answers1
		quizInstance.answers[1]= params.answers2
		quizInstance.answers[2]= params.answers3
		quizInstance.answers[3]= params.answers4
		quizInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
		quizInstance.save flush:true

		redirect action: "index"
	}
	@Transactional
	def updatePergaminho() {
		Pergaminho pergaminhoInstance = Pergaminho.findById(Integer.parseInt(params.faseSantosPergaminhoID))
		pergaminhoInstance.title = params.title
		//pergaminhoInstance.ownerId = session.	.id as long
		//pergaminhoInstance.taskId = session.taskId as String
		pergaminhoInstance.save flush:true

		redirect action: "index"
	}
	
	@Transactional
    def deleteQuiz(Quiz quizInstance) {

        if (quizInstance == null) {
            notFound()
            return
        }

        quizInstance.delete flush:true
        redirect action: "index"
	}	
	@Transactional
	def deletePergaminho(Pergaminho pergaminhoInstance) {

		if (pergaminhoInstance == null) {
			notFound()
			return
		}

		pergaminhoInstance.delete flush:true
		redirect action: "index"
	}
	
	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseSantos.label', default: 'QuizSantos'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
	
	def returnInstanceQuiz(Quiz quizInstance){
		if (quizInstance == null) {
			//notFound()
			render "null"
		}
		else{
			render quizInstance.title + "%@!" +
					quizInstance.answers[0] + "%@!" +
					quizInstance.answers[1] + "%@!" +
					quizInstance.answers[2] + "%@!" +
					quizInstance.answers[3] + "%@!" +
					quizInstance.correctAnswer + "%@!" +
					quizInstance.id
		}

	}
	def returnInstancePergaminho(Pergaminho pergaminhoInstance){
		if (pergaminhoInstance == null) {
			//notFound()
			render "null"
		}
		else{
			render pergaminhoInstance.title + "%@!" +
					pergaminhoInstance.id
		}

	}
	
}
