package br.ufscar.sead.loa.remar

/**
 * Created by deniscapp on 5/17/16.
 */
class Group {

    static hasMany = [userGroups: UserGroup, owners: User]
//    static belongsTo = User

    String name
    String privacy

    static mapping = {
        table "group_"
//        owners column: "owners", joinTable: false
    }

    static constraints = {
        name blank: false
        privacy blank: false
    }
}
