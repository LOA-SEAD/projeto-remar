package br.ufscar.sead.loa.escolamagica.remar

class Theme {

    long ownerId
    String taskId

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
