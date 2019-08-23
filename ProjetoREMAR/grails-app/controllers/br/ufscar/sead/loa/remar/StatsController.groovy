package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.remar.statistics.RankingStats
import br.ufscar.sead.loa.remar.statistics.StatisticFactory
import br.ufscar.sead.loa.remar.statistics.ChallengeStats
import br.ufscar.sead.loa.remar.statistics.TimeStats
import grails.converters.JSON

class StatsController {

    def index() {}

    def analysis() {
        def exportedResource = ExportedResource.findById(params.exportedResourceId)
        render view: "analysis", model: [groupId: session.group.id, exportedResource: exportedResource]

    }

    // Checks if game was exported to a group
    def exportedToGroup() {
        return (GroupExportedResources.findAllByExportedResource(ExportedResource.get(params.exportedResourceId)).size != 0)
    }

    def saveChallengeStats() {

        if (exportedToGroup()) {

            StatisticFactory factory      = StatisticFactory.instance
            ChallengeStats challengeStats = factory.createStatistics(params.challengeType as String)

            def userId             = session.user.id as long
            def exportedResourceId = params.exportedResourceId as int
            def data               = challengeStats.getData(params)

            try {

                MongoHelper.instance.createCollection("challengeStats")
                MongoHelper.instance.insertStats("challengeStats", userId, exportedResourceId, data)

            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }

            log.debug "Saving challenge stats..." + data
        } else {
            log.debug "Stats skipped. Game was not published to a group."
        }

        render status: 200
    }

    def saveTimeStats() {

        if (exportedToGroup()) {

            TimeStats timeStats = new TimeStats()

            def userId             = session.user.id as long
            def exportedResourceId = params.exportedResourceId as int
            def data               = timeStats.getData(params)

            try {

                MongoHelper.instance.createCollection("timeStats")
                MongoHelper.instance.insertStats("timeStats", userId, exportedResourceId, data)

            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage())
            }

            log.debug "Saving time stats..." + data
        } else {
            log.debug "Stats skipped. Game was not published to a group."
        }

