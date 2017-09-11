package br.ufscar.sead.loa.remar.statistics

class MultipleChoice extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.levelId = params.levelId as int
        data.question = params.question
        data.answer = params.answer
        data.choices = params.choices
        data.choice = params.choice

        return data
    }

}
