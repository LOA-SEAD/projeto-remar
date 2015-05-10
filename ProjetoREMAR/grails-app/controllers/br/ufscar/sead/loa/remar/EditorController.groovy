package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.engine.task.TaskQuery

@Secured(['ROLE_EDITOR'])
class EditorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    TaskService taskService

    def index() {
    	List<Task> tarefas = taskService.createTaskQuery().taskAssignee(springSecurityService.currentUser.camunda_id).list()

    	print tarefas
    	
        render view: 'index'
    }
}