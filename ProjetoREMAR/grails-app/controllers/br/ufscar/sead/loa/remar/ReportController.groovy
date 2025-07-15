package br.ufscar.sead.loa.remar

import grails.transaction.Transactional
import grails.converters.JSON

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
        reportInstance.archived = false
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

        Util.sendEmail("Administrador - REMAR", emailRecipient, emailSubject, emailMessage)

        render status:200
    }

    @Transactional
    toggleSeenStatus() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.seen = !reportInstance.seen

        if (reportInstance.solved && !reportInstance.seen)
            reportInstance.solved = false

        reportInstance.save flush:true

        render status: 200, text: reportInstance.seen ? "seen" : "unseen"
    }

    @Transactional
    markAsSeen() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.seen = true

        reportInstance.save flush: true

        render status: 200
    }

    @Transactional
    batchMarkAsSeen() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (!reportInstance.seen) {
                reportInstance.seen = true
                reportInstance.save flush: true

                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
    }

    @Transactional
    batchMarkAsUnseen() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (reportInstance.seen) {
                reportInstance.seen = false

                if (reportInstance.solved)
                    reportInstance.solved = false

                reportInstance.save flush: true
                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
    }

    @Transactional
    batchMarkAsSolved() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (!reportInstance.solved) {
                reportInstance.solved = true

                if (!reportInstance.seen)
                    reportInstance.seen = true

                reportInstance.save flush: true
                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
    }

    @Transactional
    batchMarkAsUnsolved() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (reportInstance.solved) {
                reportInstance.solved = false
                reportInstance.save flush: true

                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
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

    @Transactional
    archive() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.archived = true
        reportInstance.seen = true
        reportInstance.save flush: true
        render status: 200
    }

    @Transactional
    unarchive() {
        def reportInstance = Report.findById(params.id)

        if (!reportInstance) {
            render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
        }

        reportInstance.archived = false
        reportInstance.save flush: true
        render status: 200
    }

    @Transactional
    batchArchive() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (!reportInstance.archived) {
                reportInstance.archived = true
                reportInstance.save flush: true

                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
    }

    @Transactional
    batchUnarchive() {
        def reportIdList = JSON.parse(params.reportIdList)
        def changedCounter = 0

        reportIdList.each {
            def reportInstance = Report.findById(it)

            if (!reportInstance) {
                render status: 422, text: ("ERROR: Report instance not found for id: " + params.id.toString())
                return
            } else if (reportInstance.archived) {
                reportInstance.archived = false
                reportInstance.save flush: true

                changedCounter++
            }
        }

        render(status: 200, text: changedCounter.toString())
    }

    def getReport() {
        def reportInstance = Report.findById(params.id)
        def reportDataObject = [:]

        reportDataObject['who'] = reportInstance.who.getName()
        reportDataObject['date'] = g.formatDate(date: reportInstance.date, format: 'EEEE, dd/MM/yyyy')
        reportDataObject['browser'] = reportInstance.browser
        reportDataObject['url'] = reportInstance.url
        reportDataObject['type'] = g.message(code: "report.type.${reportInstance.type}")
        reportDataObject['description'] = reportInstance.description
        reportDataObject['hasScreenshot'] = reportInstance.screenshot

        render reportDataObject as JSON
    }
}
