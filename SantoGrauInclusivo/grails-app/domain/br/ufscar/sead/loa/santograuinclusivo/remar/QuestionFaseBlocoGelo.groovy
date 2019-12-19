package br.ufscar.sead.loa.santograuinclusivo.remar

class QuestionFaseBlocoGelo {
    String title
    String[] answers = new String[3]
    int correctAnswer

    long ownerId
    String taskId

    static constraints = {
        correctAnswer(range: 0..2)
    }
}
