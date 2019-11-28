package br.ufscar.sead.loa.santograuacessivel.remar

class FaseGaleria {
    String orientacao
    long themeId;

    long ownerId
    String taskId

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
