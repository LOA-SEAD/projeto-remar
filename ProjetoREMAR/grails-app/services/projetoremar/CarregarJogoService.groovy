package projetoremar

import grails.transaction.Transactional

import java.util.logging.Logger

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.runtime.Execution

@Transactional
class CarregarJogoService {
	
	RuntimeService runtimeService

	static Logger logger = Logger.getLogger(CarregarJogoService.name)

    def serviceMethod(Execution execution) {
		
		String nomeJogoGit = "quiforca" //Passar por paramêtro
		String nomeJogo = "QuiForca"	//Passar por paramêtro

		String script = "scripts/ScriptCarregarJogo.sh"
		String pathExternoJogo = "https://github.com/LOA-SEAD/" + nomeJogoGit + ".git"
		String pathLocal = nomeJogo + "/"

		String comando = script + " " + pathExternoJogo + " " + pathLocal

    	comando.execute()


		println "Download do Jogo Efetuado com Sucesso"
    }
}
