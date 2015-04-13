package escolamagica

import groovy.xml.MarkupBuilder
import groovy.xml.StreamingMarkupBuilder
import groovy.xml.XmlUtil
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['ROLE_PROF'])
@Transactional(readOnly = true)
class PerguntasController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Perguntas.list(params), model:[perguntasInstanceCount: Perguntas.count()]

    }

    def show(Perguntas perguntasInstance) {
        respond perguntasInstance

        //println Perguntas.findAllByClasse("1").get(0).getAlternativas()
       // println Perguntas.findAllByClasse("3")



    }


    def createXML(){

        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath("/")


        def fw = new FileWriter(storagePath+"perguntas.xml")
        //def xml = new MarkupBuilder(xmlObj)
        def xml = new groovy.xml.MarkupBuilder(fw)
        xml.mkp.xmlDeclaration(version: "1.0",encoding: "utf-8")
        xml.Perguntas(){
            for(int i=0; i<4; i++){
                def listaPerguntas = Perguntas.findAllByClasse(i+1)
                if(!listaPerguntas.isEmpty()) {
                    int j=0
                    int k=0
                    int l=0
                    Classe(ClaAno: i+1) {
                        while (!listaPerguntas.isEmpty()) {
                            Pergunta(PergNum: k, respCorreta: listaPerguntas.get(l).getRespCorreta(), titulo:listaPerguntas.get(j)) {
                                Resp(num:'0',listaPerguntas.get(l).getAlternativas()[0])
                                Resp(num:'1',listaPerguntas.get(l).getAlternativas()[1])
                                Resp(num:'2',listaPerguntas.get(l).getAlternativas()[2])
                                Resp(num:'3',listaPerguntas.get(l).getAlternativas()[3])
                            }
                            listaPerguntas.remove(j)
                            k++
                        }

                    }
                }

            }

        }

    }




    def create() {
        respond new Perguntas(params)
    }

    def verifyCheckbox(perguntasInstance){
        for(int i=0; i<4; i++) {
            String alternativa = request.getParameter("alt"+i)
            if (alternativa.equals("on")) {
                perguntasInstance.setRespCorreta(i)
            }

        }

    }

    @Transactional
    def save(Perguntas perguntasInstance) {
        if (perguntasInstance == null) {
            notFound()
            return
        }



        if (perguntasInstance.hasErrors()) {
            respond perguntasInstance.errors, view:'create'
            return
        }

        verifyCheckbox(perguntasInstance)

        perguntasInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'perguntas.label', default: 'Perguntas'), perguntasInstance.id])
                redirect perguntasInstance
            }
            '*' { respond perguntasInstance, [status: CREATED] }
        }
    }

    def edit(Perguntas perguntasInstance) {
        respond perguntasInstance
    }

    @Transactional
    def update(Perguntas perguntasInstance) {
        if (perguntasInstance == null) {
            notFound()
            return
        }

        if (perguntasInstance.hasErrors()) {
            respond perguntasInstance.errors, view:'edit'
            return
        }

        perguntasInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Perguntas.label', default: 'Perguntas'), perguntasInstance.id])
                redirect perguntasInstance
            }
            '*'{ respond perguntasInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Perguntas perguntasInstance) {

        if (perguntasInstance == null) {
            notFound()
            return
        }

        perguntasInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Perguntas.label', default: 'Perguntas'), perguntasInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'perguntas.label', default: 'Perguntas'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
