package br.ufscar.sead.loa.remar

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartRequest

import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
import br.ufscar.sead.loa.remar.Moodle

@Secured(['ROLE_ADMIN'])
class MoodleGameController {

    def springSecurityService

    def save(MoodleGame moodlegame) {
        //-------------------------------------Denis-----------------------
        def userId = springSecurityService.getCurrentUser().getId()
        def imageUploaded = request.getFile("moodleimage")
        def path = servletContext.getRealPath("/")
        def moodlePath = new File(path + "/moodle" + "/" + userId + "/")
        moodlePath.mkdirs()

        imageUploaded.transferTo(new File("$moodlePath/moodleimage.png"))



        //--------------------------------------Denis----------------------
    	if (moodlegame.hasErrors()) {
    		println("Someone tried to register a new moodlegame but it doesn't worked:")
    		println(moodlegame.errors)
    	}
    	else {
        	moodlegame.save flush:true

        	redirect controller: "MoodleGame", action: "accountPublishConfig", id: moodlegame.id
    	}


    }

    def gamePublishConfig() {
    	def moodleList = Moodle.list()
    	respond moodleList, model:[moodleList: moodleList]
    }

    def _moodles() {

    }

    def loadMoodleList() {
        def moodleList = Moodle.list()
        render(view: '/moodleGame/_moodles', model: [moodleList: moodleList, id: params.local])
    }

    def accountPublishConfig(MoodleGame moodleGame) {
        Moodle m = Moodle.findWhere(id: Long.parseLong("1"))

        render(view:"accountPublishConfig", model:['moodleGameInstance': moodleGame]);
    }

    def accountSave() {
        def arr = []

        MoodleGame moodleGame = MoodleGame.find{id: params.find({it.key == "moodleGameId"}).value}

        params?.each{
            def name = it.key
            if (name.startsWith("moodlename")) {
                def splitted = name.split("moodlename")
                def id = Long.parseLong(it.value)
                def moo = Moodle.findWhere(id: id)

                /* check if that moodle instance is vinculated with the game already */
                if (moodleGame.moodles.find {it.domain == moo.domain} == null) {
                    moodleGame.addToMoodles(moo)
                    moodleGame.save flush:true
                    println "salvou no moodleGame.moodles = " + moo.domain
                }

                /* check if there is an account with the same name to reuse it */
                def account = MoodleAccount.find({accountName == params.find({it.key == "account"+splitted[1]}).value})
                if (account == null) {
                    account = new MoodleAccount()
                    account.accountName = params.find({it.key == "account"+splitted[1]}).value
                    account.save flush:true
                    println "salvou uma nova moodleAccount = " + account.accountName
                }

                moo.addToAccounts(account)
                moo.save flush:true
            }
        }
    }
}
