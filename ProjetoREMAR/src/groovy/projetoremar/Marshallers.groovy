package projetoremar

/**
 * Created by matheus on 4/1/15.
 */
class Marshallers {

    List marshallers = []

    def register() {
        marshallers.each {
            it.register()
        }
    }
}
