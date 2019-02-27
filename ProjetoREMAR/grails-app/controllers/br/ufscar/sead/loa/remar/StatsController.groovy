package br.ufscar.sead.loa.remar

import grails.converters.JSON

class StatsController {

     //MUDAR //def allUsersGroup = UserGroup.findAllByGroup(group).user

    def index() {

    }

    def valerio() {
        render params as JSON
    }

    def groupUsers() {

        if (params.groupId) {

            def group = Group.findById(params.groupId)
            def userGroups = UserGroup.findAllByGroup(group)
            def users = userGroups.collect {
                User.findById(it.user.id).name
            }

            render users as JSON

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
                        playersLevelAtt[level].add( [user, notConclAttempts, conclAttempts] )
                    } else {
                        playersLevelAtt.put(level, [[user, notConclAttempts, conclAttempts]])
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
                        playersLevelAtt[user].add( [level, notConclAttempts, conclAttempts] )
                    } else {
                        playersLevelAtt.put(user, [[level, notConclAttempts, conclAttempts]])
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
         *  Retorna um JSON com os tempos gastos por nivel
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

            def groupTimeLevel = MongoHelper.instance.getLevelTime(params.exportedResourceId as int, users)
            def timeLevel = []

            if (groupTimeLevel != null) {

                for (level in groupTimeLevel) {

                    for (time in level.value) {
                        timeLevel.add([level.key, time[1]])
                    }
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

            render playersMissRatio.sort { it.value } as JSON

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
            def groupChoiceFreq = [:]

            if (resourceFreq != null) {

                def level, challenge, answer, freq

                for (entry in resourceFreq) {

                    level     = entry.key.get(0)
                    challenge = entry.key.get(1)
                    answer    = entry.key.get(2)
                    freq      = entry.value

                    if(groupChoiceFreq.containsKey(level)) {
                        if(groupChoiceFreq[level].containsKey(challenge)) {
                            groupChoiceFreq[level][challenge].add( [answer, freq] )
                        } else {
                            groupChoiceFreq[level].put(challenge, [[answer, freq]])
                        }
                    } else {
                        groupChoiceFreq.put(level, [ (challenge): [[answer, freq]] ] )
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
