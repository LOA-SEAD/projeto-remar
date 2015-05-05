package br.ufscar.sead.loa.escolamagica.remar

import grails.transaction.Transactional
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.JavaDelegate
import org.camunda.bpm.engine.runtime.Execution
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.model.cmmn.instance.Task
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils
import org.springframework.web.context.request.RequestContextHolder

@Transactional
class PublishAPKService{

    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService

    void serviceMethod(Execution execution){
        println "No service method"
        def session = RequestContextHolder.currentRequestAttributes().getSession()

        def dataPath = ServletContextHolder.getServletContext().getRealPath("/data")
        def userPath = new File(dataPath, "/" + session.processId)

        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        def scriptPath = ServletContextHolder.getServletContext().getRealPath("/scripts")
        def sourceFolder = new File(rootPath, "/data/$session.processId/source")

        if(sourceFolder.mkdirs()) {
            "git clone https://github.com/LOA-SEAD/escola_magica.git $sourceFolder".execute().waitFor()

            "rm -rf $sourceFolder/.git".execute().waitFor()

            "rm -rf $sourceFolder/Deploy/perguntas.xml".execute().waitFor()

        }

        //"cp -R $sourceFolder/ /game".execute().waitFor()

        "cp $userPath/perguntas.xml $sourceFolder/Deploy/perguntas.xml".execute().waitFor()

        "cp $scriptPath/manifest.json $sourceFolder/Deploy/manifest.json".execute().waitFor()

        //def userId = WebUtils.retrieveGrailsWebRequest().session.userId  QUANDO ESTIVER INTEGRADO COM O SPRING SECURITY DO REMAR

        def command = "$scriptPath/ScriptCrosswalk.sh br.ufscar.sead.loa.escolamagica.android $sourceFolder/Deploy/manifest.json $dataPath/$session.processId EscolaMagica"
        println command
        println "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+ command.execute().text

        println session.processId




    }


/*
    def serviceMethod(Execution execution) {
        println delegateExecution.currentActivityId
        println ServletContextHolder.servletContext.getAttribute("processId")
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        println session
    }
*/


}
