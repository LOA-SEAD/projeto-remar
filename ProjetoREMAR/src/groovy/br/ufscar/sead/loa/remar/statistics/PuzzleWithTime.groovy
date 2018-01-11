package br.ufscar.sead.loa.remar.statistics

class PuzzleWithTime extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.points = params.points
        data.partialPoints = params.partialPoints as int
        data.remainingTime = params.remainingTime as int
        data.end = Boolean.parseBoolean(params.end as String)

        return data
    }

}
