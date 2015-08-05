package br.ufscar.sead.loa.remar

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartRequest

import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
import br.ufscar.sead.loa.remar.Moodle

@Secured(['ROLE_ADMIN'])
class ExportedGameController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    def save(ExportedGame exportedGame) {
        /*if (exportedGame.hasErrors()) {
            println("Someone tried to register a new moodlegame but it doesn't worked:")
            println(exportedGame.errors)
        }
        else {
            println exportedGame as JSON
            //moodlegame.save flush:true
            //redirect controller: "MoodleGame", action: "accountPublishConfig", id: moodlegame.id
        }*/

        //need to improve that
        exportedGame.owner = User.findById(springSecurityService.getCurrentUser().getId())
        exportedGame.exportedAt = new Date()
        exportedGame.type = 'public'
        exportedGame.addToPlatforms(Platform.findByName("Moodle"))

        println exportedGame as JSON

        exportedGame.save flush:true
        redirect controller: "ExportedGame", action: "accountConfig", id: exportedGame.id
    }

    def _moodles() {

    }

    /* to test the moodle list */
    def loadMoodleList() {
        def moodleList = Moodle.list()
        render(view: '/exportedGame/_moodles', model: [moodleList: moodleList, id: params.local])
    }

    def publish(ExportedGame exportedGame) {
        def moodleList = Moodle.list()
        respond moodleList, model:[moodleList: moodleList]
    }

    def accountConfig(ExportedGame exportedGame) {
        Moodle m = Moodle.findWhere(id: Long.parseLong("1"))

        render(view:"accountConfig", model:['exportedGameInstance': exportedGame]);
    }

    def accountSave() {
        def arr = []

        def exportedGameId = Long.parseLong(params.find({it.key == "exportedGameId"}).value)

        ExportedGame exportedGame = ExportedGame.findById(exportedGameId)

        params?.each{
            def name = it.key
            if (name.startsWith("moodlename")) {
                def splitted = name.split("moodlename")
                def id = Long.parseLong(it.value)
                def moo = Moodle.findWhere(id: id)

                def accName = params.find({it.key == "account"+splitted[1]}).value

                def account = MoodleAccount.find({accountName == accName && owner.domain == moo.domain})

                /* check if the account already exists */
                if (account == null) {
                    account = new MoodleAccount()
                    account.accountName = accName
                    account.owner = moo
                    account.save flush:true
                }

                println account as JSON
                exportedGame.addToAccounts(account)
                exportedGame.save flush:true
            }
        }
    }
}
