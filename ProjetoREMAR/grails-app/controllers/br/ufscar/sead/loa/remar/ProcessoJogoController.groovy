package br.ufscar.sead.loa.remar



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.repository.ProcessDefinition
import org.camunda.bpm.engine.repository.ProcessDefinitionQuery
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.task.Task
import org.camunda.bpm.engine.task.TaskQuery
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_PROF'])
class ProcessoJogoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    RuntimeService runtimeService
    RepositoryService repositoryService
    ProcessInstance processInstance
    TaskService taskService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def processosJogos = ProcessoJogo.findAllByProfessor(springSecurityService.currentUser)
        render view:'index', model:[processoJogoInstanceList: processosJogos, processoJogoInstanceCount: processosJogos.size()]
    }

    def show(ProcessoJogo processoJogoInstance) {
        print processoJogoInstance
        render view:'show', model:[processoJogoInstance: processoJogoInstance]
    }

    def jogos(){
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
        
        List<ProcessDefinition> processesDefinition = processDefinitionQuery.active().list();
        
        String [][] jogos = new String[processesDefinition.size()][2];

        for(int i = 0; i < processesDefinition.size(); i++){
            ProcessDefinition p = processesDefinition.get(i)
            jogos[i][0] = p.getId()
            jogos[i][1] = p.getName()
        }

        render view:'jogos', model:[jogos: jogos]
    }

    def tarefas(ProcessoJogo processoJogoInstance){
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(processoJogoInstance.id_process_instance).list()
        List<User> usuarios = User.list()

        render view:'tarefas', model:[tarefas:tasks, usuarios: usuarios]
    }

    def iniciar_desenvolvimento(String id){
        ProcessInstance createdProcess = runtimeService.startProcessInstanceById(id)
        def professorJogo = new ProcessoJogo(professor: springSecurityService.currentUser, id_process_definition: createdProcess.getProcessDefinitionId(), id_process_instance: createdProcess.getProcessInstanceId()).save flush:true

        if(professorJogo.hasErrors()){

        }
        else{
            //redirect action: "tasks"
            redirect action: "index"
        }
    }

    @Transactional
    def delete(ProcessoJogo processoJogoInstance) {

        if (processoJogoInstance == null) {
            notFound()
            return
        }

        runtimeService.deleteProcessInstance(processoJogoInstance.id_process_instance, "Professor removendo jogo")

        processoJogoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ProcessoJogo.label', default: 'ProcessoJogo'), processoJogoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'processoJogo.label', default: 'ProcessoJogo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
