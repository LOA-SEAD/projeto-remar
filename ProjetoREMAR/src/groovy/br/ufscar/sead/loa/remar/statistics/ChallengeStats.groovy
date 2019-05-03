package br.ufscar.sead.loa.remar.statistics

abstract class ChallengeStats {

    LinkedHashMap getData(params) {

        def data = [:]

        //TODO: possivelmente forçar que se salve sempre o timestamp pelo servidor ou sempre pelo cliente
        if (params.timestamp)
            data.timestamp = params.timestamp
        else
            data.timestamp = new Date().toTimestamp()

        data.levelId   = params.levelId as int
        data.levelName = params.levelName
        data.levelSize = params.levelSize as int
        data.win       = params.win.toBoolean()
        data.challengeId = params.challengeId as int
        data.challengeType = params.challengeType

        return data
    }
}

