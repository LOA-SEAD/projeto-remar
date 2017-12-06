package br.ufscar.sead.loa.remar

import grails.transaction.Transactional

class ReportController {

    def springSecurityService, grailsApplication

    /* Transactional Methods */
    @Transactional
    save() {
        def reportInstance = new Report()

        // Check if description is not empty
        if (!params.description || params.description.allWhitespace) {
            // 422: Unprocessable Entity -> server understands action, understands data but don't let it be processed
            render status: 422
            return
        } else {
            reportInstance.description = params.description
        }

        reportInstance.who = User.findById(springSecurityService.getCurrentUser().getId())
        reportInstance.date = new Date()
        reportInstance.url = params.url
        reportInstance.type = params.type
        reportInstance.browser = params.browser
        reportInstance.seen = false
        reportInstance.solved = false
        reportInstance.screenshot = (params.screenshot) ? true : false

        reportInstance.save flush:true

        if (reportInstance.screenshot) {
            // Split string sent by html2canvas from js into it's header and encoded content
            def (header, encoded) = params.screenshot.tokenize(',')

            // Clean the encoded string
            encoded = encoded.replaceAll("[\r\n]", "")

            // Decode it
            byte[] decoded = encoded.decodeBase64()

            // Write the file
            def filename = servletContext.getRealPath("/data/report-screenshots/" + reportInstance.id + ".png")
            def file = new File(filename)

            // If parent directory doesn't exist yet, create it
            if (!file.getParentFile().exists()) file.getParentFile().mkdirs()

            // Write decoded string to file, becoming a png image
            file.withOutputStream {
                it.write(decoded)
            }

            log.debug reportInstance.id + " screenshot saved"
        }

        // Send email to admin
        def emailRecipient = grailsApplication.config.remar.email.admin.toString()
        def emailSubject = "Relato de problema na plataforma REMAR"
        def emailMessage = "O usuário ${reportInstance.who.getName()} relatou um problema com a plataforma REMAR. <br/ >" +
                           "<strong>Tipo do problema</strong>: " + message(code: "report.type.${reportInstance.type}") + "<br />" +
                           "<strong>Data</strong>: ${reportInstance.date} <br />" +
                           "<strong>Descrição</strong>: ${reportInstance.description} <br />" +
                           "<strong>Navegador</strong>: ${reportInstance.browser} <br />" +
                           "<strong>URL</strong>: ${reportInstance.url} <br />"

        Util.sendEmail(emailRecipient, emailSubject, emailMessage)

        render status:200
    }

    @Transactional
    toggleSeenStatus() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.seen = !reportInstance.seen
        if (reportInstance.solved && !reportInstance.seen) reportInstance.solved = false
        reportInstance.save flush:true

        render status: 200, text: reportInstance.seen ? "seen" : "unseen"
    }

    @Transactional
    toggleSolvedStatus() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.solved = !reportInstance.solved
        if (!reportInstance.seen && reportInstance.solved) reportInstance.seen = true
        reportInstance.save flush: true

        render status: 200, text: reportInstance.solved ? "solved" : "unsolved"
    }

    /* Not transactional methods */
    def create() {
        respond new Report(params)
    }
}
