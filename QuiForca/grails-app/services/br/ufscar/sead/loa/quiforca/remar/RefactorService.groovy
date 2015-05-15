package br.ufscar.sead.loa.quiforca.remar

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
		def themeId = WebUtils.retrieveGrailsWebRequest().session.themeId
		def userFolder = rootPath + "/data/$userId"

		"cp -R $sourceFodler/base/. $userFolder/web".execute().waitFor() // TODO: copy only on first user exec

		"cp $userFolder/palavras.json $userFolder/web/json/palavras.json".execute().waitFor()

		"cp $userFolder/themes/$themeId/opening.png $userFolder/web/imgs/inicio.png".execute().waitFor()

		"cp $userFolder/themes/$themeId/background.png $userFolder/web/imgs/papel.png".execute().waitFor()


	}
}

