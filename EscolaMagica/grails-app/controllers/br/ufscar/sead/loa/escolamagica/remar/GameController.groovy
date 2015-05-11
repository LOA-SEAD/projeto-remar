package br.ufscar.sead.loa.escolamagica.remar

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.util.WebUtils

@Secured(["ROLE_PROF"])
class GameController {

    def newVersion(){


    }

    def web(){

        def userId = WebUtils.retrieveGrailsWebRequest().session.userId
        def processId = WebUtils.retrieveGrailsWebRequest().session.processId

        render "/EscolaMagica/data/$userId/NewVersions/escola_magicaVersion$processId/Deploy"

      //  render "/$userId/NewVersions/escola_magicaVersion$processId/Deploy"

    }


}
