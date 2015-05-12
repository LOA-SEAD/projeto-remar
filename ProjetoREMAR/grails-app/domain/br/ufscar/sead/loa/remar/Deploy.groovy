package br.ufscar.sead.loa.remar

class Deploy {
    static belongsTo = [desenvolvedor: User]

    static constraints = {
        data_deploy (blank: false)
    }

    Date data_deploy
    String id_deploy
    String war_filename
}
