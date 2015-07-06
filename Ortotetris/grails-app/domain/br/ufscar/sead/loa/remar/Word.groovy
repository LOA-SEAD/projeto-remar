package br.ufscar.sead.loa.remar

class Word {

    static constraints = {
       answer (unique: true, matches: /[a-z|ç|á|à|ã|â|é|è|ẽ|ê|í|ì|ĩ|î|ó|ò|õ|ô|ú|ù|ũ|û]{1,10}/, blank: false, nullable: false)
       word (blank: false, nullable: false)
       initial_position (blank:false, nullable:false)
    }

    String answer
    String word
    int initial_position
}

