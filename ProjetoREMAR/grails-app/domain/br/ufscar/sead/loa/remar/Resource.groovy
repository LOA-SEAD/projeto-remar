package br.ufscar.sead.loa.remar

class Resource {

    static belongsTo = [owner: User, category: Category]

    static hasMany = [ratings: Rating]

    static constraints = {
        submittedAt blank: false
        name blank: false
        type nullable: true, blank: true
        comment nullable: true, blank: true
        moodle defaultValue: false
        android defaultValue: false
        desktop defaultValue: false
        web defaultValue: false
        width nullable: true
        height nullable: true
        description nullable: true, maxSize: 1000
        info nullable: true, maxSize: 1000
        documentation nullable: true
        videoLink nullable: true
        pending nullable: true
        sumStars nullable: false
        sumUser nullable: false
        license nullable: false
        customizableItems nullable: true
        authorship nullable: true
    }

    Resource() {
        this.shareable = false;
        this.repository = true;
    }

    String name
    boolean active
    int version
    String uri
    String type
    String authorship

    boolean shareable
    boolean repository

    boolean android
    boolean desktop
    boolean web
    boolean moodle

    // deploy
    Date submittedAt
    String status
    String comment
    boolean valid

    int width
    int height

    String description
    String info
    String videoLink
    boolean pending
    String license
    String documentation
    String customizableItems

    float sumStars //total de estrelas
    int   sumUser  //total de usuários que comentaram o jogo

    boolean isMac() {
        // return type != 'unity'
        return false // depois resolver (electron não está gerando mac)
    }

    boolean isLinux() {
        return false // depois resolver (electron não está gerando linux)
    }
}