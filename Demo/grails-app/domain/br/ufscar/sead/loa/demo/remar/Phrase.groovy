package br.ufscar.sead.loa.demo.remar

class Phrase {

    String content
    
    long ownerId
    String taskId

    static constraints = {
        content blank: false, maxSize: 150
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
