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

    def moodleGameList(String domain) {
        def moodle = Moodle.findByDomain(domain)
        
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
            list.collect {p ->
                [
                    "id": p.id,
                    "height": p.height,
                    "width": p.width,
                    "image": p.image,
                    "moodleUrl": p.moodleUrl,
                    "name": p.name,
                    "accounts": p.accounts.collect {a ->
                        [
                            "name": a.accountName,
                            "id": a.id
                        ]
                    }
                ]
            }
        )

        render json as JSON
        

        /*MoodleAccount.find({accountName == accName && owner.domain == moo.domain})

        def accs = moodle.accounts
        println accs

        def ret = [:]
        ret["games"] = l
        ret["accounts"] = accs

        render ret as JSON*/
    }
}
