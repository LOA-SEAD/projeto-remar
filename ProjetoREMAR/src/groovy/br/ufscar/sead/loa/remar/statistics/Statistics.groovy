package br.ufscar.sead.loa.remar.statistics

abstract class Statistics {

    Object getData(params) {
        def data = [:]
        data.timestamp = params.timestamp
        data.exportedResourceId = params.exportedResourceId as int
        data.win = Boolean.parseBoolean(params.win as String)

        if (params.gameSize){
            data.gameSize = params.gameSize as int
        }else{
            data.gameSize = params.size as int
        }

        data.gameType = params.gameType

        if (params.gameIndex)
            data.gameIndex = params.gameIndex

        return data
    }
}


/*if(!params.win.getClass().equals(Boolean.class)){
            data.win = Boolean.parseBoolean(params.win)
        }else{
            data.win = params.win
        }*/