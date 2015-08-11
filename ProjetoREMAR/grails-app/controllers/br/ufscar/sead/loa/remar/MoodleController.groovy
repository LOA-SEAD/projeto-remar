package br.ufscar.sead.loa.remar
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
import groovy.json.JsonBuilder

class MoodleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def save(Moodle moodle) {
        moodle.installedAt = new Date()

        /*if (moodle == null) {
            notFound()
            return
        }*/

        /*if (moodle.hasErrors()) {
            println("Someone tried to install the REMAR plugin in his/her moodle but it didn't worked:")
            println(moodle.errors)
        }*/

        moodle.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'moodle.label', default: 'Moodle'), moodle.id])
                redirect moodle
            }
            '*' { respond moodle, [status: CREATED] }
        }
    }

    def remove(String domain) {
        Moodle moodleToDelete = Moodle.where {
            active == true && domain == domain
        }.list().first()

        if(domain == null || moodleToDelete == []) {
            def str = 'Someone tried to uninstall the REMAR plugin of his/her moodle ("'+domain+'") but it wasn\'t found or have been deleted already.'
            render str
        }

        moodleToDelete.active = false
        moodleToDelete.save flush:true

        render 'Moodle "'+domain+'" successfully deleted.'

        /*if (moodle.hasErrors()) {
            print "Someone tried to uninstall the REMAR plugin of his/her moodle but it didn't worked: "
            println moodle.errors as JSON
        }*/
    }

    def moodleGameList(String domain) {
        //def moodle = Moodle.findByDomain(domain).Where(active)
        def moodle = Moodle.where {
            active == true && domain == domain
        }.list()
        if (moodle != []) {
            /* list of games published only for moodle */
            def plat = Platform.findByName("Moodle")
            def list = ExportedGame.findAll()

            Iterator i = list.iterator();
            while (i.hasNext()) {
                def n = i.next()

                if (plat in n.platforms == false) {
                    i.remove()
                }
                else {
                    Iterator acci = n.accounts.iterator();
                    def del = true;

                    while(acci.hasNext()) {
                        def localAcc = acci.next()
                        if(localAcc.owner.domain == domain) {
                            del = false;
                        }
                        else {
                            acci.remove()
                        }
                    }

                    if(del) {
                        i.remove();
                    }
                }
            }

            def builder = new JsonBuilder()

            def json = builder (
                "games": list.collect {p ->
                    [
                        "id": p.id,
                        "height": p.height,
                        "width": p.width,
                        "image": p.image,
                        "moodleUrl": p.moodleUrl,
                        "name": p.name,
                        "accounts": p.accounts.collect {a ->
                            [
                                "accountName": a.accountName,
                                "id": a.id
                            ]
                        }
                    ]
                }
            )

            render json as JSON
        }
        else {
            render 'O moodle "'+domain+'" foi desinstalado ou não existe.'
        }
    }
}