        render status: 200
    }

    def saveRankingStats() {

        if(exportedToGroup()) {

            RankingStats rankingStats = new RankingStats()

            def data = rankingStats.getData(params)
            data.userId = session.user.id as long

            try {
                MongoHelper.instance.createCollection("rankingStats")
                MongoHelper.instance.insertScoreToRanking(data)

            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }

            log.debug "Saving ranking stats..." + data
        } else {
            log.debug "Stats skipped. Game was not published to a group."
        }

        render status: 200
    }

    def showDamageStats() {
        def lista = MongoHelper.instance.getData("damageStats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showTimeStats() {
        def lista = MongoHelper.instance.getData("timeStats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showChallengeStats() {
        def lista = MongoHelper.instance.getData("challengeStats")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def showRankingStats() {
        def lista = MongoHelper.instance.getData("ranking")
        StringBuffer buffer = new StringBuffer();
        for (Object o : lista) {
            buffer.append(o.toString());
            buffer.append("<br><br>");
        }
        render buffer
    }

    def groupUsers() {

        if (params.groupId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                User.findById(it.user.id).name
            }

            render users.sort() as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def gameInfo() {

        if(params.exportedResourceId) {

            def info = MongoHelper.instance.getGameInfo(params.exportedResourceId as int)
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

    def ranking() {
        /*
         *  Retorna um JSON com maior pontuação dos jogadores
         *  [[nome, maior pontuação]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def resourceRanking = MongoHelper.instance.getRanking(params.exportedResourceId as Long)
            def groupRanking = []

            if (resourceRanking != null) {

                for (o in resourceRanking) {
                    if (userGroups.find { it.user.id == o.userId } != null) {
                        groupRanking.add([User.findById(o.userId).name, o.score])
                    }
                }
            }

            render groupRanking as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def conclusionTime() {
        /*
         *  Retorna um JSON com menor tempo dos jogadores
         *  [[nome, menor tempo]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceTime = MongoHelper.instance.getGameConclusionTime(params.exportedResourceId as int, users)
            def usersTime = []

            if (resourceTime != null) {

                for(o in resourceTime) {
                    usersTime.add([User.findById(o.key).name, o.value / 60])
                }
            }

            render usersTime as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def quantityLevel() {
        /*
         *  Retorna um JSON com quantidade de jogadores por nivel
         *  [[nivel, quantidade]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceLevels = MongoHelper.instance.getQntInLevels(params.exportedResourceId as int, users)
            def usersLevel = []

            if (resourceLevels != null) {

                for (o in resourceLevels) {
                    usersLevel.add([o.key, o.value.size()])
                }
            }

            render usersLevel as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def levelAttempt() {
        /*
         *  Retorna um JSON com quantidade de tentativas por nivel
         *  [[nivel, tentativas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }
            def resourceAtt = MongoHelper.instance.getLevelAttempt(params.exportedResourceId as int, users)
            def groupLevelAtt = []

            if (resourceAtt != null) {

                for (lvl in resourceAtt) {
                    groupLevelAtt.add([lvl.key, lvl.value])
                }
            }

            render groupLevelAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def levelAttempt2() {
        /*
         *  Retorna um JSON com quantidade de tentativas por nivel
         *  [[nivel, tentativas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }
            def resourceAtt = MongoHelper.instance.getLevelAttemptRatio(params.exportedResourceId as int, users)
            def groupLevelAtt = []

            if (resourceAtt != null) {

                def level, attempts, conclAttempts
                def index

                for (entry in resourceAtt) {

                    level         = entry.key.get(1)
                    attempts      = entry.value.get(0)
                    conclAttempts = entry.value.get(1)

                    index = groupLevelAtt.findIndexOf { it[0] == level }

                    if(index != -1) {
                        groupLevelAtt[index][1] += attempts
                        groupLevelAtt[index][2] += conclAttempts
                    } else {
                        groupLevelAtt.add([level, attempts, conclAttempts])
                    }
                }
            }

            render groupLevelAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def levelAttemptRatio() {
        /*
         *  Retorna um JSON com total de tentativas e tentativas concluídas por nível de cada aluno
         *  [[jogador, tentativas, tent. concluídas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getLevelAttemptRatio(params.exportedResourceId as int, users)
            def playersLevelAtt = [:]

            if (resourceAtt != null) {

                def user, level, conclAttempts, notConclAttempts

                for (entry in resourceAtt) {

                    user             = User.findById(entry.key.get(0)).name
                    level            = entry.key.get(1)
                    conclAttempts    = entry.value.get(1)
                    notConclAttempts = entry.value.get(0) - conclAttempts

                    if(playersLevelAtt.containsKey(level)) {
                        playersLevelAtt[level].add( [user, conclAttempts, notConclAttempts] )
                    } else {
                        playersLevelAtt.put(level, [[user, conclAttempts, notConclAttempts]])
                    }
                }
            }

            render playersLevelAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerAttemptRatio() {
        /*
         *  Retorna um JSON com total de tentativas e tentativas concluídas por nível de cada aluno
         *  [[jogador, tentativas, tent. concluídas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getLevelAttemptRatio(params.exportedResourceId as int, users)
            def playersLevelAtt = [:]

            if (resourceAtt != null) {

                def user, level, conclAttempts, notConclAttempts

                for (entry in resourceAtt) {

                    user             = User.findById(entry.key.get(0)).name
                    level            = entry.key.get(1)
                    conclAttempts    = entry.value.get(1)
                    notConclAttempts = entry.value.get(0) - conclAttempts

                    if(playersLevelAtt.containsKey(user)) {
                        playersLevelAtt[user].add( [level, conclAttempts, notConclAttempts] )
                    } else {
                        playersLevelAtt.put(user, [[level, conclAttempts, notConclAttempts]])
                    }
                }
            }

            render playersLevelAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def avgLevelTime() {
        /*
         *  Retorna um JSON com tempo médio gasto por nivel
         *  [[nivel, tempo1, tempo2]]
         *
         *  OBS: É pego o menor tempo de conclusão cada usuário do grupo
         *  e depois calculada a média com esse conjunto para o tempo1.
         *  O mesmo ocorre com o tempo2, mas pegando o maior tempo de conclusão.
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeLevel = MongoHelper.instance.getAvgLevelTime(params.exportedResourceId as int, users)
            def avgTimeLevel = []

            if (groupTimeLevel != null) {

                def sum1 = 0.0 // shortest time
                def sum2 = 0.0 // longest  time
                def avg1, avg2

                for (level in groupTimeLevel) {

                    for (time in level.value) { // Percorre mapa usuario:[array de tempos]
                        time.value.sort() // Ordena tempos de conclusão desse level

                        sum1 += time.value.first() // Soma menor tempo
                        sum2 += time.value.last()  // Soma maior tempo
                    }

                    // Média calculada e dividida por 60 para dar em minutos
                    avg1 = sum1 / ((level.value.size()) * 60)
                    avg2 = sum2 / ((level.value.size()) * 60)

                    avgTimeLevel.add([level.key, avg1, avg2])

                    sum1 = 0.0
                    sum2 = 0.0
                }
            }

            render avgTimeLevel as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def levelTime() {
        /*
         *  Retorna um JSON com as seguintes infos de todos
         *  os tempos de conclusão por nível em minutos:
         *  [[nivel, menor tempo, maior tempo, soma, mediana]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeLevel = MongoHelper.instance.getLevelTime(params.exportedResourceId as int, users)
            def menor, maior, total, meio, mediana
            def soma = 0.0
            def timeLevel = []

            if (groupTimeLevel != null) {

                for (level in groupTimeLevel) {

                    menor = level.value.first()
                    maior = level.value.last()
                    total = level.value.size()
                    meio = (int)(total/2)
                    mediana = (total % 2 != 0) ? level.value[meio] : (level.value[meio] + level.value[meio-1])/2

                    for(time in level.value)
                        soma += time

                    timeLevel.add([level.key, menor/60, maior/60, soma/(total*60), mediana/60])

                    soma = 0.0
                }
            }

            render timeLevel as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def avgChallTime() {
        /*
         *  Retorna um JSON com tempo médio gasto por desafio
         *  [level:[desafio, tempo1, tempo2]]
         *
         *  OBS: É pego o menor tempo de conclusão cada usuário do grupo
         *  e depois calculada a média com esse conjunto para o tempo1.
         *  O mesmo ocorre com o tempo2, mas pegando o maior tempo de conclusão.
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeChall = MongoHelper.instance.getAvgChallTime(params.exportedResourceId as int, users)
            def avgChall = [:]

            if (groupTimeChall != null) {

                def level, challenge

                def sum1 = 0.0 // shortest time
                def sum2 = 0.0 // longest  time
                def avg1, avg2

                // [level, desafio]:usuario:[tempos]
                for (entry in groupTimeChall) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)

                    for (time in entry.value) {

                        time.value.sort()

                        sum1 += time.value.first() // Soma menor tempo
                        sum2 += time.value.last()  // Soma maior tempo
                    }

                    // Média calculada e dividida por 60 para dar em minutos
                    avg1 = sum1 / entry.value.size()
                    avg2 = sum2 / entry.value.size()

                    if (avgChall.containsKey(level)) {
                        avgChall[level].add( [challenge, avg1, avg2] )
                    } else {
                        avgChall.put(level, [[challenge, avg1, avg2]])
                    }

                    sum1 = 0.0
                    sum2 = 0.0
                }

                avgChall.each { desafio ->
                    desafio.value.sort { it[0] }
                }
            }

            render avgChall as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def challTime() {
        /*
         *  Retorna um JSON com as seguintes infos de todos
         *  os tempos de conclusão por desafio em minutos:
         *  [[nivel, menor tempo, maior tempo, soma, mediana]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeChall = MongoHelper.instance.getChallTime(params.exportedResourceId as int, users)
            def level, challenge, menor, maior, total, meio, mediana
            def soma = 0.0
            def timeChall = [:]

            if (groupTimeChall != null) {

                for (entry in groupTimeChall) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)
                    menor = entry.value.first()
                    maior = entry.value.last()
                    total = entry.value.size()
                    meio = (int)(total/2)
                    mediana = (total % 2 != 0) ? entry.value[meio] : (entry.value[meio] + entry.value[meio-1])/2

                    for(time in entry.value)
                        soma += time

                    if(timeChall.containsKey(level))
                        timeChall[level].add([challenge, menor, maior, soma/total, mediana])
                    else
                        timeChall.put( level, [[challenge, menor, maior, soma/total, mediana]] )

                    soma = 0.0
                }

                timeChall.each { desafio ->
                    desafio.value.sort { it[0] }
                }
            }

            render timeChall as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def challAttempt() {
        /*
         *  Retorna um JSON com total de tentativas por desafio
         *  [level:[desafio, tentivas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getChallAttempt(params.exportedResourceId as int, users)
            def groupChallAtt = [:]

            if (resourceAtt != null) {

                def level, challenge, attempt

                for (entry in resourceAtt) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)
                    attempt   = entry.value

                    if(groupChallAtt.containsKey(level)) {
                        groupChallAtt[level].add( [challenge, attempt] )
                    } else {
                        groupChallAtt.put(level, [[challenge, attempt]])
                    }
                }

                groupChallAtt.each {
                    it.value.sort()
                }
            }

            render groupChallAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def challMistake  () {
        /*
         *  Retorna um JSON com total de erros por desafio
         *  [level:[desafio, erros]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceMiss = MongoHelper.instance.getChallMistakes(params.exportedResourceId as int, users)
            def groupChallMiss = [:]

            if (resourceMiss != null) {

                def level, challenge, mistake

                for (entry in resourceMiss) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)
                    mistake   = entry.value

                    if(groupChallMiss.containsKey(level)) {
                        groupChallMiss[level].add( [challenge, mistake] )
                    } else {
                        groupChallMiss.put(level, [[challenge, mistake]])
                    }
                }

                groupChallMiss.each {
                    it.value.sort()
                }
            }

            render groupChallMiss.sort() as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def challMistakeRatio() {
        /*
         *  Retorna um JSON com total de tentativas e tentativas concluídas por desafio de cada aluno
         *  [level:
         *    [
         *      desafio : [jogador, tentativas, tent. concluídas]
         *    ]
         *  ]
         *
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getChallMistakesRatio(params.exportedResourceId as int, users)
            def playersMissRatio = [:]

            if (resourceAtt != null) {

                def user, level, challenge, hits, mistakes

                for (entry in resourceAtt) {

                    user       = User.findById(entry.key.get(0)).name
                    level      = entry.key.get(1)
                    challenge  = entry.key.get(2)
                    hits       = entry.value.get(0)
                    mistakes   = entry.value.get(1)

                    if(playersMissRatio.containsKey(level)) {
                        if(playersMissRatio[level].containsKey(challenge)) {
                            playersMissRatio[level][challenge].add( [user, hits, mistakes] )
                        } else {
                            playersMissRatio[level].put( challenge, [[user, hits, mistakes]] )
                        }
                    } else {
                        playersMissRatio.put(level, [ (challenge): [[user, hits, mistakes]] ] )
                    }
                }
            }

            render playersMissRatio as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def choiceFrequency  () {
        /*
         *  Retorna um JSON com frequencia de escolhas por desafio
         *  [level:[desafio, tentivas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceFreq = MongoHelper.instance.getChoiceFrequency(params.exportedResourceId as int, users)
            def info = MongoHelper.instance.getGameInfo(params.exportedResourceId as int)
            def groupChoiceFreq = [:]

            if (resourceFreq != null) {
                
                def CORRECT_ANSWER_COLOR = "green"
                def WRONG_ANSWER_COLOR = "red"

                def level, challenge, answer, freq, correctAnswer

                for (entry in resourceFreq) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)
                    answer    = entry.key.get(2)
                    freq      = entry.value
                    correctAnswer = entry.key.get(3)

                    if(groupChoiceFreq.containsKey(level)) {
                        if(groupChoiceFreq[level].containsKey(challenge)) {
                            if (correctAnswer == answer) {
                                groupChoiceFreq[level].get(challenge).add( [answer, freq, CORRECT_ANSWER_COLOR] )
                            } else {
                                groupChoiceFreq[level].get(challenge).add( [answer, freq, WRONG_ANSWER_COLOR] )
                            }
                        } else {
                            if (correctAnswer == answer) {
                                groupChoiceFreq[level].put(challenge, [[answer, freq, CORRECT_ANSWER_COLOR]])
                            } else {
                                groupChoiceFreq[level].put(challenge, [[answer, freq, WRONG_ANSWER_COLOR]])
                            }
                        }
                    } else {
                        if (correctAnswer == answer) {
                            groupChoiceFreq.put(level, [ (challenge): [[answer, freq, CORRECT_ANSWER_COLOR]] ] )
                        } else {
                            groupChoiceFreq.put(level, [ (challenge): [[answer, freq, WRONG_ANSWER_COLOR]] ] )
                        }
                    }
                }
            }

            render groupChoiceFreq as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerLevelAttempt() {
        /*
         *  Retorna um JSON com quantidade de tentativas por nivel de cada aluno
         *  [[nivel, tentativas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getPlayerLevelAttempt(params.exportedResourceId as int, users)
            def playersLevelAtt = [:]

            if (resourceAtt != null) {

                def user, level, attempts

                for (entry in resourceAtt) {

                    user     = User.findById(entry.key.get(0)).name
                    level    = entry.key.get(1)
                    attempts = entry.value

                    if(playersLevelAtt.containsKey(user)) {
                        playersLevelAtt[user].add( [level, attempts] )
                    } else {
                        playersLevelAtt.put(user, [[level, attempts]])
                    }
                }
            }

            render playersLevelAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerChallAttempt() {
        /*
         *  Retorna um JSON com total de tentativas por desafio de cada aluno
         *  [level:[desafio, tentivas]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceAtt = MongoHelper.instance.getPlayerChallAttempt(params.exportedResourceId as int, users)
            def groupChallAtt = [:]

            if (resourceAtt != null) {

                def user, level, challenge, attempt

                for (entry in resourceAtt) {

                    user      = User.findById(entry.key.get(0)).name
                    level     = entry.key.get(1)
                    challenge = entry.key.get(2)
                    attempt   = entry.value

                    if(groupChallAtt.containsKey(user)) {
                        if(groupChallAtt[user].containsKey(level)) {
                            groupChallAtt[user][level].add( [challenge, attempt] )
                        } else {
                            groupChallAtt[user].put(level, [[challenge, attempt]])
                        }
                    } else {
                        groupChallAtt.put(user, [ (level): [[challenge, attempt]] ] )
                    }
                }

            }

            render groupChallAtt as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerLevelTime() {
        /*
         *  Retorna um JSON com os tempos gastos de cada aluno por nivel
         *  [[nivel, tempo]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeLevel = MongoHelper.instance.getPlayerLevelTime(params.exportedResourceId as int, users)
            def timeLevel = [:]

            if (groupTimeLevel != null) {

                def user, level, times
                def attemptCount = 1

                for (entry in groupTimeLevel) {

                    user  = User.findById(entry.key.get(0)).name
                    level = entry.key.get(1)
                    times = entry.value

                    for(time in times) {

                        time = (time/60) // transforma em minutos

                        if(timeLevel.containsKey(user)) {
                            if(timeLevel[user].containsKey(level)) {
                                timeLevel[user][level].add( [attemptCount, time] )
                            } else {
                                timeLevel[user].put(level, [[attemptCount, time]])
                            }
                        } else {
                            timeLevel.put(user, [ (level): [[attemptCount, time]] ] )
                        }

                        attemptCount++
                    }

                    attemptCount = 1
                }
            }

            render timeLevel as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerLevelTime2() {
        /*
         *  Retorna um JSON com os tempos gastos de cada aluno por nivel
         *  [[nivel, tempo]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeLevel = MongoHelper.instance.getPlayerLevelTime(params.exportedResourceId as int, users)
            def timeLevel = [:]

            if (groupTimeLevel != null) {

                def user, level, times, shorter, longer

                for (entry in groupTimeLevel) {

                    user  = User.findById(entry.key.get(0)).name
                    level = entry.key.get(1)
                    times = entry.value

                    times.sort()

                    shorter = times.first() / 60
                    longer = times.last() / 60

                    if(timeLevel.containsKey(user)) {
                        timeLevel[user].add( [level, shorter, longer] )
                    } else {
                        timeLevel.put(user, [ [level, shorter, longer] ] )
                    }
                }
            }

            render timeLevel as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerChallMistake  () {
        /*
         *  Retorna um JSON com total de erros por desafio
         *  [level:[desafio, erros]]
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def resourceMiss = MongoHelper.instance.getPlayerChallMistakes(params.exportedResourceId as int, users)
            def groupChallMiss = [:]

            if (resourceMiss != null) {

                def user, level, challenge, mistake

                for (entry in resourceMiss) {

                    user      = User.findById(entry.key.get(0)).name
                    level     = entry.key.get(1)
                    challenge = entry.key.get(2)
                    mistake   = entry.value

                    if(groupChallMiss.containsKey(user)) {
                        if(groupChallMiss[user].containsKey(level)) {
                            groupChallMiss[user][level].add( [challenge, mistake] )
                        } else {
                            groupChallMiss[user].put(level, [[challenge, mistake]])
                        }
                    } else {
                        groupChallMiss.put(user, [ (level): [[challenge, mistake]] ] )
                    }
                }
            }

            render groupChallMiss as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

    def playerChallTime() {
        /*
         *  Retorna um JSON com maior e menor tempo gastos de cada desafio por aluno
         *  [level:[desafio, tempo1, tempo2]]
         *
         *  OBS: É pego o menor tempo de conclusão cada usuário do grupo
         *  e depois calculada a média com esse conjunto para o tempo1.
         *  O mesmo ocorre com o tempo2, mas pegando o maior tempo de conclusão.
         *
         *  Parâmetros:
         *      groupId            -> identificador do grupo
         *      exportedResourceId -> identificador do recurso exportado
         */

        if (params.groupId && params.exportedResourceId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                it.user.id
            }

            def groupTimeChall = MongoHelper.instance.getPlayerChallTime(params.exportedResourceId as int, users)
            def challTime = [:]

            if (groupTimeChall != null) {

                def user, level, challenge, times

                // [level, desafio]:usuario:[tempos]
                for (entry in groupTimeChall) {

                    user      = User.findById(entry.key.get(0)).name
                    level     = entry.key.get(1)
                    challenge = entry.key.get(2)
                    times     = entry.value

                    times.sort()

                    if (challTime.containsKey(user)) {

                        if(challTime[user].containsKey(level)) {
                            challTime[user][level].add( [challenge, times.first(), times.last()] )
                        } else {
                            challTime[user].put(level,  [[ challenge, times.first(), times.last() ]] )
                        }

                    } else {
                        challTime.put(user, [ (level) : [[ challenge, times.first(), times.last() ]] ])
                    }
                }
            }

            render challTime as JSON

        } else {
            // TODO: render erro nos parametros
        }
    }

}
