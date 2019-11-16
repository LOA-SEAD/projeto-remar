package br.ufscar.sead.loa.erainclusiva.remar

class Resource {

    String statement
    String answer
    String category
    String author

    long ownerId
    String taskId

    static constraints = {
        statement blank: false, maxSize: 150
        answer blank: false, maxSize: 48
        category blank: true
        author blank: false
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
