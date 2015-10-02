package br.ufscar.sead.loa.remar

import grails.transaction.Transactional
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.runtime.Execution
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.context.request.RequestContextHolder


@Transactional
class GenerateGameService {

    def serviceMethod(Execution execution) {


        log.debug "No service method"
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        def dataPath = ServletContextHolder.getServletContext().getRealPath("/data")
        def userPath = new File(dataPath, "/" + session.userId)
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        def scriptPath = ServletContextHolder.getServletContext().getRealPath("/scripts")
        def gameFolder = new File(rootPath, "/data/$session.userId/NewVersions")
        gameFolder.mkdirs()

        //  "git clone https://github.com/LOA-SEAD/escola_magica.git $sourceFolder".execute().waitFor()

        "cp -R $dataPath/escolamagica_source/escola_magica-master $gameFolder/escola_magicaVersion$session.processId".execute().waitFor() //Game copy from source to current user folder

        // "rm -rf $gameFolder/escola_magicaVersion$session.processId/Deploy/perguntas.xml".execute().waitFor() //removing the original "perguntas.xml"

        "cp $userPath/perguntas.xml $gameFolder/escola_magicaVersion$session.processId/Deploy/perguntas.xml".execute().waitFor()

        "rm $userPath/perguntas.xml".execute().waitFor()

    }
}
