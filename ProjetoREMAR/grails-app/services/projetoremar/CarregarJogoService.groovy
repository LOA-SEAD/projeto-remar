package projetoremar

import grails.transaction.Transactional
import org.apache.http.HttpHeaders
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpUriRequest
import org.apache.http.client.methods.RequestBuilder
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.impl.client.HttpClients

import java.util.logging.Logger

import org.camunda.bpm.engine.*
import org.camunda.bpm.engine.runtime.Execution

@Transactional
class CarregarJogoService {
	
	RuntimeService runtimeService

	static Logger logger = Logger.getLogger(CarregarJogoService.name)

    def serviceMethod(Execution execution) {

        HttpClient client = HttpClients.custom().build();
        HttpUriRequest request = RequestBuilder.get().setUri("https://api.parse.com/1/classes/Games")
                .setHeader("X-Parse-Application-Id", "BLZ9HshacKh7i50AEhUl7ONucq9nlZxstCtTPtd1")
                .setHeader("X-Parse-REST-API-Key", "ZPESbYPx0q0SY8FOEVnkfZZeDLkiorgHfXz9Bfx6").build();
        println request.getAllHeaders().toString()
        HttpResponse response = client.execute(request);

        println new Scanner(response.getEntity().getContent(), "UTF-8").useDelimiter("\\A").next()


//		String nomeJogoGit = "quiforca" //Passar por paramêtro
//		String nomeJogo = "QuiForca"	//Passar por paramêtro
//
//		String script = "scripts/ScriptCarregarJogo.sh"
//		String pathExternoJogo = "https://github.com/LOA-SEAD/" + nomeJogoGit + ".git"
//		String pathLocal = nomeJogo + "/"
//
//		String comando = script + " " + pathExternoJogo + " " + pathLocal
//
//    	comando.execute()
//
//
//		println "Download do Jogo Efetuado com Sucesso"
    }
}
