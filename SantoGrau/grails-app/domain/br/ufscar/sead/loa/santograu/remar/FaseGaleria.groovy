package br.ufscar.sead.loa.santograu.remar

class FaseGaleria {
    String orientacao

    long ownerId
    String taskId

    static constraints = {
        orientacao blank:null
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
