package br.ufscar.sead.loa.escolamagica.remar

class Question {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String level


    static constraints = {
        level inList: ['1','2','3']

    }
}