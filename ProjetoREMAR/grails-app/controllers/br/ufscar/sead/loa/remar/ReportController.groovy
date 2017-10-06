package br.ufscar.sead.loa.remar

import grails.transaction.Transactional

class ReportController {

    def springSecurityService

    def index() { }

    @Transactional
    save(Report reportInstance) {
        reportInstance.who = User.findById(springSecurityService.getCurrentUser().getId())
        reportInstance.date = new Date()
        reportInstance.seen = false
        reportInstance.url = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 8))

        //TODO: salvar screenshots e setar reportInstance.screenshot de acordo (true ou false)
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
