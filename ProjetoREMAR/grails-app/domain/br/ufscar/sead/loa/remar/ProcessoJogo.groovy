package br.ufscar.sead.loa.remar

class ProcessoJogo {
    static belongsTo = [professor: User]

    String id_process_definition
    //String key_process_definition
    String id_process_instance
}
