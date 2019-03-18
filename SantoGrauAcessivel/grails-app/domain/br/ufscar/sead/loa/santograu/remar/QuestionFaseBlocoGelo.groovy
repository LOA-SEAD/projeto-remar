package br.ufscar.sead.loa.santograu.remar

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
