package br.ufscar.sead.loa.remar.statistics

import br.ufscar.sead.loa.remar.MongoHelper
import grails.converters.JSON
import org.bson.Document

class StatsProcessor {

    def gameInfo(exportedResourceId) {

        if(exportedResourceId) {

            def info = MongoHelper.instance.getGameInfo(exportedResourceId as int)
            def infoJSON = [:]

            if(info != null) {

                def lvlname, chall, question, answer

                for (entry in info) {

                    chall    = entry.key.get(1)
                    lvlname  = entry.value.get(0)
                    question = entry.value.get(1)
                    answer   = entry.value.get(2)

                    if (!infoJSON.containsKey(lvlname))
                        infoJSON.put(lvlname, [])

                    infoJSON[lvlname].add([("Desafio " + chall), question, answer])
                }
            }

            render infoJSON as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

}
