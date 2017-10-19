package br.ufscar.sead.loa.sanjarunner.remar

class PergaminhoCassiano {

    String[] information = new String[5]

    long ownerId
    String taskId

    static mapping = {
        information sqlType: 'blob'
    }

    static constraints = {
        information (blank : false, size: 5..3000)
    }
}
