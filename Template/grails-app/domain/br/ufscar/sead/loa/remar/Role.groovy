package br.ufscar.sead.loa.remar

class Role {

    String authority

    static mapping = {
        cache false
        datasource 'remar'
    }

    static constraints = {
        authority blank: false, unique: true
    }
}