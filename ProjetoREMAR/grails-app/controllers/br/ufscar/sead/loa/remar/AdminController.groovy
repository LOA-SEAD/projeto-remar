package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import grails.converters.JSON
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.commons.CommonsMultipartFile
import static org.springframework.http.HttpStatus.*

@Secured(["ROLE_ADMIN"])
class AdminController {

    def springSecurityService
    static allowedMethods = [updateAnnouncement: "POST", saveAnnouncement: "POST", deleteUser: "POST"]

    def index() {
        def unseenReports = Report.countBySeen(false)

        render view: "dashboard", model: [unseenReports: unseenReports]
    }

    def announcements() {
        def announcements = Announcement.list().sort { it.dateCreated }
        render view: "announcements", model: [announcements: announcements, announcementCount: Announcement.count()]
    }


    def users() {
        def users = User.list().sort {it.getName().toLowerCase()}
        render view: "users", model: [users: users]
    }

    def groups() {
        def groups = Group.list().sort {it.name.toLowerCase()}
        render view: "groups", model: [groups: groups]
    }

    def categories() {
        def categories = Category.list().sort {it.name.toLowerCase()}
        render view: "categories", model: [categories: categories]
    }

    def games() {
        def games = ExportedResource.list().sort {it.getName().toLowerCase()}
        render view: "games", model: [games: games]
    }

    def reports() {
        def reports = Report.findAllByArchived(false, [sort: "date"])
        reports.reverse(true)
        render view: "reports", model: [reports: reports]
    }

    def reportArchive() {
        def reports = Report.findAllByArchived(true, [sort: "date"])
        reports.reverse(true)
        render view: "/report/archive", model: [reports: reports]
    }

    def deleteAnnouncement() {
        deleteAnnouncementProc(params.id)
        render (status: 200)
    }

    def deleteUser() {
        deleteUserProc(params.id)
        render (status: 200)
    }

    def deleteGroup() {
        deleteGroupProc(params.id)
        render (status: 200)
    }

    def deleteCategory() {
        deleteCategoryProc(params.id)
        render (status: 200)
    }

    def deleteGame() {
        deleteGameProc(params.id)
        render (status: 200)
    }

    def deleteReport() {
        deleteReportProc(params.id)
        render (status: 200)
    }

    def deleteUserBatch() {
        def userIdList = JSON.parse(params.userIdList)

        userIdList.each {
            deleteUserProc(it)
        }

        render (status: 200)
    }

    def deleteGroupBatch() {
        def groupIdList = JSON.parse(params.groupIdList)

        groupIdList.each {
            deleteGroupProc(it)
        }

        render (status: 200)
    }

    def deleteCategoryBatch() {
        def categoryIdList = JSON.parse(params.categoryIdList)

        def categoryRemoved = []

        categoryIdList.each {
            def resource = Resource.findByCategory(Category.findById(it))

            if (!resource) {
                deleteCategoryProc(it)
                categoryRemoved.add(it)
            }
        }

        render categoryRemoved as JSON
    }

    def deleteGameBatch() {
        def gameIdList = JSON.parse(params.gameIdList)

        gameIdList.each {
            deleteGameProc(it)
        }

        render (status: 200)
    }

    def deleteReportBatch() {
        def reportIdList = JSON.parse(params.reportIdList)

        reportIdList.each {
            deleteReportProc(it)
        }

        render(status: 200)
    }

    def createAnnouncement() {
        respond new Announcement(params), view:'_announcementForm'
    }

    @Transactional
    saveAnnouncement(Announcement announcement) {
        if (announcement == null) {
            respond error: 500
            return
        }

        if (announcement.author == null) {
            announcement.author = springSecurityService.getCurrentUser();
        }

        announcement.save flush:true

        render announcement as JSON
    }

    @Transactional
    saveCategory() {
        Category category = new Category(params)

        if (category == null) {
            notFound()
            return
        }

        category.save flush:true

        render category as JSON
    }

    @Transactional
    def editAnnouncement(Announcement announcementInstance) {
        if (announcementInstance == null) {
            render(status: 410, text: "ERROR: Failed editing announcement")
            return
        }

        respond announcementInstance, view: "_announcementForm"
    }

