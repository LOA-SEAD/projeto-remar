package projetoremar

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.springframework.security.access.annotation.Secured


@Secured(['ROLE_PROF'])
class MainController {

	RuntimeService runtimeService
    
    def index() { }

    def servico1(){

		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("PersonalizarJogoProcess")
		
		session.ProcessId = processInstance.getId()
		
		//redirect(controller: "Jogo", action: "index")
    }
}
