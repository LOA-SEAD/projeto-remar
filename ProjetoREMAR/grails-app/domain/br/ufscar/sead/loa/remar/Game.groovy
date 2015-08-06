package br.ufscar.sead.loa.remar

class Game {

    static belongsTo = [owner: User]

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
        bpmn nullable: true
        moodle defaultValue: false
        android defaultValue: false
        web defaultValue: true
        linux defaultValue: false
    }

    String name
    boolean active
    int version
    String uri

    boolean web
    boolean android
    boolean linux
    boolean moodle

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid
    String bpmn

}