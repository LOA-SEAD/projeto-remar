package br.ufscar.sead.loa.memoriaacessivel

class Tile {

    long ownerId
    String textA
    String textB

    static constraints = {
        ownerId     blank: false, nullable: false
        textA       blank: false, nullable: false
        textB       blank: false, nullable: false
    }
}
