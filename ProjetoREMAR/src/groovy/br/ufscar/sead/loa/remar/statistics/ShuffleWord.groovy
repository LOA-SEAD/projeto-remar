package br.ufscar.sead.loa.remar.statistics

class ShuffleWord extends ChallengeStats{

    LinkedHashMap getData(params){

        def data = super.getData(params)

        data.word          = params.word
        data.correctAnswer = params.correctAnswer
        data.answer        = params.answer
        data.numberTries   = params.numberTries as int

        return data
    }

}