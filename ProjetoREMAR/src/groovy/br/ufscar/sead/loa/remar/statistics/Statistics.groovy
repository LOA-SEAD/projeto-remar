package br.ufscar.sead.loa.remar.statistics

abstract class Statistics {

    Object getData(params) {
        def data = [:]
        data.timestamp = new Date().toTimestamp()
        data.exportedResourceId = params.exportedResourceId as int
        data.win = Boolean.parseBoolean(params.win)
        data.gameSize = params.size as int
        data.gameType = params.gameType

        return data
    }
}
