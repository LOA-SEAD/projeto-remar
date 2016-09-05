package br.ufscar.sead.loa.santograu.remar



import grails.test.mixin.*
import spock.lang.*

@TestFor(FaseBlocoGeloController)
@Mock(QuestionFaseBlocoGelo)
class FaseBlocoGeloControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.faseBlocoGeloInstanceList
            model.faseBlocoGeloInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.faseBlocoGeloInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def faseBlocoGelo = new QuestionFaseBlocoGelo()
            faseBlocoGelo.validate()
            controller.save(faseBlocoGelo)

        then:"The create view is rendered again with the correct model"
            model.faseBlocoGeloInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            faseBlocoGelo = new QuestionFaseBlocoGelo(params)

            controller.save(faseBlocoGelo)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/faseBlocoGelo/show/1'
            controller.flash.message != null
            QuestionFaseBlocoGelo.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def faseBlocoGelo = new QuestionFaseBlocoGelo(params)
            controller.show(faseBlocoGelo)

        then:"A model is populated containing the domain instance"
            model.faseBlocoGeloInstance == faseBlocoGelo
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def faseBlocoGelo = new QuestionFaseBlocoGelo(params)
            controller.edit(faseBlocoGelo)

        then:"A model is populated containing the domain instance"
            model.faseBlocoGeloInstance == faseBlocoGelo
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/faseBlocoGelo/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def faseBlocoGelo = new QuestionFaseBlocoGelo()
            faseBlocoGelo.validate()
            controller.update(faseBlocoGelo)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.faseBlocoGeloInstance == faseBlocoGelo

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            faseBlocoGelo = new QuestionFaseBlocoGelo(params).save(flush: true)
            controller.update(faseBlocoGelo)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/faseBlocoGelo/show/$faseBlocoGelo.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/faseBlocoGelo/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def faseBlocoGelo = new QuestionFaseBlocoGelo(params).save(flush: true)

        then:"It exists"
            QuestionFaseBlocoGelo.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(faseBlocoGelo)

        then:"The instance is deleted"
            QuestionFaseBlocoGelo.count() == 0
            response.redirectedUrl == '/faseBlocoGelo/index'
            flash.message != null
    }
}
