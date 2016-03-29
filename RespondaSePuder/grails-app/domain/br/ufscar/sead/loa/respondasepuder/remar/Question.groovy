package br.ufscar.sead.loa.respondasepuder.remar

class Question {

    String title
    String[] answer = new String[4]
    int correctAnswer
    String tip
    int level

    long ownerId

    String taskId

    static constraints = {
    }
}
