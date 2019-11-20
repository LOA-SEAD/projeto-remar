package br.ufscar.sead.loa.memoriaacessivel

class Tile {

    long ownerId
    String textA
    String textB
    String description

    static constraints = {
        ownerId     blank: false, nullable: false
        textA       blank: false, nullable: false
        textB       blank: false, nullable: false
    }

    static final int FACIL = 4;
    static final int MEDIO = 6;
    static final int DIFICIL = 8;
}
