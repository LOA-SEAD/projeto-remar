package br.ufscar.sead.loa.remar

class Level {

    static belongsTo = [resource: Resource]

    static constraints = {
        number nullable: false
        name nullable: false
    }

    int number
    String name

    String toString() {
        number + " - " + name
    }
}
