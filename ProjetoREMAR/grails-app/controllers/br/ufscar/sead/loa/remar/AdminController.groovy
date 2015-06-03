package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.engine.task.TaskQuery

@Secured(['ROLE_ADMIN'])
class AdminController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    TaskService taskService

    def test(){
        render "Test do Admin1"

    }

    def test2(){
        render "Test do Admin2"

    }

    def test3(){
        render "Test do Admin3"

    }


    def index() {
    	List<Task> tarefas = taskService.createTaskQuery().taskAssignee(springSecurityService.currentUser.camunda_id).list()

    	
        render view: 'index'
    }
}