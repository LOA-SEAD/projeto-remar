package br.ufscar.sead.loa.remar

import com.mongodb.BasicDBObject
import com.mongodb.Block
import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.FindIterable
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import com.mongodb.client.MongoIterable
import com.mongodb.client.model.Filters
import com.mongodb.FindIterableImpl
import org.bson.Document
import org.bson.types.ObjectId

import static java.util.Arrays.asList
import static java.util.Arrays.parallelSetAll;

@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

    def init(Map options) {
        def credential = MongoCredential.createCredential(options.username as String, 'admin', options.password as char[])

        this.mongoClient = new MongoClient(new ServerAddress(options.dbHost as String), asList(credential))
        this.db = mongoClient.getDatabase('remar')
        /*MongoIterable<String> names = db.listCollectionNames()

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

    def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection).find(new Document('userId', new Document('$in', userGroup)).append("stats.exportedResourceId", exportedResourceId)).sort {
            userId: 1
        }
    }

    def getStats(String collection, int exportedResourceId, Long userId) {
        return db.getCollection(collection).find(new Document('userId', userId).append("stats.exportedResourceId", exportedResourceId))
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

    /**
    ==========================================
    **/

    //TEMPO DE CONCLUSÃO DE JOGO
    def getGameConclusionTime (Long exportedResourceId) {

        def timeCollection = db.getCollection("timeStats")
        def docs = timeCollection.find(new Document('timeStats.exportedResourceId', exportedResourceId))

        // Lista de mapas
        def usersTime = [] // [ [usuarioID: , conclusionTime: y] ]
        def index
        def timeAsDouble

        for (Document doc : docs) {
            for (Object o: doc.timeStats) {
                if (o.exportedResourceId == exportedResourceId && o.type == '0' && (o.time as double) > 0.0) {

                    // Se usuario ja esta na lista de mapas
                    index = usersTime.findIndexOf { it.userId == o.userId }
                    if(index != -1) {

                        // e o valor do tempo eh menor, atualiza
                        if(usersTime[index]["conclusionTime"] > (o.time as double)) {
                            usersTime[index]["conclusionTime"] = o.time as double
                        }

                    // se nao esta no lista, coloca
                    } else {
                        usersTime.add( ["userId" : o.userId, "conclusionTime" : o.time as double] )
                    }
                }
            }
        }

        // Para DEBUG -> descomente a linha abaixo
        //println "usersTime: " + usersTime

        // TODO: Deveria enviar erro ao inves de printar
        if (usersTime.size() == 0) println "ERROR: Could not return conclusion time for resource " + exportedResourceId
        return usersTime
    }

    //NÚMERO DE ALUNOS EM CADA NÍVEL
    def getUsersInLevels(Long exportedResourceId) {

        def statsCollection = db.getCollection("stats")

        def docs = statsCollection.find(new Document('stats.exportedResourceId', exportedResourceId))

        // Lista de mapas
        def usersInLevel = [] // [ [gameLevel: , gameLevelName: , usersId: [(lista dos ids)] ] ]
        def index

        for (Document doc : docs) {
            for (Object o: doc.stats) {
                if (o.exportedResourceId == exportedResourceId) {

                    // Se level ja esta na lista de mapas
                    index = usersInLevel.findIndexOf { it.gameLevel == o.gameLevel }
                    if(index != -1) {

                        // e o usuario nao esta na lista de usuarios que jogaram, adiciona
                        if(!usersInLevel[index]["usersId"].contains(o.userId)) {
                            usersInLevel[index]["usersId"].add(o.userId)
                        }

                    // se nao esta na lista, coloca
                    } else {
                        usersInLevel.add( ["gameLevel" : o.gameLevel, "gameLevelName": o.gameLevelName, "usersId" : [o.userId]] )
                    }
                }
            }
        }

        // Para DEBUG -> descomente a linha abaixo
        //println "usersInLevel: " + usersInLevel

        // TODO: Deveria enviar erro ao inves de printar
        if (usersInLevel.size() == 0) println "ERROR: Could not return conclusion time for resource " + exportedResourceId
        return usersInLevel
    }

    //NÚMERO DE TENTATIVAS POR NÍVEL
    def getLevelsAttempts (Long exportedResourceId, Long[] users) {

        def timeCollection = db.getCollection("timeStats")
                .find([ 'timeStats.exportedResourceId' : exportedResourceId ] as BasicDBObject)
                .projection([ _id: 0, 'timeStats.userId': 1, 'timeStats.exportedResourceId': 1,
                              'timeStats.time': 1, 'timeStats.type': 1, 'timeStats.gameLevel' : 1 ] as BasicDBObject)

        def levelAttempts = [:]

        for (Document doc : timeCollection) {
            for (Object o: doc.timeStats) {
                if (o.exportedResourceId == exportedResourceId
                        && o.time == '0'
                        && o.type == '1'
                        && o.userId in users) {

                    if(levelAttempts.containsKey(o.gameLevel as int)) {
                        levelAttempts[o.gameLevel as int] += 1
                    } else {
                        levelAttempts.put(o.gameLevel as int, 1)
                    }
                }
            }
        }

        if (levelAttempts.size() > 0) {

            def statsCollection = db.getCollection("stats")
                    .find( [ 'stats.exportedResourceId' : exportedResourceId ] as BasicDBObject)
                    .projection([ _id: 0, 'stats.exportedResourceId': 1,
                                  'stats.gameLevel' : 1, 'stats.gameLevelName' : 1] as BasicDBObject)

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {
                    if (o.exportedResourceId == exportedResourceId) {

                        if (levelAttempts.containsKey(o.gameLevel)) {
                            levelAttempts.put(o.gameLevelName, levelAttempts[o.gameLevel])
                            levelAttempts.remove(o.gameLevel)
                        }
                    }
                }
            }

            if (levelAttempts.containsKey(5)) {
                levelAttempts.put("Fase Refeitório", levelAttempts[5])
                levelAttempts.remove(5)
            }

            if (levelAttempts.containsKey(1)) {
                levelAttempts.put("Fase Galeria", levelAttempts[1])
                levelAttempts.remove(1)
            }

            // Para DEBUG -> descomente as linhas abaixo
            //println "levelAttempts: " + levelAttempts

            return levelAttempts

        } else {
            // TODO: Deveria enviar erro ao inves de printar
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
        }
    }

    //NÚMERO DE TENTATIVAS POR DESAFIO
    def getChallengesAttempts (Long exportedResourceId, int gameLevel) {
        def timeCollection = db.getCollection("timeStats").find({ exportedResourceId: exportedResourceId })
        //def docs = timeCollection.find(new Document('timeStats.exportedResourceId', exportedResourceId))

        // Para evitar erros de typecast null -> int
        def level = gameLevel.toString()

        def challAttempts = [:] //[challenge: num_of_attempts]

        for (Document doc : docs) {
            for (Object o: doc.timeStats) {

                if (o.exportedResourceId == exportedResourceId
                        && o.gameLevel == level
                        && o.type == '2' && o.time == '0') {

                    if(challAttempts.containsKey(o.challengeId)) {
                        challAttempts.put(o.challengeId, challAttempts.get(o.challengeId) + 1)
                    } else {
                        challAttempts.put(o.challengeId, 1)
                    }
                }
            }
        }

        // TODO: Deveria enviar erro ao inves de printar
        if (challAttempts.size() == 0) println "ERROR: Could not return conclusion time for resource " + exportedResourceId
        return challAttempts
    }

    //TEMPO DE CONCLUSÃO DE CADA NÍVEL
    def getLevelTime (Long exportedResourceId, Long[] users) {

        def timeCollection = db.getCollection("timeStats")
                .find([ 'timeStats.exportedResourceId' : exportedResourceId ] as BasicDBObject)
                .projection([ _id: 0, 'timeStats.userId': 1, 'timeStats.exportedResourceId': 1,
                              'timeStats.time': 1, 'timeStats.type': 1, 'timeStats.gameLevel' : 1 ] as BasicDBObject)

        def timePerLevel = [:]
        def levelInt
        def timeDouble

        for (Document doc : timeCollection) {
            for (Object o: doc.timeStats) {
                if (o.exportedResourceId == exportedResourceId
                    && o.type as int == 1
                    && o.time as double != 0
                    && o.userId in users) {

                    levelInt = o.gameLevel as int
                    timeDouble = o.time as double

                    if(timePerLevel[levelInt]) {
                        if (timePerLevel[levelInt][o.userId]) {
                            if (timePerLevel[levelInt][o.userId] > (timeDouble)) {
                                timePerLevel[levelInt][o.userId] = timeDouble
                            }
                        } else {
                            timePerLevel[levelInt].put(o.userId, timeDouble)
                        }
                    } else {
                        timePerLevel.put(levelInt, [(o.userId): (timeDouble)])
                    }
                }
            }
        }

        if (timePerLevel.size() > 0) {

            def statsCollection = db.getCollection("stats")
                    .find( [ 'stats.exportedResourceId' : exportedResourceId ] as BasicDBObject)
                    .projection([ _id: 0, 'stats.exportedResourceId': 1,
                                  'stats.gameLevel' : 1, 'stats.gameLevelName' : 1] as BasicDBObject)

            for (Document doc : statsCollection) {
                for (Object o : doc.stats) {
                    if (o.exportedResourceId == exportedResourceId) {

                        if (timePerLevel.containsKey(o.gameLevel)) {
                            timePerLevel.put(o.gameLevelName, timePerLevel[o.gameLevel])
                            timePerLevel.remove(o.gameLevel)
                        }
                    }
                }
            }

            if (timePerLevel.containsKey(5)) {
                timePerLevel.put("Fase Refeitório", timePerLevel[5])
                timePerLevel.remove(5)
            }

            if (timePerLevel.containsKey(1)) {
                timePerLevel.put("Fase Galeria", timePerLevel[1])
                timePerLevel.remove(1)
            }

            // Para DEBUG -> descomente a linha abaixo
            //println "timePerLevel: " + timePerLevel

            return timePerLevel

        } else {
            // TODO: Deveria enviar erro ao inves de printar
            println "ERROR: Could not return conclusion time for resource " + exportedResourceId
        }
    }

    //TEMPO DE CONCLUSÃO DE CADA DESAFIO
    def getTempoDesafio (Long exportedResourceId) {
        def timeCollection = db.getCollection("timeStats")
        def docs = timeCollection.find(new Document('timeStats.exportedResourceId', exportedResourceId))

        println "Usuário, Nível, Desafio, Tempo"

        for (Document doc : docs) {
            for (Object o: doc.timeStats) {
                if (o.exportedResourceId == exportedResourceId && o.type as int == 2 && o.time as double != 0) {
                    println o.userId + ", " + o.gameLevel + ", " + o.challengeId + ", "+ o.time
                }
            }
        }
    }

    //DESAFIOS COM MAIOR TAXA DE ERRO
    def getTaxaErrosDesafio (Long exportedResourceId) {
        def statsCollection = db.getCollection("stats")
        def docs = statsCollection.find(new Document('stats.exportedResourceId', exportedResourceId))

        println "Nível, Desafio, Número de erros"

        for (Document doc : docs) {
            for (Object o: doc.stats) {
                if (o.exportedResourceId == exportedResourceId && o.win == false) {
                    println o.gameLevelName + ", " + o.challengeId
                }
            }
        }
    }

    //FREQUÊNCIA DE ESCOLHAS POR DESAFIO
    def getFrequenciaEscolhaDesafio (Long exportedResourceId) {
        def statsCollection = db.getCollection("stats")
        def docs = statsCollection.find(new Document('stats.exportedResourceId', exportedResourceId))

        println "Nível, Desafio, Escolha, Frequência"

        for (Document doc : docs) {
            for (Object o: doc.stats) {
                if (o.exportedResourceId == exportedResourceId) {
                    println o.gameLevelName + ", " + o.challengeId + ", " + o.choice
                }
            }
        }
    }


    //PRINCIPAL
    static void main(String... args) {

        MongoHelper.instance.init([dbHost  : 'alfa.remar.online',
                                   username: 'root',
                                   password: 'root'])

        //chamando o método para mostrar o ranking dos alunos que concluíram o jogo
        //MongoHelper.instance.getRanking(12)

        //chamando o método para mostrar o tempo gasto para conclusão do jogo
        //MongoHelper.instance.getGameConclusionTime(9)

        //chamando o método para mostrar a quantidade de alunos por nível
        //MongoHelper.instance.getUsersInLevels(3)

        //chamando o método para mostrar o número de tentativas por nível
        MongoHelper.instance.getLevelsAttempts(5, [2, 3, 68, 195] as Long[])

        //chamando o método para mostrar o número de tentativas por desafio
        //MongoHelper.instance.getChallengesAttempts(3,1)

        //chamando o método para mostrar o tempo gasto para conclusão de cada nível
        //MongoHelper.instance.getLevelTime(5, [3, 68, 2, 195] as Long[])

        //chamando o método para mostrar o tempo gasto para conclusão de cada desafio
        //MongoHelper.instance.getTempoDesafio(3)

        //chamando o método para mostrar os desafios com maior taxa de erro
        //MongoHelper.instance.getTaxaErrosDesafio(1)

        //chamando o método para mostrar a frequência de escolhas por desafio
        //MongoHelper.instance.getFrequenciaEscolhaDesafio(3)
    }
}
