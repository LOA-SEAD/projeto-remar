package br.ufscar.sead.loa.remar
import grails.util.Environment
import static br.ufscar.sead.loa.remar.Util.THRESHOLD

class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def index() {
        if (springSecurityService.isLoggedIn()) {
                //def model = [:]
                //model.resourceInstanceList = Resource.findAllByStatus('approved', [max: 12, sort: ["submittedAt" : "desc"]])
                //model.userName = session.user.firstName
                //render view: "dashboard", model: model

                forward (controller:'resource', action:'customizableGames')
        } else {
            respond Announcement.list(max: 4, sort: "dateCreated")
        } 
    }

    def introduction() {}

    def architecture() {}

    def team() {}

    def publications() {}

    def contact() {}

    /* def publicGames() {
        forward (controller:'exportedResource', action:'publicGames')
    } */

    @SuppressWarnings("GroovyAssignabilityCheck")
    def publicGames() {
        params.order = "desc"
        params.sort = "id"
        params.max = params.max ? Integer.valueOf(params.max) : THRESHOLD
        params.offset = params.offset ? Integer.valueOf(params.offset) : 0
        params.type = "public"
        def pageCount = Math.ceil(ExportedResource.count / params.max) as int
        def publicGamesList = ExportedResource.list(params)
        def currentPage = (params.offset + THRESHOLD) / THRESHOLD

        //Colocando todos os atributos necessários para fazer a paginação/aparecer os cards em "model"
        def model = [:]
        model.publicExportedResourcesList = publicGamesList
        model.totalCount = publicGamesList.totalCount
        model.categories = Category.list(sort:"name")
        model.pageCount = pageCount
        model.currentPage = currentPage
        model.threshold = THRESHOLD

        render view: "/exportedResource/publicGames", model: model
    }

    def renderHTML(String fileName) {
        def dir = servletContext.getRealPath("/static")
        def file = new File(dir, fileName)
        def htmlContent = file.text
        render text: htmlContent, contentType:"text/html", encoding:"UTF-8"
    }

    def login() {
        if (springSecurityService.isLoggedIn()) {
            index()
        } else {
            render view: "../login/auth"
        }
    }

    def frame() {
        def model = [:]
        model.development = Environment.current == Environment.DEVELOPMENT
        model.uri = params.remove('uri')

        params.remove("controller")
        params.remove("action")
        params.remove("format")

        model.uri += "?" + params.collect { k, v -> "$k=$v" }.join('&')

        if (model.development) {
            if (model.uri.indexOf('forca') != -1) {
                model.uri = "http://localhost:8010${model.uri}"
            } else if (model.uri.indexOf('escola') != -1) {
                model.uri = "http://localhost:8020${model.uri}"
            } else if (model.uri.indexOf('mahjong') != -1) {
                model.uri = "http://localhost:8030${model.uri}"
            } else if (model.uri.indexOf('responda') != -1) {
                model.uri = "http://localhost:8040${model.uri}"
            } else if (model.uri.indexOf('ortotetris') != -1) {
                model.uri = "http://localhost:8050${model.uri}"
            } else if (model.uri.indexOf('santograu') != -1) {
                model.uri = "http://localhost:8060${model.uri}"
            } else if (model.uri.indexOf('labteca') != -1) {
                model.uri = "http://localhost:8070${model.uri}"
            } else if (model.uri.indexOf('memoria') != -1) {
                model.uri = "http://localhost:8090${model.uri}"
            }

        }

        render view: "frame", model: model
    }

    def nullPointerException(final NullPointerException exception) {
        log.debug "NullPointerException caught !"
        if (exception.getMessage().contains("firstName")) {
            log.debug "Logout: session.user is NULL !"
            redirect controller: "logout", action: "index"
        }
    }
}
