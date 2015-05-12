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
        if(processoJogoInstance){
            if(springSecurityService.currentUser == processoJogoInstance.professor){
                render view:'show', model:[processoJogoInstance: processoJogoInstance]
            }
            else{
                flash.message = "Você não tem acesso a esse processo"
                redirect action: 'index'
            }
        }
        else{
            flash.message = "Esse processo não existe"
            redirect action: 'index'
        }
            
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
        if(processoJogoInstance){
            if(springSecurityService.currentUser == processoJogoInstance.professor){
                // lista as tarefas ativas e seta para um usuário
                List<Task> tasks = taskService.createTaskQuery().processInstanceId(processoJogoInstance.id_process_instance).list()
                for(int i = tasks.size()-1; i >= 0; i--){
                    if(tasks.get(i).getAssignee() != null){
                        tasks.remove(i);
                    }
                }

                List<User> usuarios = User.list()

                
                if(tasks.size == 0){
                    flash.message = "Não existe atualmente tarefas a serem alocadas desse processo"
                    redirect action:"index"
                }
                else{
                    render view:'tarefas', model:[tarefas:tasks, usuarios: usuarios]
                }
            }
            else{
                flash.message = "Você não tem acesso a esse processo"
                redirect action: 'index'    
            }
        }
        else{
            flash.message = "Esse processo não existe"
            redirect action: 'index'
        }
    }

    def vincular_tarefas(){
        /*
        if(params['task_id[]'] != null){
            if(params['task_id[]'] instanceof String){
                String user_id  = params['user_id[]']
                String task_id = params['task_id[]']

                String uid = user_id
                if(uid){
                    taskService.delegateTask(task_id, uid)
                }

            }
            else{
                String [] user_ids = params['user_id[]']
                String [] tasks_ids = params['task_id[]']

                for(int i = 0; i < user_ids.length; i++){
                    String uid = user_ids[i]
                    if(uid){
                        taskService.delegateTask(tasks_ids[i], uid)
                    }
                }
            }
        }
        */

        print params['user_id[]']

        redirect action: "index"
    }

    def iniciar_desenvolvimento(String id){
        ProcessInstance createdProcess = runtimeService.startProcessInstanceById(id)
        def professorJogo = new ProcessoJogo(professor: springSecurityService.currentUser, id_process_definition: createdProcess.getProcessDefinitionId(), id_process_instance: createdProcess.getProcessInstanceId()).save flush:true

        if(professorJogo.hasErrors()){

        }
        else{
            redirect action: "tarefas", id: professorJogo.id
        }
    }

    @Transactional
    def delete(ProcessoJogo processoJogoInstance) {

        if (processoJogoInstance == null) {
            notFound()
            return
        }

        if(springSecurityService.currentUser == processoJogoInstance.professor){
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
        else{
            flash.message = "Você não tem acesso a esse processo"
            redirect action: 'index'    
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
