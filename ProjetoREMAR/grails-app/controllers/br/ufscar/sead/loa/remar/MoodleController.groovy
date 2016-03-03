package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.util.Environment
import groovy.json.JsonBuilder
import groovyx.net.http.HTTPBuilder
import org.apache.commons.lang.RandomStringUtils

class MoodleController {

    static allowedMethods = [save: ["GET","POST"], update: "PUT", delete: "DELETE"]

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
        def url = Moodle.get(params.moodleId as Integer).domain + "/mod/remarmoodle/new-account-confirmation.php?hash=" + hash + "&moodleId=" + params.moodleId

        redirect url: url
    }

    def unlink() {
        def moodleAccount = MoodleAccount.findByToken(params.id)
        moodleAccount.delete flush:true

        def url = moodleAccount.moodle.domain + "/mod/remarmoodle/unlink-remar-account.php?hash=" + moodleAccount.token
        redirect url: url

        log.debug moodleAccount
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

                redirect uri: "/my-profile"
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

    def resources_list() {
        //getting the user based on the hash received
        log.debug MoodleAccount.findByToken(params.hash as String)

        /*def moodle = Moodle.findAllByActiveAndDomain(true, domain)

        log.debug moodle

        if (moodle != []) {
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
                        "moodleHash": User.get(p.ownerId).moodleHash
                        /*"accounts": p.accounts.collect {a ->
                            [
                                "accountName": a.accountName,
                                "id": a.id
                            ]
                        }
                    ]
                }
            )

            render json as JSON
        }
        else {
            render 'O moodle "'+domain+'" foi desinstalado ou não existe.'
        }*/
    }

    def send() {
        log.debug "PARAMS: "
        log.debug params

        println "params: "
        println params

        params.remove("controller")
        params.remove("format")
        params.remove("action")
        params.hash = User.get(session.user.id).moodleHash
        params.cm      = 27
        def time = new Date().time as String

        def token = Moodle.findAll().first().token

        params.timestamp = time.substring(0, time.length() - 3)

        //def table = ExportedResource.get(params.remar_resource_id).moodleTableName

        def q = [alternativaa: params.alternativaa,
                 alternativab: params.alternativab,
                 alternativac: params.alternativac,
                 alternativad: params.alternativad,
                 respostacerta: params.respostacerta,
                 resposta: params.resposta,
                 timestamp: params.timestamp,
                 hash: params.hash,
                 enunciado: params.enunciado,
                 remar_resource_id: params.remar_resource_id,
                 table_name: "escola_magica",
                 wstoken: token,
                 wsfunction: "mod_remarmoodle_insert_record"]



        log.debug "~~~~~~~"
        log.debug q
        log.debug "~~~~~~~"
        def http, path
        if (Environment.current == Environment.DEVELOPMENT) {
            http = new HTTPBuilder("http://localhost")
            path = "/moodle/webservice/rest/server.php"
        }
        else {
            http = new HTTPBuilder("http://remar.dc.ufscar.br:9090")
            path = "/webservice/rest/server.php"
        }


        def resp = http.post(path: path,
                query: q) as String

        println resp
        return
        //def resp = JSON.parse(http.post(path: "/moodle/webservice/rest/server.php",
          //      query: params) as String)
    }
}
