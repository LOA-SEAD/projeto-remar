package br.ufscar.sead.loa.remar

import grails.converters.JSON
import groovy.json.JsonBuilder
import groovyx.net.http.HTTPBuilder

class MoodleController {

    static allowedMethods = [save: ["GET","POST"], update: "PUT", delete: "DELETE"]

    def index() {
        def model = [:]
        model.moodleInstanceList = Moodle.findAllByActive(true)
        render view: "index", model: model
    }

    def save(Moodle instance) {
        if (!Moodle.findByDomain(params.domain)) {
            instance.installedAt = new Date()
            instance.active = true
            instance.save flush: true
            println "moodle saved: ${instance.name}"
        }
        else {
            instance.active = true

            instance.save flush: true

            println "moodle reactivated: ${instance.name}"
        }
    }

    def link() {
        println params.domain
        def http = new HTTPBuilder(params.domain)
        def resp = JSON.parse(http.post(path: "/webservice/rest/server.php",
                             query: [wstoken: grailsApplication.config.wstoken,
                                     wsfunction: "mod_remarmoodle_link_remar_user",
                                     remar_user_id: session.user.id,
                                     moodle_username: params.username]) as String)
        if(resp.success) {
            render view: "linkSuccess"
        } else {
            render "Ops. Algo deu errado :("
        }
    }

    def confirm() {
        def http = new HTTPBuilder("http://remar.dc.ufscar.br:9090")
        def resp = JSON.parse(http.post(path: "/webservice/rest/server.php",
                query: [wstoken: grailsApplication.config.wstoken,
                        wsfunction: "mod_remarmoodle_token_verifier",
                        hash: params.id]) as String)

        if (resp.username) {
            def user = User.get(session.user.id)
            user.moodleUsername = resp.username
            user.save flush: true
            session.user = user

            render view: "confirmed", model: [username: resp.username]
        } else {
            render "Ops. Algo deu errado :("
        }

    }

    def remove(String domain) {

        Moodle moodleToDelete = Moodle.where {
            active == true && domain == domain
        }.list().first()

        if(domain == null || moodleToDelete == []) {
            def str = 'Someone tried to uninstall the REMAR plugin of his/her moodle ("'+domain+'") but it wasn\'t found or have been deleted already.'
            render str
        }

        moodleToDelete.active = false
        moodleToDelete.save flush:true

        render 'Moodle "'+domain+'" successfully deleted.'
    }

    def resources_list(String domain) {
        //def moodle = Moodle.findByDomain(domain).Where(active)
        def moodle = Moodle.where {
            active == true && domain == domain
        }.list()

        if (moodle != []) {
            /* list of games published only for moodle */
            def list = ExportedResource.findAll()

            Iterator i = list.iterator();
            while (i.hasNext()) {
                def n = i.next()

                if (!n.moodleUrl) {
                    i.remove()
                    println "removed."
                }
            }

            def builder = new JsonBuilder()

            def json = builder (
                "resources": list.collect {p ->
                    [
                        "id": p.id,
                        "height": p.height,
                        "width": p.width,
                        "image": p.image,
                        "moodleUrl": p.moodleUrl,
                        "name": p.name,
                        "remar_user_id": p.ownerId
                        /*"accounts": p.accounts.collect {a ->
                            [
                                "accountName": a.accountName,
                                "id": a.id
                            ]
                        }*/
                    ]
                }
            )

            render json as JSON
        }
        else {
            render 'O moodle "'+domain+'" foi desinstalado ou não existe.'
        }
    }

    def send() {
        println params
        params.remove("controller")
        params.remove("format")
        params.remove("action")
        params.wstoken    = grailsApplication.config.wstoken
        params.wsfunction = "mod_remarmoodle_insert_record"
        params.user_id = session.user.id
        params.cm      = "auhea"
        params.timestamp = new Date().time as String

        def http = new HTTPBuilder("http://localhost")
        def resp = JSON.parse(http.post(path: "/moodle/webservice/rest/server.php",
                query: [parms]) as String)

        println resp
    }
}
