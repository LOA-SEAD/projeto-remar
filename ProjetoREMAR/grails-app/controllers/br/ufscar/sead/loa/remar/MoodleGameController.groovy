package br.ufscar.sead.loa.remar
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class MoodleGameController {

    def save(MoodleGame moodlegame) {

    	if (moodlegame.hasErrors()) {
    		println("Someone tried to register a new moodlegame but it doesn't worked:")
    		println(moodlegame.errors)
    	}
    	else {
        	moodlegame.save flush:true

        	redirect controller: "index", action: "dashboard"
    	}


    }

    def gamePublishConfig() {
    	def moodleList = Moodle.list()
    	respond moodleList, model:[moodleList: moodleList]
    }
}
