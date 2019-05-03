package br.ufscar.sead.loa.remar.statistics

class TimeStats {

    LinkedHashMap getData(params){

        def data = [:]

        //TODO: possivelmente forçar que se salve sempre o timestamp pelo servidor ou sempre pelo cliente
        if (params.timestamp)
            data.timestamp = params.timestamp
        else
            data.timestamp = new Date().toTimestamp()

        // Ver se vale mais a pena puxar o nome já do ExportedResource através do exportedResourceId
        //data.gameName = params.gameName

        if (params.levelId) {
            data.levelId   = params.levelId as int
            data.levelName = params.levelName
        }

        if(params.challengeId)
            data.challengeId = params.challengeId as int

        data.time     = params.time as double
        data.timeType = params.timeType as int

        return data
    }

}
