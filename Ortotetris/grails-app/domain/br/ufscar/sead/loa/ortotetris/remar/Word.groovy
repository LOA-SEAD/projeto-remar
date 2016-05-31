package br.ufscar.sead.loa.ortotetris.remar

import br.ufscar.sead.loa.remar.User

class Word {

    static constraints = {
       answer (unique: true, matches: /[a-zA-Z|ç|á|à|ã|â|é|è|ẽ|ê|í|ì|ĩ|î|ó|ò|õ|ô|ú|ù|ũ|û|Ç|Á|À|Ã|Â|É|È|Ẽ|Ê|Í|Ì|Ĩ|Î|Ó|Ò|Õ|Ô|Ú|Ù|Ũ|Û]{1,10}/, blank: false, nullable: false)
       word (blank: false, nullable: false)
       initial_position (blank:false, nullable:false)
    }

    String answer
    String word = "none"
    int initial_position = 0
    long ownerId
}

