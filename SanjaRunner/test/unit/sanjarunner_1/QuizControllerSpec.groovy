package sanjarunner_1



import spock.lang.*

@TestFor(QuizController)
@Mock(Quiz)
class QuizControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.quizInstanceList
            model.quizInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.quizInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def quiz = new Quiz()
            quiz.validate()
            controller.save(quiz)

        then:"The create view is rendered again with the correct model"
            model.quizInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            quiz = new Quiz(params)

            controller.save(quiz)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/quiz/show/1'
            controller.flash.message != null
            Quiz.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def quiz = new Quiz(params)
            controller.show(quiz)

        then:"A model is populated containing the domain instance"
            model.quizInstance == quiz
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def quiz = new Quiz(params)
            controller.edit(quiz)

        then:"A model is populated containing the domain instance"
            model.quizInstance == quiz
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/quiz/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def quiz = new Quiz()
            quiz.validate()
            controller.update(quiz)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.quizInstance == quiz

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            quiz = new Quiz(params).save(flush: true)
            controller.update(quiz)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/quiz/show/$quiz.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/quiz/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def quiz = new Quiz(params).save(flush: true)

        then:"It exists"
            Quiz.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(quiz)

        then:"The instance is deleted"
            Quiz.count() == 0
            response.redirectedUrl == '/quiz/index'
            flash.message != null
    }
}
