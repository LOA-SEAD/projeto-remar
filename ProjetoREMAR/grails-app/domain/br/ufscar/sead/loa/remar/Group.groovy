package br.ufscar.sead.loa.remar


class Group {

    static hasMany = [userGroups: UserGroup, groupExportedResources :GroupExportedResources]
//    static belongsTo = ExportedResource

    String name
    String token
    User owner

    static mapping = {
        table "group_"
//        owners column: "owners", joinTable: false
    }

    static constraints = {
        name blank: false
        token unique: true
    }
}
