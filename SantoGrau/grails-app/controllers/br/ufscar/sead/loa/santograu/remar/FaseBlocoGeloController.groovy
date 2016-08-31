package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseBlocoGeloController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        def list = QuestionFaseBlocoGelo.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuestionFaseBlocoGelo(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseBlocoGelo(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseBlocoGelo.findAllByOwnerId(session.user.id)
        respond list, model: [faseBlocoGeloInstanceCount: QuestionFaseBlocoGelo.count()]
    }

    def show(QuestionFaseBlocoGelo faseBlocoGeloInstance) {
        respond faseBlocoGeloInstance
    }

    def create() {
        respond new QuestionFaseBlocoGelo(params)
    }

    @Transactional
    def save(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance) {
        if (questionFaseBlocoGeloInstance == null) {
            notFound()
            return
        }

        questionFaseBlocoGeloInstance.answers[0]= params.answers1
        questionFaseBlocoGeloInstance.answers[1]= params.answers2
        questionFaseBlocoGeloInstance.answers[2]= params.answers3
        questionFaseBlocoGeloInstance.ownerId = session.user.id as long
        questionFaseBlocoGeloInstance.taskId = session.taskId as String
        questionFaseBlocoGeloInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseBlocoGelo faseBlocoGeloInstance) {
        respond faseBlocoGeloInstance
    }

    @Transactional
    def update() {
        QuestionFaseBlocoGelo questionFaseBlocoGeloInstance = QuestionFaseBlocoGelo.findById(Integer.parseInt(params.faseBlocoGeloID))
        questionFaseBlocoGeloInstance.title = params.title
        questionFaseBlocoGeloInstance.answers[0]= params.answers1
        questionFaseBlocoGeloInstance.answers[1]= params.answers2
        questionFaseBlocoGeloInstance.answers[2]= params.answers3
        questionFaseBlocoGeloInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseBlocoGeloInstance.ownerId = session.user.id as long
        questionFaseBlocoGeloInstance.taskId = session.taskId as String
        questionFaseBlocoGeloInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance) {

        if (questionFaseBlocoGeloInstance == null) {
            notFound()
            return
        }

        questionFaseBlocoGeloInstance.delete flush:true
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseBlocoGelo.label', default: 'QuestionFaseBlocoGelo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseBlocoGelo questionFaseBlocoGeloInstance){
        if (questionFaseBlocoGeloInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseBlocoGeloInstance.title + "%@!" +
                    questionFaseBlocoGeloInstance.answers[0] + "%@!" +
                    questionFaseBlocoGeloInstance.answers[1] + "%@!" +
                    questionFaseBlocoGeloInstance.answers[2] + "%@!" +
                    questionFaseBlocoGeloInstance.correctAnswer + "%@!" +
                    questionFaseBlocoGeloInstance.id
        }

    }
}
