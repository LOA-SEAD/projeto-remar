package br.ufscar.sead.loa.labteca.remar

class Anotacao {

    static constraints = {
        informacao (nullable: false)
    }

    String informacao

    @Override
    String toString() {
        return informacao
    }
}


