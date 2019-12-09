package br.ufscar.sead.loa.santograuacessivel.remar

class ThemeFaseGaleria {
    long ownerId
    String taskId
    int howManyImages

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
