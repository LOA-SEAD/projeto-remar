package br.ufscar.sead.loa.forcaacessivel.remar

class Theme {

    long ownerId
    long processId
    long taskId

    static constraints = {
        ownerId blank: false, nullable: false
        processId nullable: true
        taskId nullable: true
    }
}
