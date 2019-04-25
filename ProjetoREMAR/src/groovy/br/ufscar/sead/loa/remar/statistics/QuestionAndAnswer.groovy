package br.ufscar.sead.loa.remar.statistics

class QuestionAndAnswer extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.question      = params.question
        data.correctAnswer = params.correctAnswer
        data.answer        = params.answer

        return data
    }

}
