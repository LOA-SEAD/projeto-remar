package br.ufscar.sead.loa.remar

import com.mongodb.BasicDBObject
import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import com.mongodb.client.MongoIterable
import com.mongodb.client.model.Filters
import org.bson.Document
import org.bson.types.ObjectId

import static java.util.Arrays.asList

@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

    def santograuinfo = ["Fase Tecnologia", "Fase Galeria", "Fase Campo Minado", "Fase Blocos de Gelo", "Fase TCC", "Fase Refeitório"]
    def escolamagicainfo = ["", "Porta 1", "Porta 2", "Porta 3"]

    def init(Map options) {
        def credential = MongoCredential.createCredential(options.username as String, 'admin', options.password as char[])

        this.mongoClient = new MongoClient(new ServerAddress(options.dbHost as String), asList(credential))
        this.db = mongoClient.getDatabase('remar')

        /*MongoIterable<String> names = propellerDB.listCollectionNames()

        for(String name : names) {
            println name
        }*/

    }

    def createCollection(String collectionName) {
        def dbExists = false;

        db.listCollectionNames().each {
            if (it.equals(collectionName)) {
                dbExists = true
            }
        }

        if (!dbExists) {
            db.createCollection(collectionName)
            return false
        }

        return true
    }

    def insertData(String collection, Object data) {

        Document doc = new Document(data)

        println "Doc: "
        println doc
        println "Doc Type: "
        println doc.getClass()

        db.getCollection(collection).insertOne(doc)
    }

    def insertStats(String collection, Object data) {

        println "insertStats: " + data

        def selectedCollection = db.getCollection(collection);

        Document doc = new Document(data)

        if (selectedCollection.find(new Document('userId', data.userId)).size() != 0) {
            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push',
                    new Document("stats", doc)))
        } else {
            selectedCollection.insertOne(new Document("userId", data.userId).append("stats", asList(doc)))
        }
    }

    def insertDamageStats(String collection, Object data) {

        println "insertDamageStats: " + data

        def selectedCollection = db.getCollection(collection);

        Document doc = new Document(data)

        if (selectedCollection.find(new Document('userId', data.userId)).size() != 0) {
            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push',
                    new Document("damageStats", doc)))
        } else {
            selectedCollection.insertOne(new Document("userId", data.userId).append("damageStats",
                    asList(doc)))
        }
    }

    def insertTimeStats(String collection, Object data) {
        /*
         *  A entrada no banco de dados para as stats de tempo está estruturada da seguinte forma:
         *  {id, userId, timeStats:[{timestamp, userId, exportedResourceId, time, type, gameId, gameType}]}
         *
         *  type = 0 -> time é em relação ao jogo    (jogo    iniciado time = 0, jogo    finalizado time > 0)
         *  type = 1 -> time é em relação ao nível   (nível   iniciado time = 0, nível   finalizado time > 0)
         *  type = 2 -> time é em relação ao desafio (desafio iniciado time = 0, desafio finalizado time > 0)
         */

        println "insertTimeStats: " + data

        def selectedCollection = db.getCollection(collection);

        Document doc = new Document(data)

        if (selectedCollection.find(new Document('userId', data.userId)).size() != 0) {

            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push',
                    new Document("timeStats", doc)))
        } else {
            selectedCollection.insertOne(new Document("userId", data.userId).append("timeStats",
                    asList(doc)))
        }
    }

    String[] getFilePaths(String... ids) {
        def paths = []
        def collection = this.db.getCollection('file')

        for (id in ids) {
            def entry = collection.find(new Document('_id', new ObjectId(id))).first()
            paths << entry.getString('path')
        }

        return paths
    }

    def getData(String collection) {
        return db.getCollection(collection).find()
    }

    def getData(String collection, int resourceId) {
        return db.getCollection(collection).find(new Document("game", resourceId))
    }

    def getData(String collection, int resourceId, int userId) {
        return db.getCollection(collection).find(new Document("game", resourceId).append("user", userId))
    }

    /*def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection)
                .find(
                    [ '$and': [ [ 'userId' : [ '$in' : userGroup] ], [ (collection + '.exportedResourceId') : exportedResourceId ] ] ] as BasicDBObject
                )
    }*/

    def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection).find(new Document('userId', new Document('$in', userGroup)).append("${collection}.exportedResourceId", exportedResourceId)).sort {
            userId: 1
        }
    }

    def getStats(String collection, int exportedResourceId, Long userId) {
        return db.getCollection(collection).find(new Document('userId', userId).append("${collection}.exportedResourceId", exportedResourceId))
    }

    def getCollectionForId(String collection, String id) {
        return db.getCollection(collection).find(new Document("_id", new ObjectId(id)))
    }

    def getCollection(String collection, Long id) {
        return db.getCollection(collection).find(new Document("id", id))
    }

    def addCollection(String name) {
        def dbExists = false;

        db.listCollectionNames().each {
            if (it.equals(name)) {
                dbExists = true
            }
        }

        if (!dbExists) {
            db.createCollection(name)
            return true
        }

        return false
    }

    def removeDataFromUri(String collectionName, String value) {
        db.getCollection(collectionName).deleteOne(Filters.in("uri", value))
    }

    /*
     * FUNCIONALIDADES DO RANKING
     */

    def insertScoreToRanking(Object data) {
        /*
            A entrada no banco de dados para o ranking está estruturada da seguinte forma:
            {id, exportedResourceId, ranking:[{userId, score, timestamp}]}
        */
        def rankingCollection = db.getCollection("ranking")
        def collectionEntry = rankingCollection.find(new Document('exportedResourceId', data.exportedResourceId))

        if (collectionEntry.first() != null) {
            // Verifica se o usuário já tem uma pontuação para o jogo
            collectionEntry.collect {
                def pos = -1

                it.ranking.eachWithIndex { obj, idx ->
                    if (obj.userId as int == data.userId as int) {
                        pos = idx
                        return true // break
                    }
                    return false // continua
                }

                if (pos != -1) {
                    // Se tiver, atualiza sua pontuação caso seja maior
                    if ((it.ranking[pos].score as int) < (data.score as int)) {
                        println "Updating user " + data.userId + " score"
                        def selector = "ranking." + pos

                        rankingCollection.updateOne(new Document("exportedResourceId", data.exportedResourceId),
                                new Document('$set', new Document(selector, new Document()
                                        .append("userId", data.userId)
                                        .append("score", data.score as double)
                                        .append("timestamp", data.timestamp)
                                )))
                    } else
                        println "no score to update for user " + data.userId

                } else {
                    println "creating user " + data.userId + " score"
                    // Senão, cria a entrada para esse usuário
                    rankingCollection.updateOne(new Document("exportedResourceId", data.exportedResourceId),
                            new Document('$push', new Document("ranking", new Document()
                                    .append("userId", data.userId)
                                    .append("score", data.score as double)
                                    .append("timestamp", data.timestamp)
                            )))
                }
            }
        } else {
            println "creating resource " + data.exportedResourceId + " ranking entry"

            rankingCollection.insertOne(new Document("exportedResourceId", data.exportedResourceId).append("ranking",
                    asList(new Document()
                            .append("userId", data.userId)
                            .append("score", data.score as double)
                            .append("timestamp", data.timestamp)
                    )))
        }
    }

    /**
    ==========================================
    **/

    def getRanking(Long exportedResourceId) {
        def rankingCollection = db.getCollection("ranking")
        def collectionEntry = rankingCollection.find(new Document('exportedResourceId', exportedResourceId))

        def ranking = []
        if (collectionEntry.first() != null) {
            collectionEntry.collect {
                ranking = it.ranking.sort({ a, b ->
                    b.score <=> a.score ?: a.timestamp <=> b.timestamp
                })
            }
        }

        // Para DEBUG -> descomente a linha abaixo
        //println "ranking: " + ranking

        if (ranking.size() == 0) println "ERROR: Could not return ranking for resource " + exportedResourceId
        return ranking
    }

    //NOMEIA LEVELS A PARTIR DO STATS COLLECTION
    def nameLevels(int exportedResourceId, List<Long> users, Map map, String gameName) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        for (Document doc : statsCollection) {
            for (Object o : doc.stats) {
                if (o.exportedResourceId == exportedResourceId) {

                    if (map.containsKey(o.gameLevel)) {
                        map.put(o.gameLevelName, map[o.gameLevel])
                        map.remove(o.gameLevel)
                    }
                }
            }
        }

        // TODO: Isso nem deveria ser preciso. Novamente é erro de como os dados estão sendo enviados
        if (gameName == "SantoGrau") {
            if (map.containsKey(5)) {
                map.put("Fase Refeitório", map[5])
                map.remove(5)
            }

            if (map.containsKey(1)) {
                map.put("Fase Galeria", map[1])
                map.remove(1)
            }
        }
    }

    //INFOS DO JOGO: NÍVEIS, SEUS DESAFIOS E RESPOSTA CERTA
    def getGameInfo(int exportedResourceId) {

        def statsCollection = db.getCollection("stats")
                .find( [ 'stats.exportedResourceId' : exportedResourceId ] as BasicDBObject )

        if(statsCollection.size() > 0) {

            def gameInfo = [:]
            def question, answer

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {
                    if(o.exportedResourceId == exportedResourceId) {

                        if(o.gameType == "multipleChoice") {
                            question = o.question
                            answer = o.answer
                        } else {
                            question = o.word
                            answer = o.correctAnswer
                        }

                        if(gameInfo.containsKey(o.gameLevelName)) {

                            if( !(gameInfo[o.gameLevelName].containsKey(o.challengeId)) ) {
                                gameInfo[o.gameLevelName].put( o.challengeId,  ["Desafio ${o.challengeId + 1}", question, answer])
                            }

                        } else {
                            gameInfo.put(o.gameLevelName, [ (o.challengeId): ["Desafio ${o.challengeId + 1}", question, answer] ] )
                        }

                    }
                }
            }

            gameInfo.each { level, desafios ->
                gameInfo[level] = desafios.sort()
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "gameInfo: " + gameInfo

            return gameInfo

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }
    }

    //TEMPO DE CONCLUSÃO DE JOGO
    def getGameConclusionTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        def usersTime = [:] // [ usuarioID: conclusionTime ]
        def time

        if(timeCollection.size() > 0) {

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {
                    if (o.exportedResourceId == exportedResourceId && o.type == '0' && (o.time as double) > 0.0) {

                        // Conversão necessária por erro na hora de salvar os parametros em timeStats
                        // Não foi modificado ainda por não poder mexer no banco do alfa.remar.online
                        time = o.time as double

                        if (usersTime.containsKey(o.userId)) {
                            if (usersTime[o.userId] > time) {
                                usersTime[o.userId] = time
                            }
                        } else {
                            usersTime[o.userId] = time
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "usersTime: " + usersTime

            return usersTime.sort { it.value }

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }
    }

    //NÚMERO DE JOGADORES EM CADA NÍVEL
    def getQntInLevels(int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if (timeCollection.size() > 0) {

            def usersInLevel = [:] // [ gameLevel: [lista dos userIds] ]
            def level

            for (Document doc : timeCollection) {
                for (Object o: doc.timeStats) {

                    if ( o.exportedResourceId == exportedResourceId
                            && o.time == '0'
                            && o.type == '1') {

                        // Conversão necessária por erro na hora de salvar os parametros em timeStats
                        // Não foi modificado ainda por não poder mexer no banco do alfa.remar.online
                        if(o.gameId == "SantoGrau")
                            level = santograuinfo[o.gameLevel as int]
                        else if(o.gameId == "EscolaMagica")
                            level = escolamagicainfo[o.gameLevel as int]

                        // Se level ja esta no mapa
                        if (usersInLevel.containsKey(level)) {

                            // e o usuario nao esta na lista de usuarios que jogaram, adiciona
                            if ( ! usersInLevel[level].contains(o.userId) ) {
                                usersInLevel[level].add(o.userId)
                            }

                        // se nao esta no mapa, coloca
                        } else {
                            usersInLevel.put(level, [o.userId])
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "usersInLevel: " + usersInLevel

            return usersInLevel

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return quantity of players per level for resource " + exportedResourceId
            return null
        }
    }

    //NÚMERO DE TENTATIVAS POR NÍVEL
    def getLevelAttempt (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def levelAttempts = [:]
            def level

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.time == '0'
                            && o.type == '1') {

                        // Conversão necessária por erro na hora de salvar os parametros em timeStats
                        // Não foi modificado ainda por não poder mexer no banco do alfa.remar.online
                        if(o.gameId == "SantoGrau")
                            level = santograuinfo[o.gameLevel as int]
                        else if(o.gameId == "EscolaMagica")
                            level = escolamagicainfo[o.gameLevel as int]

                        if (levelAttempts.containsKey(level)) {
                            levelAttempts[level] += 1
                        } else {
                            levelAttempts.put(level, 1)
                        }
                    }
                }
            }

            // Para DEBUG -> descomente as linhas abaixo
            //println "levelAttempts: " + levelAttempts

            return levelAttempts

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return level attempts for resource " + exportedResourceId
            return null
        }
    }

    //TOTAL DE TENTATIVAS E TENTATIVAS CONCLUÍDAS EM CADA NÍVEL POR JOGADOR
    def getLevelAttemptRatio (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def levelAttempts = [:]
            def level, time
            def tuple

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '1') {

                        // Conversão necessária por erro na hora de salvar os parametros em timeStats
                        // Não foi modificado ainda por não poder mexer no banco do alfa.remar.online
                        level = o.gameLevel as int
                        time = o.time as double

                        if(o.gameId == "SantoGrau")
                            tuple = new Tuple(o.userId, santograuinfo[level])
                        else  if(o.gameId == "EscolaMagica")
                            tuple = new Tuple(o.userId, escolamagicainfo[level])

                        if (levelAttempts.containsKey(tuple)) {

                            if(time > 0.0) {
                                levelAttempts[tuple][1] += 1
                            } else {
                                levelAttempts[tuple][0] += 1
                            }

                        } else {
                            levelAttempts.put(tuple, [1,0])
                        }
                    }
                }
            }

            // Para DEBUG -> descomente as linhas abaixo
            //println "levelAttemptRatio: " + levelAttempts

            return levelAttempts

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return level attempts for resource " + exportedResourceId
            return null
        }
    }

    //TEMPO MÉDIO GASTO POR NÍVEL, MENOR E MAIOR TEMPO EM CONSIDERAÇÃO
    def getAvgLevelTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerLevel = [:] // [ level : [ [user1: [time1, time2, time3] ], [user2: [time1, time2] ] ] ]
            def level, time

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {
                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '1'
                            && (o.time as double) > 0.0) {

                        time = o.time as double

                        if(o.gameId == "SantoGrau")
                            level = santograuinfo[o.gameLevel as int]
                        else if(o.gameId == "EscolaMagica")
                            level = escolamagicainfo[o.gameLevel as int]

                        if (timePerLevel.containsKey(level)) {

                            if ( timePerLevel[level].containsKey(o.userId) ) {
                                timePerLevel[level][o.userId].add( time )
                            } else {
                                timePerLevel[level].put( o.userId, [time] )
                            }
                        } else {
                            timePerLevel.put( level, [(o.userId): [time]] )
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerLevel: " + timePerLevel

            return timePerLevel

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return average level time for resource " + exportedResourceId
            return null
        }
    }

    //TODOS OS TEMPOS GASTOS DE TODOS DO GRUPO EM CADA LEVEL
    def getLevelTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerLevel = [:]
            def level, time // utilizados pra conversão

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {
                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '1'
                            && (o.time as double) > 0.0) {

                        time = o.time as double

                        if(o.gameId == "SantoGrau")
                            level = santograuinfo[o.gameLevel as int]
                        else if(o.gameId == "EscolaMagica")
                            level = escolamagicainfo[o.gameLevel as int]

                        if (timePerLevel.containsKey(level)) {
                            timePerLevel[level].add( [o.userId, time] )
                        } else {
                            timePerLevel.put( level, [ [o.userId, time] ] )
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerLevel: " + timePerLevel

            return timePerLevel

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }
    }

    //TEMPO DE CONCLUSÃO DE CADA DESAFIO
    def getAvgChallTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerChallenge = [:]
            def level, chall
            def time  // utilizado pra conversão string->double
            def tuple // tupla [level, challenge, user] como chave do mapa. OBS: user é long

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '2'
                            && (o.time as double) > 0.0) {

                        time = o.time as double
                        level = o.gameLevel as int
                        chall = "Desafio ${(o.challengeId as int) + 1}"

                        if(o.gameId == "SantoGrau")
                            tuple = new Tuple (santograuinfo[level], chall)
                        else if(o.gameId == "EscolaMagica")
                            tuple = new Tuple (escolamagicainfo[level], chall)

                        if ( timePerChallenge.containsKey( tuple ) ) {

                            if ( timePerChallenge[tuple].containsKey( o.userId ) ) {
                                timePerChallenge[tuple][o.userId].add(time)
                            } else {
                                timePerChallenge[tuple].put( o.userId, [time] )
                            }

                        } else {
                            timePerChallenge.put( tuple, [(o.userId): [time]] )
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerChallenge: " + timePerChallenge

            return timePerChallenge

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return average challenge time for resource " + exportedResourceId
            return null
        }
    }

    //NÚMERO DE TENTATIVAS POR DESAFIO
    def getChallAttempt (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if(statsCollection.size() > 0) {

            def challAttempts = [:]
            def tuple
            def santograu = false

            // Contadores de tentativas
            // para cada desafio da Fase Galeria
            def galeria1 = 0
            def galeria2 = 0

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId) {

                        if (o.gameLevelName == "Fase Tecnologia"     || o.gameLevelName == "Fase Campo Minado" ||
                                o.gameLevelName == "Fase Blocos de Gelo" || o.gameLevelName == "Fase TCC") {
                            santograu = true
                        }

                        tuple = new Tuple (o.gameLevelName, "Desafio ${o.challengeId + 1}")

                        if (challAttempts.containsKey(tuple)) {
                            challAttempts[tuple] += 1
                        } else {
                            challAttempts.put(tuple, 1)
                        }
                    }
                }
            }

            // TODO: Isso nem deveria ser preciso. Novamente é erro de como os dados estão sendo enviados
            if(santograu) {

                def timeCollection = getStats("timeStats", exportedResourceId, users)

                for (Document doc : timeCollection) {
                    for (Object o : doc.timeStats) {

                        if (o.exportedResourceId == exportedResourceId && o.gameId == 'SantoGrau'
                                && o.time == '0' && o.type == '2' && o.gameLevel == '1') {

                            if(o.challengeId == '0')
                                galeria1++
                            else if(o.challengeId == '1')
                                galeria2++
                        }
                    }
                }

                challAttempts.put( new Tuple("Fase Galeria", "Desafio 1"), galeria1)
                challAttempts.put( new Tuple("Fase Galeria", "Desafio 2"), galeria2)
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challAttempts: " + challAttempts

            return challAttempts

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge attempts for resource " + exportedResourceId
            return null
        }
    }

    //TOTAL DE ERROS POR DESAFIO
    def getChallMistakes(int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId && o.win == false) {

                        tuple = new Tuple( o.gameLevelName, ("Desafio ${o.challengeId + 1}") )

                        if (challMistakes.containsKey(tuple)) {
                            challMistakes[tuple] += 1
                        } else {
                            challMistakes.put(tuple, 1)
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challMistakes: " + challMistakes

            return challMistakes

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge mistakes for resource " + exportedResourceId
            return null
        }

    }

    //TOTAL DE TENTATIVAS E TENTATIVAS CONCLUÍDAS EM CADA DESAFIO POR JOGADOR
    def getChallMistakesRatio (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple
            def hitOrMiss, temp

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId) {

                        tuple = new Tuple( o.userId, o.gameLevelName, ("Desafio " + (o.challengeId + 1)) )

                        if(o.win) {
                            hitOrMiss = 0
                            temp = [1, 0]
                        } else {
                            hitOrMiss = 1
                            temp = [0, 1]
                        }

                        if (challMistakes.containsKey(tuple)) {
                            challMistakes[tuple][hitOrMiss] += 1
                        } else {
                            challMistakes.put(tuple, temp)
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challMistakes: " + challMistakes

            return challMistakes

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge mistakes for resource " + exportedResourceId
            return null
        }

    }

    //FREQUÊNCIA DE ESCOLHAS POR DESAFIO
    def getChoiceFrequency (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def choiceFrequency = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId) {

                        if(o.gameType == 'shuffleWord')
                            tuple = new Tuple( o.gameLevelName, ("Desafio ${o.challengeId + 1}"),  o.answer.toLowerCase())
                        else if(o.gameType == 'multipleChoice')
                            tuple = new Tuple( o.gameLevelName, ("Desafio ${o.challengeId + 1}"),  o.choice)


                        if (choiceFrequency.containsKey(tuple))
                            choiceFrequency[tuple] += 1
                        else
                            choiceFrequency.put(tuple, 1)

                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "choiceFrequency: " + choiceFrequency

            return choiceFrequency

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }

    }

    //NÚMERO DE TENTATIVAS EM CADA NÍVEL POR JOGADOR
    def getPlayerLevelAttempt (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def levelAttempts = [:]
            def level
            def tuple

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.time == '0'
                            && o.type == '1') {

                        // Conversão necessária por erro na hora de salvar os parametros em timeStats
                        // Não foi modificado ainda por não poder mexer no banco do alfa.remar.online
                        if(o.gameId == "SantoGrau")
                            level = santograuinfo[o.gameLevel as int]
                        else if(o.gameId == "EscolaMagica")
                            level = escolamagicainfo[o.gameLevel as int]

                        if(o.gameId == "SantoGrau") {
                            tuple = new Tuple(o.userId, level)
                        } else {
                            tuple = new Tuple(o.userId, level)
                        }

                        if (levelAttempts.containsKey(tuple)) {
                            levelAttempts[tuple] += 1
                        } else {
                            levelAttempts.put(tuple, 1)
                        }
                    }
                }
            }

            // Para DEBUG -> descomente as linhas abaixo
            //println "playerLevelAttempts: " + levelAttempts

            return levelAttempts

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return level attempts for resource " + exportedResourceId
            return null
        }
    }

    //NÚMERO DE TENTATIVAS POR DESAFIO
    def getPlayerChallAttempt (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if(statsCollection.size() > 0) {

            def challAttempts = [:]
            def tuple
            def santograu = false
            def user

            // Contadores de tentativas
            // para cada desafio da Fase Galeria
            def galeria1 = 0
            def galeria2 = 0

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId) {

                        if (o.gameLevelName == "Fase Tecnologia"     || o.gameLevelName == "Fase Campo Minado" ||
                                o.gameLevelName == "Fase Blocos de Gelo" || o.gameLevelName == "Fase TCC") {
                            santograu = true
                        }

                        tuple = new Tuple (o.userId, o.gameLevelName, "Desafio ${o.challengeId + 1}")

                        if (challAttempts.containsKey(tuple)) {
                            challAttempts[tuple] += 1
                        } else {
                            challAttempts.put(tuple, 1)
                        }
                    }
                }
            }

            // TODO: Isso nem deveria ser preciso. Novamente é erro de como os dados estão sendo enviados
            if(santograu) {

                def timeCollection = getStats("timeStats", exportedResourceId, users)

                for (Document doc : timeCollection) {
                    for (Object o : doc.timeStats) {

                        user = o.userId

                        if (o.exportedResourceId == exportedResourceId && o.gameId == 'SantoGrau'
                                && o.time == '0' && o.type == '2' && o.gameLevel == '1') {

                            if(o.challengeId == '0')
                                galeria1++
                            else if(o.challengeId == '1')
                                galeria2++
                        }
                    }

                    challAttempts.put( new Tuple(user, "Fase Galeria", "Desafio 1"), galeria1)
                    challAttempts.put( new Tuple(user, "Fase Galeria", "Desafio 2"), galeria2)
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challAttempts: " + challAttempts

            return challAttempts

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge attempts for resource " + exportedResourceId
            return null
        }
    }

    //TODOS OS TEMPOS GASTOS DE CADA JOGADOR DO GRUPO EM CADA LEVEL
    def getPlayerLevelTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerLevel = [:]
            def tuple
            def time, level

            // TODO: gameName é necessário por erro de design do banco e/ou problema com SantoGrau
            // OBS: Leia sobre os erros encontrados com o Miguel
            def gameName = ""

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '1'
                            && (o.time as double) > 0.0) {

                        gameName = o.gameId
                        time = o.time as double
                        level = o.gameLevel as int

                        if(gameName == "SantoGrau")
                            tuple = new Tuple(o.userId, santograuinfo[level])
                        else
                            tuple = new Tuple (o.userId, level)


                        if (timePerLevel.containsKey(tuple))
                            timePerLevel[tuple].add( time )
                        else
                            timePerLevel.put( tuple, [time] )
                    }
                }
            }

            if(gameName != "SantoGrau") {

                def statsCollection = getStats("stats", exportedResourceId, users)

                for (Document doc : statsCollection) {
                    for (Object o : doc.stats) {
                        if (o.exportedResourceId == exportedResourceId) {

                            tuple = new Tuple(o.userId, o.gameLevel)

                            if (timePerLevel.containsKey(tuple)) {
                                timePerLevel.put(new Tuple(o.userId, o.gameLevelName), timePerLevel[tuple])
                                timePerLevel.remove(tuple)
                            }
                        }
                    }
                }

            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerLevel: " + timePerLevel

            return timePerLevel

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }
    }

    //TOTAL DE ERROS DE CADA JOGADOR POR DESAFIO
    def getPlayerChallMistakes(int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("stats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple
            def user

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.exportedResourceId == exportedResourceId && o.win == false) {

                        user = o.userId

                        tuple = new Tuple( o.userId, o.gameLevelName, ("Desafio ${o.challengeId + 1}") )

                        if (challMistakes.containsKey(tuple)) {
                            challMistakes[tuple] += 1
                        } else {
                            challMistakes.put(tuple, 1)
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challMistakes: " + challMistakes

            return challMistakes

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge mistakes for resource " + exportedResourceId
            return null
        }
    }

    //TEMPO DE CONCLUSÃO DE CADA DESAFIO
    def getPlayerChallTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerChallenge = [:]
            def time, level
            def tuple
            def gameName = ""

            for (Document doc : timeCollection) {
                for (Object o : doc.timeStats) {

                    if (o.exportedResourceId == exportedResourceId
                            && o.type == '2'
                            && (o.time as double) > 0.0) {

                        gameName = o.gameId
                        time = o.time as double
                        level = o.gameLevel as int

                        if(gameName == "SantoGrau") {
                            tuple = new Tuple (o.userId, santograuinfo[level], "Desafio " + o.challengeId)
                        } else {
                            tuple = new Tuple (o.userId, level, "Desafio " + o.challengeId)
                        }

                        if (timePerChallenge.containsKey(tuple)) {
                             timePerChallenge[tuple].add(time)
                        } else {
                            timePerChallenge.put( tuple, [time] )
                        }
                    }
                }
            }

            if(gameName != "SantoGrau") {

                def statsCollection = getStats("stats", exportedResourceId, users)

                for (Document doc : statsCollection) {
                    for (Object o : doc.stats) {
                        if (o.exportedResourceId == exportedResourceId) {

                            tuple = new Tuple( o.userId, o.gameLevel, ("Desafio " + o.challengeId) )

                            if (timePerChallenge.containsKey(tuple)) {
                                timePerChallenge.put(new Tuple(o.userId, o.gameLevelName, ("Desafio ${o.challengeId + 1}")), timePerChallenge[tuple])
                                timePerChallenge.remove(tuple)
                            }
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerChallenge: " + timePerChallenge

            return timePerChallenge

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return average challenge time for resource " + exportedResourceId
            return null
        }
    }

    //PRINCIPAL
    static void main(String... args) {

        // Para testar local: 172.18.0.X:27017 -> substituir X dando docker inspect no ip do mongo
        // Para testar com alguma instância do remar: basta por url (alfa.remar.online como ex)
        MongoHelper.instance.init([dbHost  : '172.18.0.4:27017',
                                   username: 'root',
                                   password: 'root'])

        // IDs do grupo 3 do alfa.remar.online - usar para testes
        // exportedResourceId = 9 -> SantoGrau
        // exportedResourceId = 3 -> EscolaMagica
        def grupo3doalfa = [58, 30, 32, 31, 38, 39, 36, 41, 33, 37,
                            45, 42, 35, 34, 47, 43, 44, 40, 49, 53,
                            55, 48, 59, 51, 60, 62, 63, 52, 61, 64,
                            65, 66, 67, 46, 71, 70, 73, 72, 76, 58, 54]

        def grupo2doalfa = [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                            13, 14, 15, 16, 17, 18, 19, 20, 21,
                            22, 23, 24, 25, 26, 27, 28, 29, 69]

        def grupolocal = [2,3,4]
        def exportedResourceId = 5

        // infos do jogo: níveis, seus desafios e resposta certa
        //MongoHelper.instance.getGameInfo(exportedResourceId)

        // ranking dos jogadores que concluíram o jogo
        //MongoHelper.instance.getRanking(exportedResourceId)

        // tempo gasto para conclusão do jogo
        //MongoHelper.instance.getGameConclusionTime(exportedResourceId, grupolocal)

        // quantidade de jogadores por nível
        //MongoHelper.instance.getQntInLevels(exportedResourceId, grupolocal)

        // número de tentativas por nível
        //MongoHelper.instance.getLevelAttempt(exportedResourceId, grupolocal)

        // total de tentativas e tentativas concluidas em cada nível por jogador
        //MongoHelper.instance.getLevelAttemptRatio(exportedResourceId, grupolocal)

        // tempo médio gasto para conclusão de cada nível
        //MongoHelper.instance.getAvgLevelTime(exportedResourceId, grupolocal)

        // lista de tempos gasto para conclusão de cada nível
        //MongoHelper.instance.getLevelTime(exportedResourceId, grupolocal)

        // tempo gasto para conclusão de cada desafio
        //MongoHelper.instance.getAvgChallTime(exportedResourceId, grupolocal)

        // número de tentativas por desafio
        //MongoHelper.instance.getChallAttempt(exportedResourceId, grupolocal)

        // total de erros por desafio
        //MongoHelper.instance.getChallMistakes(exportedResourceId, grupolocal)

        // total de tentativas e tentativas concluidas em cada desafio por jogador
        //MongoHelper.instance.getChallMistakesRatio(exportedResourceId, grupolocal)

        // frequência de escolhas por desafio
        MongoHelper.instance.getChoiceFrequency(exportedResourceId, grupolocal)

        // número de tentativas em cada nível por jogador
        //MongoHelper.instance.getPlayerLevelAttempt(exportedResourceId, grupolocal)

        // número de tentativas em cada desafio por jogador
        //MongoHelper.instance.getPlayerChallAttempt(exportedResourceId, grupolocal)

        // lista de tempos gasto por cada jogador para conclusão de cada nível
        //MongoHelper.instance.getPlayerLevelTime(exportedResourceId, grupolocal)

        // total de erros por desafio de cada jogador
        //MongoHelper.instance.getPlayerChallMistakes(exportedResourceId, grupolocal)

        // maior e menor tempo gastos para conclusão de cada desafio por jogador
        //MongoHelper.instance.getPlayerChallTime(exportedResourceId, grupolocal)
    }
}
