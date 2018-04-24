package br.ufscar.sead.loa.remar

import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import com.mongodb.client.model.Filters
import com.mongodb.FindIterableImpl
import org.bson.Document
import org.bson.types.ObjectId

import static java.util.Arrays.asList;

@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

    def init(Map options) {
        def credential = MongoCredential.createCredential(options.username as String, 'admin', options.password as char[])

        this.mongoClient = new MongoClient(new ServerAddress(options.dbHost as String), asList(credential))
        this.db = mongoClient.getDatabase('remar')
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

    def insertStats(String collection, Object data){
        def selectedCollection = db.getCollection(collection);

        Document doc = new Document(data)

        if(selectedCollection.find(new Document('userId', data.userId)).size() != 0) {
            println "updating"
            println data.gameType

            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("stats", doc)))

        }else{
            println "creating"
            println data.gameType

            selectedCollection.insertOne(new Document("userId", data.userId).append("stats", asList(doc)))

        }
    }

    def insertPlayStats(String collection, Object data){
        def selectedCollection = db.getCollection(collection);

        println "insertPlayStats: " + data

        if(selectedCollection.find(new Document('userId', data.userId)).size() != 0) {

            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("playStats",
                    new Document()
                            .append("level", data.level)
                            .append("sector", data.sector)
                            .append("damage", data.damage)
                            .append("timestamp", data.timestamp)
                            .append("exportedResourceId", data.exportedResourceId)
                            .append("gameType", data.gameType)
            )))
        }else {

            selectedCollection.insertOne(new Document("userId", data.userId).append("playStats",
                    asList(new Document()
                            .append("level", data.level)
                            .append("sector", data.sector)
                            .append("damage", data.damage)
                            .append("timestamp", data.timestamp)
                            .append("exportedResourceId", data.exportedResourceId)
                            .append("gameType", data.gameType)
                    )))
        }

        /* def lista = db.getCollection(collection).find()

        for (Object o: lista) {
            println o
        } */
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
        return db.getCollection(collection).find(new Document ("game", resourceId).append("user", userId))
    }

    def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection).find(new Document('userId', new Document('$in', userGroup)).append("stats.exportedResourceId", exportedResourceId)).sort{userId: 1}
    }

    def getStats(String collection, int exportedResourceId, Long userId) {
        return db.getCollection(collection).find(new Document('userId', userId).append("stats.exportedResourceId", exportedResourceId))
    }

    def getCollectionForId(String collection,String id){
        return db.getCollection(collection).find(new Document("_id", new ObjectId(id)))
    }

    def getCollection(String collection,Long id){
        return db.getCollection(collection).find(new Document("id", id))
    }

    def addCollection(String name){
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

    def removeDataFromUri(String collectionName, String value){
        db.getCollection(collectionName).deleteOne(Filters.in("uri",value))
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

        if (ranking.size() == 0) println "ERROR: Could not return ranking for resource " + exportedResourceId
        return ranking
    }

}
