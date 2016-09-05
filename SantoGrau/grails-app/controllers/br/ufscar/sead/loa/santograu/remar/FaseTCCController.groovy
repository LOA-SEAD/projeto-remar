package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class FaseTCCController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: "GET"]

    @Secured(['permitAll'])
    def index(Integer max) {
        session.taskId = "57c42aca9e04b91a75a80f75"
        session.user = springSecurityService.currentUser

        def list = QuestionFaseTCC.findAllByOwnerId(session.user.id)

        if(list.size()==0){
            new QuestionFaseTCC(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new QuestionFaseTCC(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = QuestionFaseTCC.findAllByOwnerId(session.user.id)
        respond list, model: [questionFaseTccInstanceCount: QuestionFaseTCC.count()]
    }

    def show(QuestionFaseTCC faseTCCInstance) {
        respond faseTCCInstance
    }

    def create() {
        respond new QuestionFaseTCC(params)
    }

    @Transactional
    def save(QuestionFaseTCC questionFaseTCCInstance) {
        if (questionFaseTCCInstance == null) {
            notFound()
            return
        }

        questionFaseTCCInstance.answers[0]= params.answers1
        questionFaseTCCInstance.answers[1]= params.answers2
        questionFaseTCCInstance.answers[2]= params.answers3
        questionFaseTCCInstance.answers[3]= params.answers4
        questionFaseTCCInstance.answers[4]= params.answers5
        questionFaseTCCInstance.ownerId = session.user.id as long
        questionFaseTCCInstance.taskId = session.taskId as String
        questionFaseTCCInstance.save flush:true

        redirect(action: "index")
    }

    def edit(QuestionFaseTCC questionFaseTCCInstance) {
        respond questionFaseTCCInstance
    }

    @Transactional
    def update() {
        QuestionFaseTCC questionFaseTCCInstance = QuestionFaseTCC.findById(Integer.parseInt(params.faseTCCID))
        questionFaseTCCInstance.title = params.title
        questionFaseTCCInstance.answers[0]= params.answers1
        questionFaseTCCInstance.answers[1]= params.answers2
        questionFaseTCCInstance.answers[2]= params.answers3
        questionFaseTCCInstance.answers[3]= params.answers4
        questionFaseTCCInstance.answers[4]= params.answers5
        questionFaseTCCInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        questionFaseTCCInstance.ownerId = session.user.id as long
        questionFaseTCCInstance.taskId = session.taskId as String
        questionFaseTCCInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(QuestionFaseTCC questionFaseTCCInstance) {

        if (questionFaseTCCInstance == null) {
            notFound()
            return
        }

        questionFaseTCCInstance.delete flush:true
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseTCC.label', default: 'QuestionFaseTCC'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(QuestionFaseTCC questionFaseTCCInstance){
        if (questionFaseTCCInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render questionFaseTCCInstance.title + "%@!" +
                    questionFaseTCCInstance.answers[0] + "%@!" +
                    questionFaseTCCInstance.answers[1] + "%@!" +
                    questionFaseTCCInstance.answers[2] + "%@!" +
                    questionFaseTCCInstance.answers[3] + "%@!" +
                    questionFaseTCCInstance.answers[4] + "%@!" +
                    questionFaseTCCInstance.correctAnswer + "%@!" +
                    questionFaseTCCInstance.id
        }

    }
}
