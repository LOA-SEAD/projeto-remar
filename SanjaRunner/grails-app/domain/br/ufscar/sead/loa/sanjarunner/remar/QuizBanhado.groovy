package br.ufscar.sead.loa.sanjarunner.remar

class QuizBanhado {

    String question
    String[] answers = new String[4]
    int correctAnswer

    long ownerId
    String taskId

    static constraints = {
        question (blank : false, size: 1..100)
        answers (blank : false, size: 1..100)
        correctAnswer (blank : false)
    }
}
