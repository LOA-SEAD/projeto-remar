package br.ufscar.sead.loa.labteca.remar

class ThemeAnotacao {
    String informacao

    static constraints = {
        informacao (nullable: false)
    }

    @Override
    String toString() {
        return informacao
    }

}
