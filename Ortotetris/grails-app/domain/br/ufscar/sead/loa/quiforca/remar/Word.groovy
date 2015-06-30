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
}

