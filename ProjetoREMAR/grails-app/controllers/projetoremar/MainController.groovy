package projetoremar

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.runtime.Execution
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.springframework.security.access.annotation.Secured


@Secured(['ROLE_PROF'])
class MainController {

	RuntimeService runtimeService
    
    def index() {
	}

    def servico1(){
		
		Map<String, Object> pathServer = new HashMap<String, Object>()
		pathServer.put("PathServer", servletContext.getRealPath("/"))
		
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("PersonalizarJogoProcess", pathServer)
		
		session.ProcessId = processInstance.getId()	

    }
}
