package br.ufscar.sead.loa.mathjong.remar

import grails.transaction.Transactional
import org.camunda.bpm.engine.runtime.Execution
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils

@Transactional
class RefactorService {

    def serviceMethod(Execution execution) {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def sourceFodler = "$rootPath/data/source"
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def userFolder = rootPath + "/data/$userId"

        "cp -R $sourceFodler/ $userFolder/game".execute().waitFor() // TODO: copy only on first user exec

        "cp -R $userFolder/fases.json $userFolder/game/MathJong/json/fases.json".execute().waitFor()
    }
}
