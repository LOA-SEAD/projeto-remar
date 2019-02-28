package br.ufscar.sead.loa.memoria

class Tile {

    long ownerId
    String textA
    String textB
    String description

    static mapping = {
        description type: "text"
    }

    static constraints = {
        ownerId     blank: false, nullable: false
        textA       blank: false, nullable: false
        textB       blank: false, nullable: false
        description blank: false, nullable: false
    }
}
