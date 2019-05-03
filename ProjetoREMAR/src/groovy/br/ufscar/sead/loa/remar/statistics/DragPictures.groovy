package br.ufscar.sead.loa.remar.statistics

class DragPictures extends ChallengeStats{

    LinkedHashMap getData(params){

        def data = super.getData(params)

        data.numberMoves     = params.numberMoves as int
        data.initialSequence = params.initialSequence
        data.numberPictures  = params.initialSequence.split(',').length
        data.correctAnswer   = params.correctAnswer
        data.answer          = params.answer

        return data
    }

}