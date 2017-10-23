package br.ufscar.sead.loa.remar

class Rating {

    static belongsTo = [user: User, resource: Resource]
    float stars
    String comment
    Date date

    static constraints = {
        stars nullable: false
        comment nullable: false
        date nullable: true
    }

}