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
        session.user = springSecurityService.currentUser //new br.ufscar.sead.loa.remar.User(username:"admin", password:"root")//

        def list = FaseCampoMinado.findAllByOwnerId(session.user.id)
        if(list.size()==0){
            new FaseCampoMinado(title: "Questão 1", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new FaseCampoMinado(title: "Questão 2", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new FaseCampoMinado(title: "Questão 3", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
            new FaseCampoMinado(title: "Questão 4", answers: ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D", "Alternativa E"], correctAnswer: 0, ownerId:  session.user.id, taskId: session.taskId).save flush: true
        }

        list = FaseCampoMinado.findAllByOwnerId(session.user.id)
        respond list, model: [faseCampoMinadoInstanceCount: FaseCampoMinado.count()]
    }

    def show(FaseCampoMinado faseCampoMinadoInstance) {
        respond faseCampoMinadoInstance
    }

    def create() {
        respond new FaseCampoMinado(params)
    }

    @Transactional
    def save(FaseCampoMinado faseCampoMinadoInstance) {
        if (faseCampoMinadoInstance == null) {
            notFound()
            return
        }

        faseCampoMinadoInstance.answers[0]= params.answers1
        faseCampoMinadoInstance.answers[1]= params.answers2
        faseCampoMinadoInstance.answers[2]= params.answers3
        faseCampoMinadoInstance.answers[3]= params.answers4
        faseCampoMinadoInstance.answers[4]= params.answers5
        faseCampoMinadoInstance.ownerId = session.user.id as long
        faseCampoMinadoInstance.taskId = session.taskId as String
        faseCampoMinadoInstance.save flush:true

        redirect(action: "index")

        /*
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'faseCampoMinado.label', default: 'FaseCampoMinado'), faseCampoMinadoInstance.id])
                redirect faseCampoMinadoInstance
            }
            '*' { respond faseCampoMinadoInstance, [status: CREATED] }
        }*/
    }

    def edit(FaseCampoMinado faseCampoMinadoInstance) {
        respond faseCampoMinadoInstance
    }

    @Transactional
    def update() {
        FaseCampoMinado faseCampoMinadoInstance = FaseCampoMinado.findById(Integer.parseInt(params.faseCampoMinadoID))
        faseCampoMinadoInstance.title = params.title
        faseCampoMinadoInstance.answers[0]= params.answers1
        faseCampoMinadoInstance.answers[1]= params.answers2
        faseCampoMinadoInstance.answers[2]= params.answers3
        faseCampoMinadoInstance.answers[3]= params.answers4
        faseCampoMinadoInstance.answers[4]= params.answers5
        faseCampoMinadoInstance.correctAnswer = Integer.parseInt(params.correctAnswer)
        faseCampoMinadoInstance.ownerId = session.user.id as long
        faseCampoMinadoInstance.taskId = session.taskId as String
        faseCampoMinadoInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(FaseCampoMinado faseCampoMinadoInstance) {

        if (faseCampoMinadoInstance == null) {
            notFound()
            return
        }

        faseCampoMinadoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseCampoMinado.label', default: 'FaseCampoMinado'), faseCampoMinadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseCampoMinado.label', default: 'FaseCampoMinado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def returnInstance(FaseCampoMinado faseCampoMinadoInstance){
        if (faseCampoMinadoInstance == null) {
            //notFound()
            render "null"
        }
        else{
            render faseCampoMinadoInstance.title + "%@!" +
                    faseCampoMinadoInstance.answers[0] + "%@!" +
                    faseCampoMinadoInstance.answers[1] + "%@!" +
                    faseCampoMinadoInstance.answers[2] + "%@!" +
                    faseCampoMinadoInstance.answers[3] + "%@!" +
                    faseCampoMinadoInstance.answers[4] + "%@!" +
                    faseCampoMinadoInstance.correctAnswer + "%@!" +
                    faseCampoMinadoInstance.id
        }

    }
}
