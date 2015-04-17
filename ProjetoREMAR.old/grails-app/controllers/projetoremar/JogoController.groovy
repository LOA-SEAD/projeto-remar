package projetoremar



import static org.springframework.http.HttpStatus.*

import javax.persistence.Convert;

import grails.transaction.Transactional

import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.runtime.ActivityInstance
import org.camunda.bpm.engine.runtime.Execution
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.engine.*
import org.springframework.security.access.annotation.Secured

@Transactional(readOnly = true)
@Secured(['ROLE_PROF'])
class JogoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	RuntimeService runtimeService
	TaskService taskService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)	
		
		
        respond Jogo.list(params), model:[jogoInstanceCount: Jogo.count()]
    }

    def show(Jogo jogoInstance) {
        respond jogoInstance
    }

    def create() {
        respond new Jogo(params)
    }

    @Transactional
    def save(Jogo jogoInstance) {
        if (jogoInstance == null) {
            notFound()
            return
        }

        if (jogoInstance.hasErrors()) {
            respond jogoInstance.errors, view:'create'
            return
        }

        jogoInstance.save flush:true
		
		atribuirVariaveis()
		
		println "JOGO CRIADO" + " " + session.ProcessId
		
		Task task = taskService.createTaskQuery().processInstanceId(session.ProcessId).taskDefinitionKey("AlterarJogo").singleResult()
		 
		
		taskService.complete(task.id)
		
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'jogo.label', default: 'Jogo'), jogoInstance.id])
                redirect jogoInstance
            }
            '*' { respond jogoInstance, [status: CREATED] }
        }
    }

    def edit(Jogo jogoInstance) {
        respond jogoInstance
    }

    @Transactional
    def update(Jogo jogoInstance) {
        if (jogoInstance == null) {
            notFound()
            return
        }

        if (jogoInstance.hasErrors()) {
            respond jogoInstance.errors, view:'edit'
            return
        }

        jogoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Jogo.label', default: 'Jogo'), jogoInstance.id])
                redirect jogoInstance
            }
            '*'{ respond jogoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Jogo jogoInstance) {

        if (jogoInstance == null) {
            notFound()
            return
        }

        jogoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Jogo.label', default: 'Jogo'), jogoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	protected void atribuirVariaveis(){
		Execution execution = (Execution) runtimeService.createExecutionQuery().processInstanceId(session.ProcessId).list().first()
		
		runtimeService.setVariable(execution.getId(), "nome", params.nome)
		runtimeService.setVariable(execution.getId(), "categoria", params.categoria)
		runtimeService.setVariable(execution.getId(), "palavra", params.palavra)
		runtimeService.setVariable(execution.getId(), "tela_inicial", params.tela_inicial)
		runtimeService.setVariable(execution.getId(), "tela_jogo", params.tela_jogo)
		runtimeService.setVariable(execution.getId(), "icone", params.icone)

	}
	

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'jogo.label', default: 'Jogo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	
}
