package br.ufscar.sead.loa.remar.statistics

class ShuffleWord extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.word = params.word
        data.wordId = params.wordId
        data.numberMistake = params.numberMistake

        return data
    }

}