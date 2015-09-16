package br.ufscar.sead.loa.mathjong.remar

import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.web.json.JSONArray

@Secured(["IS_AUTHENTICATED_FULLY"])
class MathController {

    def springSecurityService

    def index() {

    }

    def save() {

        def nCols = params.int "nCols"
        def nLines = params.int "nLines"
        def _time = nCols * nLines * 15
        def latex = params.list "latex[]"

        def _data = []
        def k = 0

        def builder = new JsonBuilder()

        nLines.times {
            def line = []
            nCols.times {
                line.add "\$\$" + latex[k++] + "\$\$"
            }
            _data.add line
        }


        builder {
            linha nLines
            coluna nCols
            time _time
            data _data
        }

        render builder.toString()
        println builder.toString()


        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId())
        userPath.mkdirs()

        def fileName = "fases.json"
        def file = new File("$userPath/$fileName")
        def finished = new File("$dataPath/${springSecurityService.getCurrentUser().getId()}/finished.txt")

        if(finished.exists()) { // if there's a finished fases.json
            println "finished"
            file.delete()
            file.createNewFile()
            file.append("[")
            session.newLevel = false
            finished.delete()
        } else if(file.createNewFile()) { // if !there's a fases.json
            println "new"
            file.append("[")
        }

        file.append(builder.toString() + ",")
    }

    def finish() {
        def dataPath = servletContext.getRealPath("/data")
        def file = new File("$dataPath/${springSecurityService.getCurrentUser().getId()}/fases.json")
        def json = file.text
        json = json.substring(0, json.length() -1)
        json += "]"
        file.write(json)

        def finished = new File("$dataPath/${springSecurityService.getCurrentUser().getId()}/finished.txt")
        finished.createNewFile()

        forward controller: "process", action: "complete", id: "math"
    }
}