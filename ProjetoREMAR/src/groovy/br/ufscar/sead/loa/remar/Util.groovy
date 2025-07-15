package br.ufscar.sead.loa.remar

import grails.util.Holders
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.ContentType
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

    static sendEmail(String toName, String toAddress, String subject, String text) {
        
        later {
            def http = new HTTPBuilder("http://email-sender:8080")
            def response = http.post(path: '/send', body: [
                    'toName': toName,
                    'toAddress': toAddress,
                    'subject': subject,
                    'text': text
            ], requestContentType : ContentType.JSON)

            if (!response) {
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

    public static final int THRESHOLD = 12
}
