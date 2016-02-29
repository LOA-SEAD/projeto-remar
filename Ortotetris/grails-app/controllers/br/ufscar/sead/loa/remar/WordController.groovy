package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import groovy.json.JsonBuilder
@Secured(["ROLE_USER","ROLE_ADMIN","ROLE_FACEBOOK"])

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
            wordInstance.save flush:true
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]

        }
        else {
            render template: 'message', model: [WordMessage: "Não foi possível realizar a operação"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
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
            wordInstance.save flush:true
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }
        else {
            render template: 'message', model: [WordMessage: "Não foi possível realizar a operação"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }
    }//move word para a direita

    @Transactional
    def mark_letter(int id, int pos) {
        Word wordInstance = Word.findById(id)
        String position_text = pos
        int position = position_text.toInteger()
        if ((position-1 >= wordInstance.getInitial_position()) && (position-1 <= wordInstance.getInitial_position() + wordInstance.getAnswer().length()-1) ) {
            String h_char = "" + wordInstance.getWord().charAt(position-1);
            if(validate_hide_letter(h_char)) {
                String aux
                if(h_char=="H" && wordInstance.getWord().charAt(position-2).toUpperCase()=='C') //caso a letra escondida seja "H" é necessário esconder a letra "C" que a antecede
                {
                    aux = wordInstance.getWord().substring(0, position - 2)
                    aux += ("00")
                }
                else
                {
                    if(h_char!="H" || wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position() - 2).toUpperCase()=="C"){
                        aux = wordInstance.getWord().substring(0, position - 1)
                        aux += ("0")
                    }
                    else{
                        render template: 'message', model: [WordMessage: "Escolha um caracter válido"]
                        render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
                        return ;
                    }
                }

                aux += (wordInstance.getWord().substring(position, 10))
                wordInstance.setWord(aux)
                wordInstance.save flush: true
                render template: 'message', model: [WordMessage: "Caracter oculto com sucesso"]
                render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName: "Word"]
            }
            else {
                render template: 'message', model: [WordMessage: "Escolha um caracter válido"]
                render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
            }
        }
        else {
            render template: 'message', model: [WordMessage: "Escolha uma posição válida"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }


    }//marca o caractere como '0' (esconde o caractere)

    @Transactional
    def clear_position() {
        Word wordInstance = Word.findById(params.id)
        String position_text = params.pos
        int position = position_text.toInteger()
        String clear_char = "" + wordInstance.getAnswer().charAt(position-wordInstance.initial_position-1);
        clear_char=clear_char.toUpperCase()
        if ((position-1 >= wordInstance.getInitial_position()) && (position-1 <= wordInstance.getInitial_position() + wordInstance.getAnswer().length()-1)) {
            String aux
            aux = wordInstance.getWord().substring(0, position - 1)
            if(clear_char=="C" && wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position()).toUpperCase()=='H'){
                //caso a letra "C" seja limpa é necessário verificar se a letra sucessora é "H", em caso positivo é necessáiro limpar a mesma também
                aux += (wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position() - 1).toUpperCase())
                aux += (wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position()).toUpperCase())
                aux += ((wordInstance.getWord().substring(position+1, 10)))
            }
            else{
                aux += (wordInstance.getAnswer().charAt(position - wordInstance.getInitial_position() - 1).toUpperCase())
                aux += ((wordInstance.getWord().substring(position, 10)))
            }


            wordInstance.setWord(aux)
            wordInstance.save flush:true
            render template: 'message', model: [WordMessage: "Operação realizada com sucesso"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }
        else {
            render template: 'message', model: [WordMessage: "Escolha uma posição válida"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }


    }//acessa answer e recupera o caractere que havia sido escondido

    @Transactional
    def editWord(){
        Word wordInstance = Word.findById(params.id)
        if(Word.findByAnswer(params.new_answer)==null){
            if(validate_form_answer(params.new_answer)){
            wordInstance.setAnswer(params.new_answer)
            initialize_word(wordInstance)
            wordInstance.save flush: true
            render template: 'message', model: [WordMessage: "Palavra atualizada com sucesso"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName: "Word"]
            }
            else{
                render template: 'message', model: [WordMessage: "A palavra possui um número de caracteres inválidos"]
                render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
            }
        }
        else {
            render template: 'message', model: [WordMessage: "A palavra já está no banco"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]
        }

    }

    @Transactional
    def WordDelete(){
        Word wordInstance = Word.findById(params.id)
        wordInstance.delete flush: true
        render template: 'message', model: [WordMessage: "Palavra deletada com sucesso"]
        render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll()]

    }

    def validate_form_answer(String new_answer) {
        if (new_answer.length()>10 || new_answer.length()<1)
            return false
        else
            return true

    }

    def validate_hide_letter(String hide_letter){
        String test_letter=hide_letter.toUpperCase();

        switch (test_letter){
            case "S":
                return true;
            case "C":
                return true;
            case "Z":
                return true;
            case "Ç":
                return true;
            case "H":
                return true;
            case "X":
                return true;
            default:
                return false;
        }



    }

    def toJson() {
        def list = Word.getAll(params.ids.split(',').toList())
        def fileName = "gabaritos.txt"
        def fileName2 = "palavras.txt"

        int count = 0;
        int count2= 0;


        File file = new File("$fileName");
        File file2 = new File("$fileName2");

        PrintWriter pw = new PrintWriter(file);
        pw.write("{\n \t\"c2array\": true,\n\t\"size\":[" + list.size() +",1,1],\n\t\"data\":[\n\t\t    ")
        for(int i=0;i<list.size()-1;i++) {
            pw.write("[[\"" + list[i].getAnswer().toUpperCase() + "\"]],")
            count++
            if(count==14)
            {
                count=0;
                pw.write("\n            ")
            }
        }
        pw.write("[[\""+list[list.size()-1].getAnswer().toUpperCase()+"\"]]\n\t       ]")
        pw.write("\n}")
        pw.close();

        PrintWriter pw2 = new PrintWriter(file2);
        pw2.write("{\n \t\"c2array\": true,\n\t\"size\":[" + list.size() +",1,1],\n\t\"data\":[\n\t\t    ")
        for(int i=0;i<list.size()-1;i++) {
            pw2.write("[[\"" + list[i].getWord() + "\"]],")
            count2++
            if(count2==14)
            {
                count2=0;
                pw2.write("\n            ")
            }
        }
        pw2.write("[[\""+list[list.size()-1].getWord()+"\"]]\n\t       ]")
        pw2.write("\n}")
        pw2.close();

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
            render template: 'message', model: [WordMessage: "A palavra possui erros"]
            render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]

            return
        }

        initialize_word(wordInstance) //inicializa a word conforme a answer passada como parâmetro

        wordInstance.save flush:true
        render template: 'message', model: [WordMessage: "Palavra criada com sucesso"]
        render template: 'list', model: [wordInstanceCount: Word.count(), wordInstanceList: Word.getAll(), entityName:"Word"]

//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'word.label', default: 'Word'), wordInstance.id])
//                redirect wordInstance
//            }
//            '*' { respond wordInstance, [status: CREATED] }
//        }
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
            respond wordInstance.errors, view:'index'
            return
        }

        if(edited)
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