    @Transactional
    def updateAnnouncement(Announcement announcement) {
        if (announcement == null) {
            notFound()
            return
        }

        if (announcement.hasErrors()) {
            respond announcement.errors, view:'edit'
            return
        }

        announcement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Announcement.label', default: 'Announcement'), announcement.id])
                redirect announcement
            }
            '*'{ respond announcement, [status: OK] }
        }
    }

    @Transactional
    editCategory(Category categoryInstance) {

        if (categoryInstance == null) {
            render(status: 410, text: "ERROR: Failed editing category")
            return
        }

        categoryInstance.name = params.name

        categoryInstance.save flush:true
        render (status: 200)
    }



    @Transactional
    toggleUserDeveloperStatus() {
        def user = User.findById(params.id)
        def role = Role.findByAuthority("ROLE_DEV")
        def userRole = UserRole.findByUserAndRole(user, role)

        if (!userRole) {
            UserRole.create(user, Role.findByAuthority("ROLE_DEV"), true)

            render true
            return
        } else {
            userRole.delete flush: true

            render false
            return
        }

    }

    /**
     * @desc   register a batch of new users from a spreadsheet file
     *         .csv, .xls and .xlxs files are accepted
     * @param  file - the file from which users will be imported
     * @return a message if something goes wrong, otherwise a redirect
     */
    @Transactional
    importUsers() {
        CommonsMultipartFile file = request.getFile("spreadsheet-file")

        if (!file.empty) {
            switch (file.contentType) {
                case "application/vnd.ms-excel":
                case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                    ExcelUtil converter = new ExcelUtil()
                    converter.getObjectsFromExcelFile(file).each {
                        registerUser(it[0] /* username */, it[1] /* email */, it[2] /* firstName */, it[3] /* lastName */)
                    }
                    break
                case "text/csv":
                    Util.readCSV(file, ';', 'UTF-8').each {
                        registerUser(it[0] /* username */, it[1] /* email */, it[2] /* firstName */, it[3] /* lastName */)
                    }
                    break
                default:
                    flash.message = g.message(code: "admin.users.import.error.contentType")
                    break
            }
        } else {
            flash.message = g.message(code: "default.errors.fileEmpty")
        }

        redirect action: "users"
    }

    /**
     * @desc    export selected users to a .csv, .xls or .xlsx file
     * @params  params - an object containing parameters from ajax call
     * @return  path to download file
     */
    def exportUsers() {
        def date = new Date()
        final String extension = params.ext
        final String filename = "exportedUsers_" + date.format("yyyyMMdd") + "." + extension
        final String encoding = grailsApplication.config.grails.converters.encoding ?: "UTF-8"
        final String mimeType = grailsApplication.config.grails.mime.types[extension] ?: "text/csv"

        try {
            response.setStatus(OK.value())
            response.setContentType("${mimeType};charset=${encoding}")
            response.setHeader("Content-Disposition", "attachment;filename=${filename}")

            switch (mimeType) {
                case "application/vnd.ms-excel":
                case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                    def dataToWrite = []

                    User.getAll(JSON.parse(params.userIdList)).each {
                        def row = [
                                it.username,
                                it.email,
                                it.firstName,
                                it.lastName
                        ]

                        dataToWrite.add(row)
                    }

                    def converter = new ExcelUtil()
                    def workbook = converter.writeListToExcelFile(dataToWrite, extension)

                    workbook.write(response.outputStream)
                    break
                case "text/csv":
                    User.getAll(JSON.parse(params.userIdList)).each {
                        def row = it.username + ";" +
                                it.email + ";" +
                                it.firstName + ";" +
                                it.lastName + "\n"

                        response.outputStream << row
                    }
                    break
                default:
                    flash.message = g.message(code: "admin.users.import.error.contentType")
                    break
            }
        } catch (e) {
            log.debug(e + " in Admin/ExportCSV")
        }

        response.outputStream.flush()
        response.outputStream.close()
    }

    /**
     * @desc   Procedure to remove a category
     * @param  id - the id from the announcement to be removed
     * @return nothing
     */
    @Transactional
    deleteAnnouncementProc(id) {
        def announcementInstace = Announcement.findById(id)

        if (announcementInstace == null) {
            log.debug("ERROR @ deleteAnnouncementProc: Announcement instance [id: ${id}] not found")
            render status: 410
            return
        }

        announcementInstace.delete flush: true
    }

    /**
     * @desc   Procedure to remove an user and all data related to him
     * @param  id - the id from the user to be removed
     * @return nothing
     */
    @Transactional
    deleteUserProc(id) {
        def userInstance = User.findById(id)

        if (userInstance == null) {
            log.debug("ERROR @ deleteUserProc: User instance [id: ${id}] not found")
            render status: 410
            return
        }

        //UserRole.removeAll(userInstance, true)

        // Remove Tokens that belong to the user
        /*List<Token> tokens = Token.findAllByOwner(userInstance)
        for (int i = 0; i < tokens.size(); i++)
            tokens.get(i).delete()

        // Remove Resources that belong to the user
        List<Resource> resources = Resource.findAllByOwner(userInstance)
        for (int i = 0; i < resources.size(); i++)
            resources.get(i).delete()

        // Remove Exported Resources that belong to the user
        List<ExportedResource> exportedResources = ExportedResource.findAllByOwner(userInstance)
        for (int i = 0; i < exportedResources.size(); i++)
            exportedResources.get(i).delete()

        // Remove groups that belong to the user
        List<Group> groups = Group.findAllByOwner(userInstance)
        for (int i = 0; i < groups.size(); i++)
            groups.get(i).delete()

        // Remove user-group relationships
        UserGroup.removeAllByUser(userInstance, true)*/

        //userInstance.delete flush: true



        userInstance.enabled = false
        userInstance.save flush: true
	redirect uri: "/admin/users"
    }

    /**
     * @desc Procedure to remove a group
     * @param id - the id from the user to be removed
     * @return nothing
     */
    @Transactional
    deleteGroupProc(id) {
        def groupInstance = Group.findById(id)

        if (groupInstance == null) {
            log.debug("ERROR @ deleteGroupProc: Group instance [id: ${id}] not found")
            render status: 410
            return
        }

        // Remove user-group relationships
        UserGroup.removeAllByGroup(groupInstance, true)

        // Remove group-exportedResource relationships
        GroupExportedResources.removeAllByGroup(groupInstance, true)

        groupInstance.delete flush:true
    }

    /**
     * @desc   Procedure to remove a game
     * @param  id - the id from the game to be removed
     * @return nothing
     */
    @Transactional
    deleteGameProc(id) {
        def gameInstance = ExportedResource.findById(id)

        if (gameInstance == null) {
            log.debug("ERROR @ deleteGameProc: ExportedResource instance [id: ${id}] not found")
            render status: 410
            return
        }

        // Remove group-exportedResource relationships
        GroupExportedResources.removeAllByExportedResource(gameInstance, true)

        gameInstance.delete flush: true
    }

    /**
     * @desc   Procedure to remove a category
     * @param  id - the id from the category to be removed
     * @return nothing
     */
    @Transactional
    deleteCategoryProc(id) {
        def categoryInstance = Category.findById(id)

        if (categoryInstance == null) {
            log.debug("ERROR @ deleteCategoryProc: Category instance [id: ${id}] not found")
            render status: 410
            return
        }

        categoryInstance.delete flush: true
    }

    /**
     * @desc Procedure to remove a group
     * @param id - the id from the user to be removed
     * @return nothing
     */
    @Transactional
    deleteReportProc(id) {
        def reportInstance = Report.findById(id)

        if (reportInstance == null) {
            log.debug("ERROR @ deleteReportProc: Report instance [id: ${id}] not found")
            render status: 410
            return
        }

        if (reportInstance.screenshot) {
            def filename = servletContext.getRealPath("/data/report-screenshots/" + reportInstance.id + ".png")
            def fileSuccessfullyDeleted = new File(filename).delete()

            if (!fileSuccessfullyDeleted) {
                log.debug("ERROR @ deleteReportProc: Failed deleting Report instance screenshot file")
                render status: 410
                return
            }
        }

        reportInstance.delete flush: true
    }

    /**
     * @desc   create an user with randomly generated password and send an email prompting to change that password
     * @param  username - created user username
     * @param  email - created user email
     * @param  firstName - created user first name
     * @param  lastName - created user last name
     * @return nothing
     */
    def registerUser(String username, String email, String firstName, String lastName) {
        User user = new User()
        user.username = username
        user.email = email
        user.firstName = firstName
        user.lastName = lastName
        user.password = RandomStringUtils.random(8, true, true)

        user.save flush: true

        if (user.hasErrors()) {
            log.debug(user.errors)
        } else {
            def html = g.render(template: "newUserEmail", model: ["user": user])
            Util.sendEmail(email, "Bem-vindo ao REMAR", html)
        }
    }
}
