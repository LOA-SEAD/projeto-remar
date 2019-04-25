package br.ufscar.sead.loa.remar.statistics

class RankingStats {

    Object getData(params){

        def data = [:]

        //TODO: possivelmente forçar que se salve sempre o timestamp pelo servidor ou sempre pelo cliente
        if (params.timestamp)
            data.timestamp = params.timestamp
        else
            data.timestamp = new Date().toTimestamp()

        data.exportedResourceId = params.exportedResourceId as long
        data.score = params.score

        return data
    }
}
