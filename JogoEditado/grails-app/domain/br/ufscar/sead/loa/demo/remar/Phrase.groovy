package br.ufscar.sead.loa.demo.remar

class Phrase {

    String content
    String author
    long ownerId
    String taskId

    static constraints = {
        content blank: false, maxSize: 250
        author blank: false
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}