package br.ufscar.sead.loa.quiforca.remar

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.util.WebUtils


@Secured(['ROLE_PROF'])
class RefactorController {

    def index() { }

    def web() {

        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        render "/forca/data/$userId/web"
    }

    def apk () {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def sourceFolder = "$rootPath/data/source"
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def themeId = WebUtils.retrieveGrailsWebRequest().session.themeId
        def userFolder = rootPath + "/data/$userId"
        
        "mkdir $userFolder/android".execute().waitFor()
        "mkdir $userFolder/android/tmp".execute().waitFor()
        "mkdir $userFolder/android/apks".execute().waitFor()

        "cp -R $userFolder/web/ $userFolder/android/tmp".execute().waitFor()

        "cp $sourceFolder/crosswalk/manifest.json $userFolder/android/tmp".execute().waitFor()

        int[] sizes = [36, 48, 72, 96, 144, 192]

        for(int i=0; i<sizes.length; i++) {
            def name = "icon" + sizes[i] + ".png"
            "cp $userFolder/themes/$themeId/$name $userFolder/android/tmp/imgs/$name".execute().waitFor()
        }

        "chmod +x $rootPath/scripts/publish_android.sh".execute().waitFor()

        "$rootPath/scripts/publish_android.sh $rootPath br.ufscar.sead.loa.forca $userFolder/android/tmp/manifest.json $userFolder/android/apks".execute().waitFor()

        "rm -rf $userFolder/android/tmp".execute()

        render "/forca/data/$userId/android/apks/forca_android.zip"
    }

    def linux() {
        def rootPath = ServletContextHolder.getServletContext().getRealPath("/")
        rootPath = rootPath.substring(0, rootPath.length() -1)
        def sourceFolder = "$rootPath/data/source"
        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def themeId = WebUtils.retrieveGrailsWebRequest().session.themeId
        def userFolder = rootPath + "/data/$userId"

        "mkdir $userFolder/linux".execute().waitFor()
        "mkdir $userFolder/linux/tmp".execute().waitFor()
        "mkdir $userFolder/linux/tmp/Resources".execute().waitFor()
        "mkdir $userFolder/linux/bin".execute().waitFor()

        "cp -R $userFolder/web/ $userFolder/linux/tmp/Resources".execute().waitFor()

        "cp $sourceFolder/tide/manifest $userFolder/linux/tmp".execute().waitFor()
        "cp $sourceFolder/tide/tiapp.xml $userFolder/linux/tmp".execute().waitFor()

        "cp $userFolder/themes/$themeId/icon.png $userFolder/linux/tmp/Resources/imgs".execute().waitFor()

        "chmod +x $rootPath/scripts/publish_linux.sh".execute().waitFor()

        "$rootPath/scripts/publish_linux.sh $rootPath $userFolder/linux/tmp $userFolder/linux/bin".execute().waitFor()

        "rm -rf $userFolder/linux/tmp ".execute().waitFor()

        render "/forca/data/$userId/linux/bin/Forca.app"

    }
}
