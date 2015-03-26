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
	def manifest
	
	def pathRootIn = ""
	def pathRootOut = ""
	
	RuntimeService runtimeService

    def serviceMethod(Execution execution) {
		
		setVariables(execution)
		
		copyFiles()
		
		publishApk()
    }
	
	def setVariables(Execution execution){
		nome = execution.getVariable("nome")
		categoria = execution.getVariable("categoria")
		palavra = execution.getVariable("palavra")
		tela_inicial = execution.getVariable("tela_inicial")
		tela_jogo = execution.getVariable("tela_jogo")
		icone = execution.getVariable("icone")
		manifest = execution.getVariable("manifest")
		
		HashMap<String, Object> pathServer = (HashMap) runtimeService.getVariablesLocal(execution.getProcessInstanceId())
		pathRootIn = pathServer.get("PathServer")+ "ProjetosGitLoa/"
		pathRootOut = pathServer.get("PathServer")+ "Publish/"
	}
	
	def copyFiles(){
		
		println "COPYING FILES"
		
		commandCopyFiles(pathRootIn, categoria, pathRootOut, nome)
		
		commandCopyFiles(palavra, "", pathRootOut, nome + "/json/palavras.json")
		
		commandCopyFiles(manifest, "", pathRootOut, nome)
		
		commandCopyFiles(icone, "", pathRootOut, nome + "/icon.png")
		
		commandCopyFiles(tela_inicial, "", pathRootOut, nome + "/imgs/inicio.png")
		
		commandCopyFiles(tela_jogo, "", pathRootOut, nome + "/imgs/papel.png")			
				
	}
	
	def commandCopyFiles(String param1, String param2, String param3, String param4){
	
		def command = "cp -r ${param1}${param2} ${param3}${param4}"
		
		println "Copy base files: ${command}"
		def proc = command.execute()
		proc.waitFor()
		println "return code: ${proc.exitValue()}"
		println "stderr: ${proc.err.text}"
		println "stdout: ${proc.in.text}"
	}
	
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
}
