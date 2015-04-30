package br.ufscar.sead.loa.quiforca.remar

import grails.transaction.Transactional
import org.camunda.bpm.engine.runtime.Execution
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils

@Transactional
class RefactorService {

    def serviceMethod(Execution execution) {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        def sourceFodler = new File(rootPath, "/data/source")
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def themeId = WebUtils.retrieveGrailsWebRequest().session.themeId
        def userFolder = rootPath + "data/$userId"

        if(sourceFodler.mkdirs()) {
            "git clone https://github.com/LOA-SEAD/quiforca.git $sourceFodler".execute().waitFor()

            "rm -rf $sourceFodler/.git".execute().waitFor()

            "rm -rf $sourceFodler/json/palavras.json".execute().waitFor()

            "rm -rf $sourceFodler/imgs/inicio.png".execute().waitFor()

            "rm -rf $sourceFodler/imgs/papel.png".execute().waitFor()
        }

        "cp -R $sourceFodler/ $userFolder/game".execute().waitFor()

        "cp $userFolder/configuracao.json $userFolder/game/json/configuracao.json".execute().waitFor()

        println "cp $userFolder/palavras.json $userFolder/game/json/palavras.json"

        "cp $userFolder/themes/$themeId/opening.png $userFolder/game/imgs/inicio.png".execute().waitFor()

        "cp $userFolder/themes/$themeId/background.png $userFolder/game/imgs/papel.png".execute().waitFor()

    }
}
