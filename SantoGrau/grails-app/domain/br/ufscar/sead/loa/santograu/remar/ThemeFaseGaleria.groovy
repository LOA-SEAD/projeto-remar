package br.ufscar.sead.loa.santograu.remar

class ThemeFaseGaleria {
    long ownerId
    String taskId

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
