package br.ufscar.sead.loa.remar.statistics

class QuestionAndAnswer extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.points = params.points as int
        data.partialPoints = params.partialPoints as int
        data.errors = params.errors
        data.question = params.question
        data.answer = params.answer
        data.end = Boolean.parseBoolean(params.end as String)

        return data
    }

}
