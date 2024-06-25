package br.ufscar.sead.loa.remar

import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import com.mongodb.client.model.Filters
import org.bson.Document
import org.bson.types.ObjectId

import static java.util.Arrays.asList

@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

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

    def insertStats(String collection, long userId, int exportedResourceId, LinkedHashMap data) {

        println "inserting " + collection + ": " + data

        def selectedCollection = db.getCollection(collection)

        Document userExportedResource = new Document("userId", userId)
                .append("exportedResourceId", exportedResourceId)
        Document stats = new Document(data)

        if (selectedCollection.find(userExportedResource).size() != 0) {
            selectedCollection.updateOne(userExportedResource, new Document('$push', new Document("stats", stats)))
        } else {
            selectedCollection.insertOne(userExportedResource.append("stats", asList(stats)))
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
            selectedCollection.insertOne(new Document("userId", data.userId).append("damageStats", asList(doc)))
        }
    }

    def insertTimeStats(String collection, Object data) {

        println "insertTimeStats: " + data

        def selectedCollection = db.getCollection(collection);

        Document doc = new Document(data)

        if (selectedCollection.find(new Document('userId', data.userId)).size() != 0) {

            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push',
                    new Document("timeStats", doc)))
        } else {
            selectedCollection.insertOne(new Document("userId", data.userId).append("timeStats", asList(doc)))
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

    /*def getStatsByGroup(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection)
                .find(
                    [ '$and': [ [ 'userId' : [ '$in' : userGroup] ], [ (collection + '.exportedResourceId') : exportedResourceId ] ] ] as BasicDBObject
                )
    }*/

    def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection).find(new Document('userId', new Document('$in', userGroup)).append("exportedResourceId", exportedResourceId)).sort {
            userId: 1
        }
    }

    def getStats(String collection, int exportedResourceId, Long userId) {
        return db.getCollection(collection).find(new Document('userId', userId).append("exportedResourceId", exportedResourceId))
    }

    def getStats(String collection, int exportedResourceId) {
        return db.getCollection(collection).find(new Document("exportedResourceId", exportedResourceId))
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

    /**
    ==========================================
    **/

    //INFOS DO JOGO: NÍVEIS, SEUS DESAFIOS E RESPOSTA CERTA
    def getGameInfo(int exportedResourceId) {

        def challCollection = MongoHelper.instance.getStats("challengeStats", exportedResourceId)

        if(challCollection.size() > 0) {

            def gameInfo = [:]
            def level, levelName, challenge, challengeType, question, answer, key, info
            def infoJSON = [:]

            for (Document doc : challCollection) {
                for (Object o : doc.stats) {

                    level     = o.levelId
                    levelName = o.levelName
                    challenge = o.challengeId
                    challengeType = o.challengeType

                    if(challengeType == "multipleChoice" || challengeType == "questionAndAnswer")
                        question = o.question
                    else if(challengeType == "shuffleWord")
                        question = o.word
                    else if(challengeType == "dragPictures")
                        question = o.initialSequence

                    answer = o.correctAnswer

                    key  = new Tuple(level, challenge)
                    info = [levelName, question, answer]

                    if( !(gameInfo.containsKey(key)) )
                        gameInfo.put(key, info)

                }
            }

            gameInfo = gameInfo.sort { it.key.get(1) }

            for (entry in gameInfo) {

                challenge = entry.key.get(1)
                levelName = entry.value.get(0)
                question  = entry.value.get(1)
                answer    = entry.value.get(2)

                if (!infoJSON.containsKey(levelName))
                    infoJSON.put(levelName, [])

                infoJSON[levelName].add([("Desafio " + challenge), question, answer])
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "gameInfo: " + gameInfo
            //println "infoJSON: " + infoJSON

            return infoJSON

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return game info for exportedResource " + exportedResourceId
            return null
        }
    }

    //TEMPO DE CONCLUSÃO DE JOGO
    def getGameConclusionTime (int exportedResourceId, List<Long> users) {

        println("cheguei em getGameConclusionTime");

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def usersTime = [:] // [ usuarioID: conclusionTime ]
            def user, timeType, time

            for (Document doc : timeCollection) {

                user = doc.userId

                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time     = o.time

                    if (timeType == 0 && time > 0.0) {

                        if (usersTime.containsKey(user)) {
                            if (usersTime[user] > time) {
                                usersTime[user] = time
                            }
                        } else {
                            usersTime[user] = time
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
            def user, timeType, time, levelName

            for (Document doc : timeCollection) {

                user = doc.userId

                for (Object o: doc.stats) {

                    timeType = o.timeType
                    time = o.time

                    if (timeType == 1 && time == 0.0) {
                        levelName = o.levelName

                        // Se level ja esta no mapa
                        if (usersInLevel.containsKey(levelName)) {

                            // e o usuario nao esta na lista de usuarios que jogaram, adiciona
                            if ( ! usersInLevel[levelName].contains(user) ) {
                                usersInLevel[levelName].add(user)
                            }

                        // se nao esta no mapa, coloca
                        } else {
                            usersInLevel.put(levelName, [user])
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
            def timeType, time, levelName

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time     = o.time

                    if (timeType == 1 && time == 0.0) {

                        levelName = o.levelName

                        if (levelAttempts.containsKey(levelName)) {
                            levelAttempts[levelName] += 1
                        } else {
                            levelAttempts.put(levelName, 1)
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
    def getLevelAttemptRatio (int exportedResourceId, List<Long> users)     {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def levelAttempts = [:]
            def user, timeType, time, levelName
            def tuple

            for (Document doc : timeCollection) {

                user = doc.userId

                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time     = o.time
                    levelName = o.levelName

                    if (timeType == 1) {

                        tuple = new Tuple(user, levelName)

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

            return levelAttempts.sort { it.value[0] }

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
            def user, timeType, time, levelName

            for (Document doc : timeCollection) {

                user = doc.userId

                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time = o.time

                    if (timeType == 1 && time > 0.0) {

                        levelName = o.levelName

                        if (timePerLevel.containsKey(levelName)) {

                            if ( timePerLevel[levelName].containsKey(user) ) {
                                timePerLevel[levelName][user].add( time )
                            } else {
                                timePerLevel[levelName].put( user, [time] )
                            }
                        } else {
                            timePerLevel.put( levelName, [(user): [time]] )
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
            def timeType, time, levelName

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time = o.time

                    if (timeType == 1 && time > 0.0) {

                        levelName = o.levelName

                        if (timePerLevel.containsKey(levelName)) {
                            timePerLevel[levelName].add(time)
                        } else {
                            timePerLevel.put( levelName, [time] )
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerLevel: " + timePerLevel

            return timePerLevel.each { it.value.sort() }

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
            def user, timeType, time, levelName, chall
            def tuple // tupla [level, challenge, user] como chave do mapa. OBS: user é long

            for (Document doc : timeCollection) {

                user = doc.userId

                for (Object o : doc.stats) {

                    timeType  = o.timeType
                    time      = o.time
                    levelName = o.levelName
                    chall     = "Desafio ${o.challengeId}"

                    if (timeType == 2 && time > 0.0) {

                        tuple = new Tuple (levelName, chall)

                        if ( timePerChallenge.containsKey( tuple ) ) {

                            if ( timePerChallenge[tuple].containsKey( user ) ) {
                                timePerChallenge[tuple][user].add(time)
                            } else {
                                timePerChallenge[tuple].put( user, [time] )
                            }

                        } else {
                            timePerChallenge.put( tuple, [(user): [time]] )
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

    //TODOS OS TEMPOS GASTOS DE TODOS DO GRUPO EM CADA LEVEL
    def getChallTime (int exportedResourceId, List<Long> users) {

        def timeCollection = getStats("timeStats", exportedResourceId, users)

        if(timeCollection.size() > 0) {

            def timePerChall = [:]
            def timeType, time, key

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time     = o.time

                    if (timeType == 2 && time > 0.0) {

                        key  = new Tuple(o.levelName, "Desafio " + o.challengeId)

                        if (!timePerChall.containsKey(key))
                            timePerChall.put(key, [])

                        timePerChall[key].add(time)
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerChall: " + timePerChall

            return timePerChall.each { it.value.sort() }

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }
    }

    //NÚMERO DE TENTATIVAS POR DESAFIO
    def getChallAttempt (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if(statsCollection.size() > 0) {

            def challAttempts = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    tuple = new Tuple (o.levelName, "Desafio ${o.challengeId}")

                    if (challAttempts.containsKey(tuple)) {
                        challAttempts[tuple] += 1
                    } else {
                        challAttempts.put(tuple, 1)
                    }

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

    //TOTAL DE ERROS POR DESAFIO
    def getChallMistakes(int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.win == false) {

                        tuple = new Tuple( o.levelName, ("Desafio ${o.challengeId}") )

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

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple
            def hitOrMiss, temp

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    tuple = new Tuple( doc.userId, o.levelName, ("Desafio " + (o.challengeId)) )

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

            // Para DEBUG -> descomente a linha abaixo
            //println "challMistakes: " + challMistakes

            return challMistakes.sort { it.value[0] + it.value[1] }

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return challenge mistakes for resource " + exportedResourceId
            return null
        }

    }

    //FREQUÊNCIA DE ESCOLHAS DOS DESAFIOS
    def getChoiceFrequency (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def choiceFrequency = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    tuple = new Tuple( o.levelName, ("Desafio ${o.challengeId}"),  o.answer.toLowerCase(), o.correctAnswer.toLowerCase())

                    if (choiceFrequency.containsKey(tuple))
                        choiceFrequency[tuple] += 1
                    else
                        choiceFrequency.put(tuple, 1)
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "choiceFrequency: " + choiceFrequency

            return choiceFrequency.sort { -it.value }

        } else {
            // TODO: Deveria enviar erro - e ao invés de printar ser log.debug
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
            return null
        }

    }

    //FREQUÊNCIA DE ESCOLHAS DOS DESAFIOS POR USUÀRIO
    def getPlayerChoiceFrequency (int exportedResourceId, List<Long> users) {

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def choiceFrequency = [:]
            def user
            def tuple

            for (Document doc : statsCollection) {

                user = doc.userId

                for (Object o : doc.stats) {

                    tuple = new Tuple( user, o.levelName, ("Desafio ${o.challengeId}"),  o.answer.toLowerCase(), o.correctAnswer.toLowerCase())

                    if (choiceFrequency.containsKey(tuple))
                        choiceFrequency[tuple] += 1
                    else
                        choiceFrequency.put(tuple, 1)
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "choiceFrequency: " + choiceFrequency

            return choiceFrequency.sort { -it.value }

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
            def tuple

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    if (o.timeType == 1 && o.time == 0) {

                        tuple = new Tuple(doc.userId, o.levelName)

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

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if(statsCollection.size() > 0) {

            def challAttempts = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    tuple = new Tuple (doc.userId, o.levelName, "Desafio ${o.challengeId}")

                    if (challAttempts.containsKey(tuple)) {
                        challAttempts[tuple] += 1
                    } else {
                        challAttempts.put(tuple, 1)
                    }

                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "challAttempts: " + challAttempts

            return challAttempts.sort { it.key.get(2) }

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
            def timeType, time
            def tuple

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    timeType  = o.timeType
                    time      = o.time

                    if (timeType == 1 && time > 0.0) {

                        tuple = new Tuple (doc.userId, o.levelName)

                        if (timePerLevel.containsKey(tuple))
                            timePerLevel[tuple].add( time )
                        else
                            timePerLevel.put( tuple, [time] )
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

        def statsCollection = getStats("challengeStats", exportedResourceId, users)

        if (statsCollection.size() > 0) {

            def challMistakes = [:]
            def tuple

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {

                    if (o.win == false) {

                        tuple = new Tuple( doc.userId, o.levelName, ("Desafio ${o.challengeId}") )

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

            return challMistakes.sort { it.key.get(2) }

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
            def timeType, time
            def tuple

            for (Document doc : timeCollection) {
                for (Object o : doc.stats) {

                    timeType = o.timeType
                    time     = o.time

                    if (timeType == 2 && time > 0.0) {

                        tuple = new Tuple (doc.userId, o.levelName, "Desafio ${o.challengeId}")

                        if (timePerChallenge.containsKey(tuple)) {
                             timePerChallenge[tuple].add(time)
                        } else {
                            timePerChallenge.put( tuple, [time] )
                        }
                    }
                }
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerChallenge: " + timePerChallenge

            return timePerChallenge.sort { it.key.get(2) }

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

        def grupolocal = [2, 3, 4]
        def exportedResourceId = 1

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

        // lista de tempos gasto para conclusão de cada desafio
        //MongoHelper.instance.getChallTime(exportedResourceId, grupolocal)

        // número de tentativas por desafio
        //MongoHelper.instance.getChallAttempt(exportedResourceId, grupolocal)

        // total de erros por desafio
        //MongoHelper.instance.getChallMistakes(exportedResourceId, grupolocal)

        // total de tentativas e tentativas concluidas em cada desafio por jogador
        MongoHelper.instance.getChallMistakesRatio(exportedResourceId, grupolocal)

        // frequência de escolhas dos desafios
        //MongoHelper.instance.getChoiceFrequency(exportedResourceId, grupolocal)

        //frequência de escolhas dos desafios por usuário
        //MongoHelper.instance.getPlayerChoiceFrequency (exportedResourceId, grupolocal)

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
