package br.ufscar.sead.loa.remar

import grails.converters.JSON
import groovy.json.JsonBuilder
import groovyx.net.http.HTTPBuilder
import org.apache.commons.lang.RandomStringUtils

class MoodleController {

    static allowedMethods = [save: ["GET","POST"], update: "PUT", delete: "DELETE"]

    /*def index() {
        def model = [:]
        model.moodleInstanceList = Moodle.findAllByActive(true)
        render view: "index", model: model
    }*/

    def save(Moodle instance) {
        if (!Moodle.findByDomain(params.domain)) {
            instance.installedAt = new Date()
            instance.active = true
            instance.save flush: true
            log.debug "moodle saved: ${instance.name}"
        }
        else {
            instance.active = true

            instance.save flush: true

            log.debug "moodle reactivated: ${instance.name}"
        }
    }

    def link() {
        def hash = RandomStringUtils.random(30, true, true)
        def url = Moodle.get(params.id).domain + "/mod/remarmoodle/new-account-confirmation.php?hash=" + hash + "&moodleId=" + params.id

        redirect url: url
    }

    def confirm() {
        if(params.hash && params.moodleId && params.username) {
            if(request.getHeader('referer').contains(Moodle.get(params.moodleId).domain)) {
                log.debug "user: " + session.user

                def moodleAccount = new MoodleAccount()
                moodleAccount.owner = session.user
                moodleAccount.moodle = Moodle.get(params.moodleId)
                moodleAccount.token = params.hash
                moodleAccount.accountName = params.username
                moodleAccount.save flush:true

                log.debug moodleAccount.errors
            }
            else {
                log.debug "The request source is not matching the moodle domain in the REMAR"
            }
        }
        else {
            log.debug "Missing the hash, the username or the moodleId parameter that should be automatically received"
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
                    log.debug "removed."
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
        log.debug params
        params.remove("controller")
        params.remove("format")
        params.remove("action")
        params.user_id = session.user.id
        params.cm      = 27
        def time = new Date().time as String

        params.timestamp = time.substring(0, time.length() - 3)

        def table = params.remove("table_name")
        def q = [alternativaa: params.alternativaa,
                 alternativab: params.alternativab,
                 alternativac: params.alternativac,
                 alternativad: params.alternativad,
                 respostacerta: params.respostacerta,
                 resposta: params.resposta,
                 timestamp: params.timestamp,
                 user_id: params.user_id,
                 cm: params.cm,
                 enunciado: params.enunciado,
                 remar_resource_id: params.remar_resource_id,
                 table_name: table,
                 wstoken: "647c093b186a187a0ac89884c8c79795",
                 wsfunction: "mod_remarmoodle_insert_record"]
        log.debug "~~~~~~~"
        log.debug q
        log.debug "~~~~~~~"
        def http = new HTTPBuilder("http://remar.dc.ufscar.br:9090")
        log.debug http.post(path: "/webservice/rest/server.php",
                query: q) as String
        return
        //def resp = JSON.parse(http.post(path: "/moodle/webservice/rest/server.php",
          //      query: params) as String)



        log.debug "resp: " + resp
    }
}
