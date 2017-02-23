package br.ufscar.sead.loa.labteca.remar

class Desafio {

    static constraints = {
        volInicial(nullable: false)
        volFinal(nullable: false)
        molInicial(nullable: false)
        molFinal(nullable: false)
    }

    Composto composto
    double volInicial       // Volume do composto na solução dada pelo desafio
    double volFinal         // Volume do composto na solução a ser feita pelo jogador
    double molInicial       // Molaridade do composto na solução dada pelo desafio
    double molFinal         // Molaridade do composto na solução a ser feita pelo jogador
}
