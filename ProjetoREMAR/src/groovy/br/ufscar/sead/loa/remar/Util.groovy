package br.ufscar.sead.loa.remar

import grails.util.Holders
import groovyx.net.http.HTTPBuilder
import org.springframework.web.multipart.commons.CommonsMultipartFile

/**
 * Created by matheus on 12/1/15.
 * Modified by garcia-pedro-hr on 29/11/2017
 */
class Util {

    static later(code) {
        def r = new Runnable() {
            @Override
            void run() {
                code()
            }
        }
        new Thread(r).start()
    }

    static sendEmail(String recipient, String subject, body) {
        def grailsApplication = Holders.getGrailsApplication()

        later {
            def http = new HTTPBuilder("https://api.sendgrid.com")
            http.setHeaders(['Authorization': "Bearer ${grailsApplication.config.sendGridApiKey}"])
            def response = http.post(path: '/api/mail.send.json', body: [
                    'fromname': 'REMAR',
                    'from': grailsApplication.config.remar.email.noreply,
                    'replyto': grailsApplication.config.remar.email.admin,
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

    static readCSV(CommonsMultipartFile csv, separatorChar, encoding) {
        def options = [
                'separatorChar': separatorChar?: ',',
                'charset': encoding?: 'UTF-8'
        ]

        def rows = []
        csv.inputStream.toCsvReader(options).eachLine { row ->
            rows.add(row)
        }

        return rows
    }

    public static final int THRESHOLD = 6
}
