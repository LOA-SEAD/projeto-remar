package br.ufscar.sead.loa.remar

class ProcessGame {
    static belongsTo = [prof: User]

    String id_process_definition
    //String key_process_definition
    String id_process_instance
}
