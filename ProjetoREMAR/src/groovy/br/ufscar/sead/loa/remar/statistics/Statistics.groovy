package br.ufscar.sead.loa.remar.statistics

abstract class Statistics {

    Object getData(params) {
        def data = [:]
        if (params.timestamp){
            data.timestamp = params.timestamp
            data.userId = params.userId
        } else {
            data.timestamp = new Date().toTimestamp()
        }

        data.exportedResourceId = params.exportedResourceId as int
        data.win = Boolean.parseBoolean(params.win as String)

        if (params.gameSize){
            data.gameSize = params.gameSize as int
        }else{
            data.gameSize = params.size as int
        }

        data.challengeId = params.challengeId as int
        data.gameType = params.gameType

        if (params.gameLevel) {
            data.gameLevel = params.gameLevel
            data.gameLevelName = params.gameLevelName
        }

        return data
    }
}


/*if(!params.win.getClass().equals(Boolean.class)){
            data.win = Boolean.parseBoolean(params.win)
        }else{
            data.win = params.win
        }*/