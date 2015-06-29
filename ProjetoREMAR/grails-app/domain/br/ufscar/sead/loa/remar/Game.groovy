package br.ufscar.sead.loa.remar

class Game {

    static belongsTo = [owner: User]
    static hasMany = [platforms: Platform]

    static constraints = {

    }

    String name
    boolean active
    int version
}