package br.ufscar.sead.loa.sanjarunner.remar

class QuizMatriz {

    String question
    String[] answers = new String[4]
    int correctAnswer

    long ownerId
    String taskId

    static mapping = {
        answers sqlType: 'blob'
    }

    static constraints = {
        question (blank : false, size: 1..200)
        answers (blank : false, size: 4..800)
        correctAnswer (blank : false)
    }
}
