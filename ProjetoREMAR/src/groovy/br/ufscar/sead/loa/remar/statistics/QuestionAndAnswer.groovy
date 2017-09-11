package br.ufscar.sead.loa.remar.statistics

class QuestionAndAnswer extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.points = params.points as int
        data.levelId = params.levelId as int
        data.errors = params.errors
        data.question = params.question
        data.answer = params.answer
        data.end = Boolean.parseBoolean(params.end)

        return data
    }

}
