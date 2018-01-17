package br.ufscar.sead.loa.remar

class Platform {

    static constraints = {
        name(maxSize:50)
    }

    String name

    String toString() {
        return name
    }
}
