package br.ufscar.sead.loa.escolamagica.remar

class Question {

    String title
    String[] answers = new String[4]
    int correctAnswer
    String level
    long ownerId

    String taskId

    static boolean validateQuestions(String ownerId) {

        boolean validate = findAllByOwnerIdAndLevel(ownerId, "1").size() >= 5
        validate = validate && findAllByOwnerIdAndLevel(ownerId, "2").size() >= 5
        validate = validate && findAllByOwnerIdAndLevel(ownerId, "3").size() >= 5

        return validate

    }

    static constraints = {
        level inList: ['1', '2', '3']

    }
}
