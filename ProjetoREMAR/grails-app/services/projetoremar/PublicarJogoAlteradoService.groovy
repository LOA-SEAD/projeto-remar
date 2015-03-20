package projetoremar

import grails.transaction.Transactional

import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.runtime.Execution

@Transactional
class PublicarJogoAlteradoService {
	
	def nome
	def categoria
	def palavra
	def tela_inicial
	def tela_jogo
	def icone	
	
	def pathRootIn = "/home/loa/Denis/ProjetosLOA/"
	def pathRootOut = "/home/loa/Denis/ProjetosLOA/Publish"
	
	RuntimeService runtimeService

    def serviceMethod(Execution execution) {
		
		getVariables(execution)
		
		createDirectories()
		
		moveFiles()
		
	//	publishApk()
    }
	
	def getVariables(Execution execution){
		nome = execution.getVariable("nome")
		categoria = execution.getVariable("categoria")
		palavra = execution.getVariable("palavra")
		tela_inicial = execution.getVariable("tela_inicial")
		tela_jogo = execution.getVariable("tela_jogo")
		icone = execution.getVariable("icone")
	}
	
	def createDirectories(){
		
		def dirRootOut = new File(pathRootOut)
		
		if(!dirRootOut.exists()){
			println "CREATING DIRECTORY ROOT ${dirRootOut}"
			if(dirRootOut.mkdirs()){
				println "SUCESS"
			} 
			else{
				println "FAILED"
			}
		}
	}
	
	def moveFiles(){
		
		println "COPYING FILES"
		
		println "COPYING DIRECTORY"
		def command = "cp -r ${pathRootIn}${categoria} ${pathRootOut}${nome}"
		println "Copy base files: ${command}"
		def proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
		
		println "COPYING WORDS"
		command = "cp ${palavra} ${pathRootOut}${nome}/json/palavras.json"
		println "Copy palavras: ${command}"
		proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
		
		println "COPYING MANIFEST"
		command = "cp /home/loa/testeguido/manifest.json ${pathRootOut}${nome}"
		println "Copy manifest: ${command}"
		proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
		
		println "COPYING ICON"
		command = "cp ${icone} ${pathRootOut}${nome}/icon.png"
		println "Copy icone: ${command}"
		proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
		
		println "COPYING HOME SCREEN"
		command = "cp ${tela_inicial} ${pathRootOut}${nome}/imgs/inicio.png"
		println "Copy home_screen: ${command}"
		proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
		
		println "COPYING GAME SCREEN"
		command = "cp ${tela_jogo} ${pathRootOut}${nome}/imgs/papel.png"
		println "Copy game_screen: ${command}"
		proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
			
				
	}
	/*
	def publishApk(){
		
		println "PUBLISHING APK"
		
		println "CROSSWALK /home/loa/Desenvolvimento/workspace/ProjetoREMAR/scripts/ScriptCrosswalk.sh  org.loa.quiforca ${pathRootOut}${nome}/manifest.json /home/loa ${nome}"
		
		def command ="/home/loa/Desenvolvimento/workspace/ProjetoREMAR/scripts/ScriptCrosswalk.sh  org.loa.quiforca ${pathRootOut}${nome}/manifest.json /home/loa ${nome}"
		println "PUBLISHING CrossWalk: ${command}"
		def proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
	}
	*/
}
