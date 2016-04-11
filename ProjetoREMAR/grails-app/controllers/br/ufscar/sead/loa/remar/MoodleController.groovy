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
        def moodleAccount = MoodleAccount.findByToken(params.hash as String)

        //if the moodle account is not found
        if (moodleAccount == [] || moodleAccount == null) {
            log.debug "Moodle account not found"
            render "Moodle account not found."
        }
        else {
            //getting the user based on the hash received
            def user = moodleAccount.owner

            def exportedResources = ExportedResource.findAllByOwner(user)

            def builder = new JsonBuilder()

            def json = builder (
                "resources": exportedResources.collect { element ->
                    [
                        "id": element.id,
                        "height": element.height,
                        "width": element.width,
                        "moodleUrl": element.moodleUrl,
                        "name": element.name,
                        "resourceId": element.resourceId
                    ]
                }
            )

            render json as JSON
        }
    }

    def getLogFromResource() {
        if(params.resourceId) {
            def data = MongoHelper.instance.getData("escola_magica", params.resourceId as Integer)
            if (data.first() != null) {
                def builder = new JsonBuilder()

                def count = 0
                def data2 = [:]
                def data3 = [:]

                data.collect {
                    data3 = [:]
                    it.collect { k, v ->
                        if(k != "_id" && k != "moodle_url") {
                            data3[k] = v
                        }
                        if(k == "user") {
                            data3[k] = MoodleAccount.findByOwner(User.get(v)).token
                        }
                    }
                    data2[count] = data3
                    count++
                }

                def json = builder (
                    "data": data2
                )

                render json as JSON
            }
            else {
                render "no information found in our records."
            }
        }
        else {
            render "no information found in our records."
        }
    }
}
