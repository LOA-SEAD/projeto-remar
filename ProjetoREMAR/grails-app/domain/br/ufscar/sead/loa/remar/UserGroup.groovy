package br.ufscar.sead.loa.remar

class UserGroup {

    static belongsTo = [user:User,group:Group]



    static constraints = {
    }
}
