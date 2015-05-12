package br.ufscar.sead.loa.quiforca.remar

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils


@Secured(['ROLE_PROF'])
class RefactorController {

    def index() { }

    def web() {

        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
	println userId
        render "/forca/data/$userId/game"
    }

    def apk () {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def userFolder = rootPath + "/data/$userId"

        "chmod +x $rootPath/scripts/publish_android.sh".execute().waitFor()

        "$rootPath/scripts/publish_android.sh $rootPath br.ufscar.sead.loa.forca $userFolder/game/manifest.json $userFolder/bin".execute().waitFor()

        render "/forca/data/$userId/bin/forca_android.zip"
    }
}
