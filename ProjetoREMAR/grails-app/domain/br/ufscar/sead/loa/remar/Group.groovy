package br.ufscar.sead.loa.remar

/**
 * Created by deniscapp on 5/17/16.
 */
class Group {

    static hasMany = [userGroups: UserGroup]
//    static belongsTo = User

//    User owner;
//    User owner
    ArrayList<User> owners
    String name
    String privacy

    static mapping = {
        table "group_"
    }

    static constraints = {
        name blank: false
    }
}
