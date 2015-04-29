package br.ufscar.sead.loa.quiforca.remar

class Theme {

    long ownerId

    static constraints = {
        ownerId blank: false, nullable: false
    }
}
