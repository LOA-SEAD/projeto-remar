package br.ufscar.sead.loa.remar.statistics

class ShuffleWord extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.word = params.word
        data.answer = params.answer
        data.correctAnswer = params.correctAnswer
        data.numberTries = params.numberTries

        return data
    }

}