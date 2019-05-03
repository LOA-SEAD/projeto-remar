package br.ufscar.sead.loa.remar.statistics

class QuestionAndAnswer extends ChallengeStats{

    LinkedHashMap getData(params){

        def data = super.getData(params)

        data.question      = params.question
        data.correctAnswer = params.correctAnswer
        data.answer        = params.answer

        return data
    }

}
