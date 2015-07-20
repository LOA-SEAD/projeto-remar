package br.ufscar.sead.loa.remar
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class MoodleGameController {

    def save(MoodleGame moodlegame) {
        moodlegame.save flush:true
    }

    def gamePublishConfig() {
    	def moodleList = Moodle.list()
    	respond moodleList, model:[moodleList: moodleList]
    }
}
