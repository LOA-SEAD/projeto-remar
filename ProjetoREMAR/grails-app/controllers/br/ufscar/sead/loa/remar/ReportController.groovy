package br.ufscar.sead.loa.remar

import grails.transaction.Transactional

class ReportController {

    def springSecurityService

    def index() {
        def reports = Report.list(sort: "date")
    }

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

        render status:200
    }

    @Transactional
    delete(int id) {
        // Remove a instância do banco de dados e apaga a pasta de screenshots
        Report reportInstance = Report.findById(id)
        reportInstance.delete flush: true

        def root = servletContext.getRealPath("/")
        def ssDir = new File(root + "data/reports/${reportInstance.id}")
        ssDir.deleteDir()
    }

    def create() {
        respond new Report(params)
    }
}
