package br.ufscar.sead.loa.mathjong.remar

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils


@Secured(['ROLE_PROF'])
class RefactorController {

    def index() {}

    def web() {

        def userId = WebUtils.retrieveGrailsWebRequest().session.userId

        render "/mathjong/data/$userId/game"
    }

    def apk() {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def userFolder = rootPath + "/data/$userId"

        "chmod +x $rootPath/scripts/publish_android.sh".execute().waitFor()

        "$rootPath/scripts/publish_android.sh $rootPath br.ufscar.sead.loa.mathjong $userFolder/game/manifest.json $userFolder/bin".execute().waitFor()

        render "/mathjong/data/$userId/bin/mathjong_android.zip"
    }
}
