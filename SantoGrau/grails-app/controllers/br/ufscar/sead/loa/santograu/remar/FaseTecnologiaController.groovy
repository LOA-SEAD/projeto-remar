package br.ufscar.sead.loa.santograu.remar

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.transaction.Transactional
import grails.util.Environment
import groovy.json.JsonSlurper

@Secured(["isAuthenticated()"])
class FaseTecnologiaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", exportLevel: "POST"]

    def beforeInterceptor = [action: this.&check, only: ['index', 'exportLevel']]


    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }


    @Secured(['permitAll'])
    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }

        if (params.p) {
            session.processId = params.p
        }
        respond new FaseTecnologia(params)
    }

    def show(FaseTecnologia faseTecnologiaInstance) {
        respond faseTecnologiaInstance
    }

    def create() {
        respond new FaseTecnologia(params)
    }

    @Transactional
    def save(FaseTecnologia faseTecnologiaInstance) {
        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        if (faseTecnologiaInstance.hasErrors()) {
            respond faseTecnologiaInstance.errors, view:'create'
            return
        }

        faseTecnologiaInstance.palavras[0]= params.palavras1
        faseTecnologiaInstance.palavras[1]= params.palavras2
        faseTecnologiaInstance.palavras[2]= params.palavras3
        faseTecnologiaInstance.ownerId = session.user.id as long
        faseTecnologiaInstance.taskId = session.taskId as String

        faseTecnologiaInstance.save flush:true
    }

    def edit(FaseTecnologia faseTecnologiaInstance) {
        respond faseTecnologiaInstance
    }

    //@Transactional
    def update(FaseTecnologia faseTecnologiaInstance) {
        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        if (faseTecnologiaInstance.hasErrors()) {
            respond faseTecnologiaInstance.errors, view:'edit'
            return
        }

        faseTecnologiaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FaseTecnologia.label', default: 'FaseTecnologia'), faseTecnologiaInstance.id])
                redirect faseTecnologiaInstance
            }
            '*'{ respond faseTecnologiaInstance, [status: OK] }
        }
    }

    //@Transactional
    def delete(FaseTecnologia faseTecnologiaInstance) {

        if (faseTecnologiaInstance == null) {
            notFound()
            return
        }

        faseTecnologiaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FaseTecnologia.label', default: 'FaseTecnologia'), faseTecnologiaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faseTecnologia.label', default: 'FaseTecnologia'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['permitAll'])
    def exportLevel(){
        //cria a instancia da fase tecnologia com os valores digitados pelo usuario
        FaseTecnologia faseTecnologia = new FaseTecnologia()
        faseTecnologia.palavras[0] = params.palavras1
        faseTecnologia.palavras[1] = params.palavras2
        faseTecnologia.palavras[2] = params.palavras3
        faseTecnologia.link = params.link
        faseTecnologia.tipoLink = params.tipoLink

        //cria os arquivos json e html da fase
        createJsonFileComputadores("computadores.json", faseTecnologia)
        createHtmlFileTelao("telao.html", faseTecnologia)

        // Finds the created file path
        def ids = []
        def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
        def fasesFolder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/processes/${session.processId}")

        log.debug folder
        ids << MongoHelper.putFile(folder + '/telao.html')
        ids << MongoHelper.putFile(fasesFolder + '/fases.json')
        ids << MongoHelper.putFile(folder + '/computadores.json')

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }
        // Updates current task to 'completed' status
        render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" +
                "?files=${ids[0]}&files=${ids[1]}&files=${ids[2]}"

    }

    void createJsonFileComputadores(String fileName, FaseTecnologia faseTecnologia){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")

        instancePath.mkdirs()

        File file = new File("$instancePath/"+fileName);
        def pw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))
        pw.write("{\n");
        pw.write("\t\"words\": [\"" + faseTecnologia.palavras[0].replace("\"","\\\"") + "\", \""+ faseTecnologia.palavras[1].replace("\"","\\\"") +"\", \""+ faseTecnologia.palavras[2].replace("\"","\\\"") +"\"]\n")
        pw.write("}");
        pw.close();
    }

    void createHtmlFileTelao(String fileName, FaseTecnologia faseTecnologia){
        def dataPath = servletContext.getRealPath("/data")
        def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
        def fasesFolder = new File("${dataPath}/${springSecurityService.currentUser.id}/processes/${session.processId}")
        instancePath.mkdirs()
        fasesFolder.mkdirs()

        File file = new File("$instancePath/"+fileName);
        PrintWriter pw = new PrintWriter(file);

        if(faseTecnologia.tipoLink == FaseTecnologia.LINK_YOUTUBE) {
            faseTecnologia.link = fixYoutubeLink(faseTecnologia.link)
            println faseTecnologia.link
            pw.write("<html>\n");
            pw.write("<body style=\"margin: 0 !important;\">\n")
            pw.write("<iframe width=\"334\" height=\"201\" src=\"" + faseTecnologia.link + "\" frameborder=\"0\" ")
            pw.write("style=\"background: #000000\" allowfullscreen></iframe>")
            pw.write("</body>\n")
            pw.write("</html>")
        }
        pw.close();

        //adiciona a fase tecnologia no arquivo fases.json
        File fileFasesJson = new File("$fasesFolder/fases.json")
        boolean exists = fileFasesJson.exists()
        if(!exists) {
            PrintWriter printer = new PrintWriter(fileFasesJson)
            printer.write("{\n");
            printer.write("\t\"quantidade\": [\"1\"],\n")
            printer.write("\t\"fases\": [\"1\",\"2\"]\n")
            printer.write("}")
            printer.close()
        } else {
            def arq = new JsonSlurper().parseText(fileFasesJson.text)
            PrintWriter printer = new PrintWriter(fileFasesJson)
            printer.write("{\n");

            if(arq["quantidade"][0] == "0") {
                printer.write("\t\"quantidade\": [\"1\"],\n")
                printer.write("\t\"fases\": [\"1\", \"2\"]\n")
            } else {
                printer.write("\t\"quantidade\": [\"2\"],\n")
                printer.write("\t\"fases\": [\"2\", \"1\"]\n")
            }

            printer.write("}")
            printer.close()
        }
    }

    String fixYoutubeLink(String link) {
        def newLink = link.substring(link.indexOf("www"))
        if(newLink.contains("embed"))
            return "http://" + newLink;
        def pos = newLink.indexOf("v=")
        def endPos = newLink.indexOf("&")
        if(endPos == -1)
            return "http://www.youtube.com/embed/" + newLink.substring(pos+2)
        return "http://www.youtube.com/embed/" + newLink.substring(pos+2, endPos)
    }
}