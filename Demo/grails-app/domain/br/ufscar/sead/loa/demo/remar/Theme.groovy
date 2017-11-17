package br.ufscar.sead.loa.demo.remar

class Theme {

    long ownerId
    long taskId

    static constraints = {
        ownerId blank: false, nullable: false
        taskId nullable: true
    }
}
