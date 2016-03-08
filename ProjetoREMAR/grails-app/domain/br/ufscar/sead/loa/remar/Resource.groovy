package br.ufscar.sead.loa.remar

class Resource {

    static belongsTo = [owner: User]

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
        moodle defaultValue: false
        android defaultValue: false
        linux defaultValue: false
        width nullable: true
        height nullable: true
        description nullable: true, maxSize: 1000
        pending nullable: true
    }

    String name
    boolean active
    int version
    String uri

    boolean android
    boolean linux
    boolean moodle

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid

    int width
    int height

    String description
    boolean pending
}