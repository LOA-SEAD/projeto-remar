package br.ufscar.sead.loa.remar.statistics

class MultipleChoice extends ChallengeStats{

    LinkedHashMap getData(params){

        def data = super.getData(params)

        data.question      = params.question
        data.choices       = params.choices
        data.correctAnswer = params.correctAnswer
        data.answer        = params.answer

        return data
    }

}
