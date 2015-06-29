package br.ufscar.sead.loa.quiforca.remar

class Word {

    static constraints = {
       answer (unique: true, matches: /[a-zA-Z|Ç|ç]{1,10}/, blank: false, nullable: false)
       word (blank: false, nullable: false)
       initial_position (blank:false, nullable:false)
    }

    String answer
    String word
    int initial_position


    void mark_letter(int position) {
        if (position-1 >= initial_position && position-1 <= initial_position + answer.length()-1) {
            String aux;
            aux = word.substring(0, position-1);
            aux+=("0");
            aux+=(word.substring(position, 10));
            word = aux;

        }
    }//marca o caractere como '0' (esconde o caractere)

    void clear_position(int position) {
        if (position-1 >= initial_position && position-1 <= initial_position + answer.length()-1) {
            String aux;
            aux = word.substring(0, position-1);
            aux+=(answer.charAt(position - initial_position-1));
            aux+=((word.substring(position, 10)));
            word = aux;
        }
    }//acessa answer e recupera o caractere que havia sido escondido



}

