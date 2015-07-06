package br.ufscar.sead.loa.remar


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import groovy.json.JsonBuilder

@Transactional(readOnly = true)
class WordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /* Funções que manipulam word e answer */
    def initialize_word(Word wordInstance){
        String aux = ""+wordInstance.getAnswer()
        if (wordInstance.getAnswer().length() < 10) {
            for (int i = (10 - wordInstance.getAnswer().length()); i > 0; i--)
                aux+=("ì")
        }
        wordInstance.setWord(aux)
        wordInstance.setInitial_position(0)
    } //copia answer para word e completa word com 'ì' caso answer.lenght()<10

    @Transactional
    def move_to_left() {
        if (Word.findById(params.id).getWord().charAt(0) == 'ì') {
            String aux = Word.findById(params.id).getWord().substring(1, 10)
            aux+=("ì")
            Word.findById(params.id).setWord(aux)
            Word.findById(params.id).setInitial_position(Word.findById(params.id).getInitial_position()-1)
            update(Word.findById(params.id))
        }
        else
            redirect(action: show(Word.findById(params.id)))
    }//move word para a esquerda

    @Transactional
    def move_to_right() {
        if (Word.findById(params.id).getWord().charAt(9) == 'ì') {
            String aux = "ì"
            aux+=(Word.findById(params.id).getWord().substring(0, 9))
            Word.findById(params.id).setWord(aux)
            Word.findById(params.id).setInitial_position(Word.findById(params.id).getInitial_position()+1)
            update(Word.findById(params.id))
        }
        else
            redirect(action: show(Word.findById(params.id)))
    }//move word para a direita

    @Transactional
    def mark_letter() {
        String teste = params.pos
        int position = teste.toInteger()
        if ((position-1 >= Word.findById(params.id).getInitial_position()) && (position-1 <= Word.findById(params.id).getInitial_position() + Word.findById(params.id).getAnswer().length()-1)) {
            String aux
            aux = Word.findById(params.id).getWord().substring(0, position-1)
            aux+=("0")
            aux+=(Word.findById(params.id).getWord().substring(position, 10))
            Word.findById(params.id).setWord(aux)
            update(Word.findById(params.id))
        }
        else
            redirect(action: show(Word.findById(params.id)))
    }//marca o caractere como '0' (esconde o caractere)

    @Transactional
    def clear_position() {
        String teste = params.pos
        int position = teste.toInteger()
        if ((position-1 >= Word.findById(params.id).getInitial_position()) && (position-1 <= Word.findById(params.id).getInitial_position() + Word.findById(params.id).getAnswer().length()-1)) {
            String aux
            aux = Word.findById(params.id).getWord().substring(0, position-1)
            aux+=(Word.findById(params.id).getAnswer().charAt(position - Word.findById(params.id).getInitial_position()-1))
            aux+=((Word.findById(params.id).getWord().substring(position, 10)))
            Word.findById(params.id).setWord(aux)
            update(Word.findById(params.id))
        }
        else
            redirect(action: show(Word.findById(params.id)))
    }//acessa answer e recupera o caractere que havia sido escondido

    def toJsonWord() {
        def list = Word.getAll();
        //def list = Word.getAll(params.id? params.id.split(',').toList() : null)
        def builder = new JsonBuilder()
        def json = builder (
                list.collect {p ->
                     [[p.getAnswer().toUpperCase()]]
                }
        )

        render builder.toString()
        def dataPath = servletContext.getRealPath("/data")


        def fileName = "ortotetris.json"

        File file = new File("$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n \t\"c2array\": true,\n\t\"size\":[" + list.size() +",1,1],\n\t\"data\":[\n")
        pw.write(builder.toString());
        pw.write("\n}")
        pw.close();

    }


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Word.list(params), model:[wordInstanceCount: Word.count()]
    }

    def show(Word wordInstance) {
        respond wordInstance
    }

    def create() {
        respond new Word(params)
    }

    @Transactional
    def save(Word wordInstance) {
        if (wordInstance == null) {
            notFound()
            return
        }

        if (wordInstance.hasErrors()) {
            respond wordInstance.errors, view:'create'
            return
        }

        initialize_word(wordInstance)

        wordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'word.label', default: 'Word'), wordInstance.id])
                redirect wordInstance
            }
            '*' { respond wordInstance, [status: CREATED] }
        }
    }

    def edit(Word wordInstance) {
        respond wordInstance
    }

    @Transactional
    def update(Word wordInstance) {
        if (wordInstance == null) {
            notFound()
            return
        }

        if (wordInstance.hasErrors()) {
            respond wordInstance.errors, view:'edit'
            return
        }

        wordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Word.label', default: 'Word'), wordInstance.id])
                redirect wordInstance
            }
            '*'{ respond wordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Word wordInstance) {

        if (wordInstance == null) {
            notFound()
            return
        }

        wordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Word.label', default: 'Word'), wordInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'word.label', default: 'Word'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
