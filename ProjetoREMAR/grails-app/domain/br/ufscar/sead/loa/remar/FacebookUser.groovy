package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.remar.User

class FacebookUser {

    Long uid
    String accessToken
    Date accessTokenExpires

    static belongsTo = [user: User]

    static constraints = {
        uid unique: true
    }
}
