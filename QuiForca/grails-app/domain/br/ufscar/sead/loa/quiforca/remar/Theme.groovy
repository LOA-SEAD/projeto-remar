package br.ufscar.sead.loa.quiforca.remar

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
