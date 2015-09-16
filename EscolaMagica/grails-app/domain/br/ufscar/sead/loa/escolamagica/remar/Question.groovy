package br.ufscar.sead.loa.escolamagica.remar

import br.ufscar.sead.loa.remar.User

class Question {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String level
    String ownerId


    long processId
    long taskId

    static boolean validateQuestions() {


        return (findAllByLevel("1").size() >= 5 && findAllByLevel("2").size() >= 5 && findAllByLevel("3").size() >= 5)

    }

    static constraints = {
        level inList: ['1', '2', '3']

    }
}
