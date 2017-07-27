package br.ufscar.sead.loa.quimemoria.remar

class Tile {

    long ownerId
    String taskId

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
