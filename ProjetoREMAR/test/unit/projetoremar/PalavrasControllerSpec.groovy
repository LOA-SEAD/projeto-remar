package projetoremar



import grails.test.mixin.*
import spock.lang.*

@TestFor(PalavrasController)
@Mock(Palavras)
class PalavrasControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.palavrasInstanceList
            model.palavrasInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.palavrasInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def palavras = new Palavras()
            palavras.validate()
            controller.save(palavras)

        then:"The create view is rendered again with the correct model"
            model.palavrasInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            palavras = new Palavras(params)

            controller.save(palavras)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/palavras/show/1'
            controller.flash.message != null
            Palavras.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def palavras = new Palavras(params)
            controller.show(palavras)

        then:"A model is populated containing the domain instance"
            model.palavrasInstance == palavras
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def palavras = new Palavras(params)
            controller.edit(palavras)

        then:"A model is populated containing the domain instance"
            model.palavrasInstance == palavras
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/palavras/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def palavras = new Palavras()
            palavras.validate()
            controller.update(palavras)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.palavrasInstance == palavras

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            palavras = new Palavras(params).save(flush: true)
            controller.update(palavras)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/palavras/show/$palavras.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/palavras/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def palavras = new Palavras(params).save(flush: true)

        then:"It exists"
            Palavras.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(palavras)

        then:"The instance is deleted"
            Palavras.count() == 0
            response.redirectedUrl == '/palavras/index'
            flash.message != null
    }
}
