package br.ufscar.sead.loa.remar

import grails.util.Holders
import groovyx.net.http.HTTPBuilder

/**
 * Created by matheus on 12/1/15.
 */
class Util {

    def static later(code) {
        def r = new Runnable() {
            @Override
            void run() {
                code()
            }
        }
        new Thread(r).start()
    }

    def static sendEmail(String recipient, String subject, String body) {
        later {
            def http = new HTTPBuilder("https://api.sendgrid.com")
            http.setHeaders(['Authorization': "Bearer ${Holders.getGrailsApplication().config.sendGridApiKey}"])
            def response = http.post(path: '/api/mail.send.json', body: [
                    'fromname': 'REMAR',
                    'from': 'noreply@remar.dc.ufscar.br',
                    'replyto': 'contato@remar.dc.ufscar.br', // TODO @remar.dc.ufscar.br probably can't receive emails
                    'to': recipient,
                    'subject': subject,
                    'html': body
            ])

            if (response.message != "success") {
                println "cannot send email to ${recipient} with subject \"${subject}\""
                // TODO: log this properly (save the email in a file) and post to Slack
            }
        }
    }
}
