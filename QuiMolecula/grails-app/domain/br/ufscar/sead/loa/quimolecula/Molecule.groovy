package br.ufscar.sead.loa.quimolecula

class Molecule {

    String name
    String structure
    String tip
    String author
    String xml

    long ownerId
    String taskId

    static mapping = {
        xml type: 'text'
    }

    static constraints = {
        name blank: false, maxSize: 150
        structure blank: false, maxSize: 64
        tip blank: true, maxSize: 255
        author blank: false
        ownerId blank: false, nullable: false
        taskId nullable: true
        xml blank: false, nullable: false
    }
}
