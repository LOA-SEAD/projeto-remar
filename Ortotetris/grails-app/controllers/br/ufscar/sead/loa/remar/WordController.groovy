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
        String aux = ""+wordInstance.getAnswer().toUpperCase()
        if (wordInstance.getAnswer().length() < 10) {
            for (int i = (10 - wordInstance.getAnswer().length()); i > 0; i--)
                aux+=("ì")
        }
        wordInstance.setWord(aux)
        wordInstance.setInitial_position(0)
    } //copia answer para word e completa word com 'ì' caso answer.lenght()<10

    @Transactional
    def move_to_left() {
        Word wordInstance = Word.findById(params.id)
        if (wordInstance.getWord().charAt(0) == 'ì') {
            String aux = wordInstance.getWord().substring(1, 10)
            aux += ("ì")
            wordInstance.setWord(aux)
            wordInstance.setInitial_position(wordInstance.getInitial_position() - 1)
            //update(wordInstance,false)
            wordInstance.save flush:true
            redirect(action: "index")
        }
        else
        {
            redirect(action: "index")
            //redirect(action: "show", id: params.id)
        }
    }//move word para a esquerda

    @Transactional
    def move_to_right() {
        Word wordInstance = Word.findById(params.id)
        if (wordInstance.getWord().charAt(9) == 'ì') {
            String aux = "ì"
            aux += (wordInstance.getWord().substring(0, 9))
            wordInstance.setWord(aux)
            wordInstance.setInitial_position(wordInstance.getInitial_position() + 1)
            //update(wordInstance,false)
            wordInstance.save flush:true
            redirect(action: "index")

        }
        else {
            redirect(action: "index")
            //redirect(action: "show", id: params.id)
        }
    }//move word para a direita

    @Transactional
    def mark_letter() {
        Word wordInstance = Word.findById(params.id)
        String teste = params.pos
        int position = teste.toInteger()
        if ((position-1 >= wordInstance.getInitial_position()) && (position-1 <= wordInstance.getInitial_position() + wordInstance.getAnswer().length()-1)) {
            String aux
            aux = wordInstance.getWord().substring(0, position - 1)
            aux += ("0")
            aux += (wordInstance.getWord().substring(position, 10))
            wordInstance.setWord(aux)
            wordInstance.save flush:true
            redirect(action: "index")
            //update(wordInstance,false)
        }
        else{
            redirect(action: "index")
            //redirect(action: "show", id: params.id)
        }

    }//marca o caractere como '0' (esconde o caractere)

    @Transactional
    def clear_position() {
        Word wordInstance = Word.findById(params.id)
        String teste = params.pos
        int position = teste.toInteger()
        if ((position-1 >= wordInstance.getInitial_position()) && (position-1 <= wordInstance.getInitial_position() + wordInstance.getAnswer().length()-1)) {
            String aux
            aux = wordInstance.getWord().substring(0, position - 1)
            aux += (wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position() - 1).toUpperCase())
            aux += ((wordInstance.getWord().substring(position, 10)))
            wordInstance.setWord(aux)
            wordInstance.save flush:true
            redirect(action: "index")
            //update(wordInstance,false)
        }
        else{
            redirect(action: "index")
            //redirect(action: "show", id: params.id)
        }

    }//acessa answer e recupera o caractere que havia sido escondido

    @Transactional
    def editWord(){
        Word wordInstance = Word.findById(params.id)
        wordInstance.setAnswer(params.new_answer)
        initialize_word(wordInstance)
        wordInstance.save flush:true
    }

    def toJsonAnswer() {
        def list = Word.getAll();
        def fileName = "gabarito.json"

        File file = new File("$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n \t\"c2array\": true,\n\t\"size\":[" + list.size() +",1,1],\n\t\"data\":[\n\t\t    ")
        for(int i=0;i<list.size()-1;i++)
            pw.write("[["+list[i].getAnswer().toUpperCase()+"]],")
        pw.write("[["+list[list.size()-1].getAnswer().toUpperCase()+"]]\n\t       ]")
        pw.write("\n}")
        pw.close();
        redirect action: "index"

    }

    def toJsonWord() {
        def list = Word.getAll();
        def fileName = "palavras.json"
        File file = new File("$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n \t\"c2array\": true,\n\t\"size\":[" + list.size() +",1,1],\n\t\"data\":[\n\t\t    ")
        for(int i=0;i<list.size()-1;i++)
            pw.write("[["+list[i].getWord()+"]],")
        pw.write("[["+list[list.size()-1].getWord()+"]]\n\t       ]")
        pw.write("\n}")
        pw.close();
        redirect action: "index"
    }


    def index(Integer max) {
        params.max = Math.min(max ?: 255, 1000)
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

        initialize_word(wordInstance) //inicializa a word conforme a answer passada como parâmetro

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
    def update(Word wordInstance, boolean edited) {
        if (wordInstance == null) {
            notFound()
            return
        }

        if (wordInstance.hasErrors()) {
            respond wordInstance.errors, view:'edit'
            return
        }

        if(edited==true)
            initialize_word(wordInstance)
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