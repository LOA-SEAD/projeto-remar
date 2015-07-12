package br.ufscar.sead.loa.remar

class Game {

    static belongsTo = [owner: User]
    static hasMany = [platforms: Platform]

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
        bpmn nullable: false
    }

    String name
    boolean active
    int version
    String uri

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid
    String bpmn

}