package br.ufscar.sead.loa.labteca.remar

class Composto {

    public static final String SAL = "Sal"
    public static final String BASE = "Base"
    public static final String ACIDO = "Ácido"
    public static final String ORGANICO = "Orgânico"
    public static final String ETC = "Etc"

    static constraints = {
        nome (unique: true)
        formula (nullable: false)
        tipo (nullable: false, inList: [SAL, BASE, ACIDO, ORGANICO, ETC])
    }

    String nome
    String formula
    String tipo

    String toString() {
        return nome + ' - ' + formula
    }
}
