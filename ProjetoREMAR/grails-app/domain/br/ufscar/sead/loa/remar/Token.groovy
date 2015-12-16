package br.ufscar.sead.loa.remar

class Token {

    static belongsTo = [owner: User]

    String token
    String type
    Date expiresAt = new Date() + 1

    static constraints = {}
}
