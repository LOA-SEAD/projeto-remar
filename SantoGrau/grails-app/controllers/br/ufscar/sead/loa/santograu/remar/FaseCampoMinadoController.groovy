package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseCampoMinadoController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        def list = QuestionFaseCampoMinado.findAllByOwnerId(session.user.id)
        if(list.size()==0){
            new QuestionFaseCampoMinado(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseCampoMinado(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseCampoMinado.findAllByOwnerId(session.user.id)
        respond list, model: [faseCampoMinadoInstanceCount: QuestionFaseCampoMinado.count()]
    }

    def show(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        respond questionFaseCampoMinadoInstance
    }

    def create() {
        respond new QuestionFaseCampoMinado(params)
    }

    @Transactional
    def save(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        if (questionFaseCampoMinadoInstance == null) {
            notFound()
            return
        }

        questionFaseCampoMinadoInstance.answers[0]= params.answers1
        questionFaseCampoMinadoInstance.answers[1]= params.answers2
        questionFaseCampoMinadoInstance.answers[2]= params.answers3
        questionFaseCampoMinadoInstance.answers[3]= params.answers4
        questionFaseCampoMinadoInstance.answers[4]= params.answers5
        questionFaseCampoMinadoInstance.ownerId = session.user.id as long
        questionFaseCampoMinadoInstance.taskId = session.taskId as String
        questionFaseCampoMinadoInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {
        respond questionFaseCampoMinadoInstance
    }

    @Transactional
    def update() {
        QuestionFaseCampoMinado questionFaseCampoMinadoInstance = QuestionFaseCampoMinado.findById(Integer.parseInt(params.faseCampoMinadoID))
        questionFaseCampoMinadoInstance.title = params.title
        questionFaseCampoMinadoInstance.answers[0]= params.answers1
        questionFaseCampoMinadoInstance.answers[1]= params.answers2
        questionFaseCampoMinadoInstance.answers[2]= params.answers3
        questionFaseCampoMinadoInstance.answers[3]= params.answers4
        questionFaseCampoMinadoInstance.answers[4]= params.answers5
        questionFaseCampoMinadoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseCampoMinadoInstance.ownerId = session.user.id as long
        questionFaseCampoMinadoInstance.taskId = session.taskId as String
        questionFaseCampoMinadoInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseCampoMinado questionFaseCampoMinadoInstance) {

        if (questionFaseCampoMinadoInstance == null) {
            notFound()
            return
        }

        questionFaseCampoMinadoInstance.delete flush:true
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseCampoMinado.label', default: 'QuestionFaseCampoMinado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseCampoMinado questionFaseCampoMinadoInstance){
        if (questionFaseCampoMinadoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseCampoMinadoInstance.title + "%@!" +
                    questionFaseCampoMinadoInstance.answers[0] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[1] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[2] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[3] + "%@!" +
                    questionFaseCampoMinadoInstance.answers[4] + "%@!" +
                    questionFaseCampoMinadoInstance.correctAnswer + "%@!" +
                    questionFaseCampoMinadoInstance.id
        }

    }
}
