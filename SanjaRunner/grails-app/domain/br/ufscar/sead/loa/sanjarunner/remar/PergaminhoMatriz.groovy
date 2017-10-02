package br.ufscar.sead.loa.sanjarunner.remar

class PergaminhoMatriz {

    String[] information = new String[4]

    long ownerId
    String taskId

    static mapping = {
        information sqlType: 'blob'
    }

    static constraints = {
        information (blank : false, size: 4..2400)
    }
}
