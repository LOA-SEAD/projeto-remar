package br.ufscar.sead.loa.mathjong.remar

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils


@Secured(['ROLE_PROF'])
class RefactorController {

    def index() {}

    def web() {

        def userId = WebUtils.retrieveGrailsWebRequest().session.userId

        render "/mathjong/data/$userId/web"
    }

    def apk() {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def sourceFolder = "$rootPath/data/source"
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def userFolder = rootPath + "/data/$userId"

        "mkdir $userFolder/android".execute().waitFor()
        "mkdir $userFolder/android/tmp".execute().waitFor()
        "mkdir $userFolder/android/apks".execute().waitFor()

        "cp -R $userFolder/web/. $userFolder/android/tmp".execute().waitFor()

        "cp $sourceFolder/crosswalk/manifest.json $userFolder/android/tmp/manifest.json".execute().waitFor()

        "chmod +x $rootPath/scripts/publish_android.sh".execute().waitFor()

        "$rootPath/scripts/publish_android.sh $rootPath br.ufscar.sead.loa.mathjong $userFolder/android/tmp/manifest.json $userFolder/android/apks".execute().waitFor()

        "rm -rf $userFolder/android/tmp".execute()

        render "/mathjong/data/$userId/android/apks/mathjong_android.zip"
    }

    def linux() {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def sourceFolder = "$rootPath/data/source"
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def userFolder = rootPath + "/data/$userId"

        "mkdir $userFolder/linux".execute().waitFor()
        "mkdir $userFolder/linux/tmp".execute().waitFor()
        "mkdir $userFolder/linux/tmp/Resources".execute().waitFor()
        "mkdir $userFolder/linux/bin".execute().waitFor()

        "cp -R $userFolder/web/. $userFolder/linux/tmp/Resources".execute().waitFor()

        "cp $sourceFolder/tide/manifest $userFolder/linux/tmp/manifest".execute().waitFor()
        "cp $sourceFolder/tide/tiapp.xml $userFolder/linux/tmp/tiapp.xml".execute().waitFor()

        "chmod +x $rootPath/scripts/publish_linux.sh".execute().waitFor()

        "$rootPath/scripts/publish_linux.sh $rootPath $userFolder/linux/tmp $userFolder/linux/bin".execute().waitFor()

        "rm -rf $userFolder/linux/tmp ".execute().waitFor()

        render "/mathjong/data/$userId/linux/bin/MathJong.app"
    }
}
