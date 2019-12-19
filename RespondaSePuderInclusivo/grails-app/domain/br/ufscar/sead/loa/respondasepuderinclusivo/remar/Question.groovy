package br.ufscar.sead.loa.respondasepuderinclusivo.remar

class Question {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String hint
    int level

    long ownerId

    String taskId

    static constraints = {
    }
}
