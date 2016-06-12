package br.ufscar.sead.loa.remar

class UserGroup {

    static belongsTo = [user:User,group:Group]
    boolean admin

    UserGroup(){
        this.admin = false
    }

    static constraints = {
    }
}
