package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.engine.task.TaskQuery

@Secured(['ROLE_PROF'])
class ProfessorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    TaskService taskService

    def index() {

    	List<Task> tarefasCandidatas = taskService.createTaskQuery().taskCandidateUser(springSecurityService.currentUser.camunda_id).list()
    	List<Task> tarefasDoUsuario = taskService.createTaskQuery().taskAssignee(springSecurityService.currentUser.camunda_id).list()

    	render view: 'index', model:[tarefasCandidatas: tarefasCandidatas, tarefasDoUsuario: tarefasDoUsuario]
    }

    def tarefa (String id){
        Task findTask = taskService.createTaskQuery().taskId(id).singleResult()
        if(findTask != null){
            if(springSecurityService.currentUser.camunda_id == findTask.getOwner()){
                render view: 'tarefa', model:[tarefa: findTask, usuarios: User.list()]
            }
            else{
                flash.message = "Você não tem autorização para trabalhar nessa tarefa!"
                redirect action: 'index'
            }
        }
        else{
            flash.message = "Tarefa não existe!"
            redirect action: 'index'
        }
    }

    def assumir_tarefa(String id){
        Task findTask = taskService.createTaskQuery().taskId(id).singleResult()
    	if(findTask != null){
            if(springSecurityService.currentUser.camunda_id == findTask.getOwner()){
                taskService.claim(id, springSecurityService.currentUser.camunda_id)
                flash.message = "Tarefa assumida com sucesso!"
            }
            else{
                flash.message = "Você não tem autorização para trabalhar nessa tarefa!"
            }
    	}
    	else{
    		flash.message = "Tarefa não existe!"
    	}

    	redirect action: 'index'
    }

    def delegar_tarefa(){
        def user_id = params['user_id']
        def task_id = params['task_id']

        if(user_id != null && task_id != null){
            Task findTask = taskService.createTaskQuery().taskId(task_id).singleResult()
            if(findTask != null){
                if(springSecurityService.currentUser.camunda_id == findTask.getOwner()){
                    taskService.delegateTask(task_id, user_id)
                    flash.message = "Tarefa delegada com sucesso!"
                }
                else{
                    flash.message = "Você não tem autorização para trabalhar nessa tarefa!"
                }
            }
            else{
                flash.message = "Tarefa não existe!"
            }
        }
        else{
            flash.message = "Usuário ou tarefa não existem"
        }

        redirect action: 'index'
    }
}