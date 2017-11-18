package br.ufscar.sead.loa.demo.remar

class Theme {

    long ownerId

    static constraints = {
        ownerId blank: false, nullable: false
    }
}
