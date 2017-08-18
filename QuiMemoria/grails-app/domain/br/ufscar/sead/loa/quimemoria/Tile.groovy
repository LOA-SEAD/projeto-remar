package br.ufscar.sead.loa.quimemoria

class Tile {

    long ownerId
    int difficulty
    String taskId
    String content
    String description

    static mapping = {
        description type: "text"
    }

    static constraints = {
        ownerId     blank: false, nullable: false
        taskId      nullable: true
        content     blank: false, nullable: false
        description blank: false, nullable: false
        difficulty  blank: false, nullable: false, inList: [1, 2, 3]
    }
}
