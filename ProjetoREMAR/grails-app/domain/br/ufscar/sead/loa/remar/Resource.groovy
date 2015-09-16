package br.ufscar.sead.loa.remar

class Resource {

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
        files nullable: true
        width nullable: true
        height nullable: true
        moodleJson nullable: true
    }

    String name
    boolean active
    int version
    String uri

    boolean web
    boolean android
    boolean linux
    boolean moodle
    String files

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid
    String bpmn

    int width
    int height
    String moodleJson
}