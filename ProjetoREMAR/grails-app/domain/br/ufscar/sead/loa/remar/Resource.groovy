package br.ufscar.sead.loa.remar



class Resource {

    static belongsTo = [owner: User, category: Category]

    static hasMany = [ratings: Rating]

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
        moodle defaultValue: false
        android defaultValue: false
        desktop defaultValue: false
        width nullable: true
        height nullable: true
        description nullable: true, maxSize: 1000
        pending nullable: true
        sumStars nullable: false
        sumUser nullable: false
    }

    String name
    boolean active
    int version
    String uri

    boolean android
    boolean desktop
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

    float sumStars //total de estrelas
    int   sumUser  //total de usuários que comentaram o jogo
}