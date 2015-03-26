package projetoremar

import grails.transaction.Transactional

import java.util.concurrent.ExecutionException;
import java.util.logging.Logger

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.runtime.Execution
import org.camunda.bpm.engine.runtime.ProcessInstance;

@Transactional
class CarregarJogoService {
	
	RuntimeService runtimeService

	static Logger logger = Logger.getLogger(CarregarJogoService.name)
	
	String pathLocal = "";

    def serviceMethod(Execution execution) {
		
		String nomeJogoGit = "quiforca" //Passar por paramêtro
		String nomeJogo = "QuiForca"	//Passar por paramêtro
		
		HashMap<String, Object> pathServer = (HashMap) runtimeService.getVariablesLocal(execution.getProcessInstanceId()) 
		
		String script = pathServer.get("PathServer") + "Scripts/ScriptCarregarJogo.sh"
		String pathExternoJogo = "https://github.com/LOA-SEAD/" + nomeJogoGit + ".git"
		pathLocal = pathServer.get("PathServer")+ "ProjetosGitLoa/" + nomeJogo + "/" 
		
		String comando = script + " " + pathExternoJogo + " " + pathLocal
		
    	def process =   comando.execute()
		
		println "Download do Jogo Efetuado com Sucesso"
    }
}
