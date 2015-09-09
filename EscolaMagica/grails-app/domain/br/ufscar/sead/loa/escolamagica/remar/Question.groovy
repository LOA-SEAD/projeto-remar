package br.ufscar.sead.loa.escolamagica.remar

class Question {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String level


    static boolean validateQuestions() {


        return (Question.findAllByLevel("1").size() >= 5 && Question.findAllByLevel("2").size() >= 5 && Question.findAllByLevel("3").size() >= 5)

    }

    static constraints = {
        level inList: ['1', '2', '3']

    }
}
