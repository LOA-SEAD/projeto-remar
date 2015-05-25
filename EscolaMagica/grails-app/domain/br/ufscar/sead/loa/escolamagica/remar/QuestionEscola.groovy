package br.ufscar.sead.loa.escolamagica.remar

class QuestionEscola {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String level


    static boolean validateQuestions(){


        return (QuestionEscola.findAllByLevel("1").size()>=5 && QuestionEscola.findAllByLevel("2").size()>=5 && QuestionEscola.findAllByLevel("3").size()>=5)

    }

    static constraints = {
        level inList: ['1','2','3']

    }
}
