package br.ufscar.sead.loa.demo.remar



import grails.test.mixin.*
import spock.lang.*

@TestFor(AudioController)
@Mock(Audio)
class AudioControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.audioInstanceList
            model.audioInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.audioInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def audio = new Audio()
            audio.validate()
            controller.save(audio)

        then:"The create view is rendered again with the correct model"
            model.audioInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            audio = new Audio(params)

            controller.save(audio)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/audio/show/1'
            controller.flash.message != null
            Audio.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def audio = new Audio(params)
            controller.show(audio)

        then:"A model is populated containing the domain instance"
            model.audioInstance == audio
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def audio = new Audio(params)
            controller.edit(audio)

        then:"A model is populated containing the domain instance"
            model.audioInstance == audio
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/audio/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def audio = new Audio()
            audio.validate()
            controller.update(audio)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.audioInstance == audio

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            audio = new Audio(params).save(flush: true)
            controller.update(audio)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/audio/show/$audio.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/audio/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def audio = new Audio(params).save(flush: true)

        then:"It exists"
            Audio.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(audio)

        then:"The instance is deleted"
            Audio.count() == 0
            response.redirectedUrl == '/audio/index'
            flash.message != null
    }
}
