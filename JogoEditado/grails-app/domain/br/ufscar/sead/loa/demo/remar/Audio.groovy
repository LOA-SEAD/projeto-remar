package br.ufscar.sead.loa.demo.remar

class Audio {

    String nome
    String author
    long ownerId
    String taskId

    static constraints = {
        nome nullable: true, maxSize: 250
        author nullable: false
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
