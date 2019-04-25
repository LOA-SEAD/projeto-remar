package br.ufscar.sead.loa.remar.statistics

class ShuffleWord extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.word = params.word
        data.correctAnswer = params.correctAnswer
        data.answer = params.answer

        return data
    }

}