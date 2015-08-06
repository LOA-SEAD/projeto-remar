package br.ufscar.sead.loa.remar

class Game {

    static belongsTo = [owner: User]
    static hasMany = [platforms: Platform]

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
        bpmn nullable: true
        moodle nullable: true
        mobile nullable: true
        web nullable: true
        desktop nullable: true
    }

    String name
    boolean active
    int version
    String uri

    /*should we remove that?*/
    boolean moodle // Exportavel para o moodle
    boolean mobile
    boolean web
    boolean desktop

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid
    String bpmn

}