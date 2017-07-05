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

        if(selectedCollection.find(new Document('userId', data.userId)).size() != 0) {
            println "updating"
            println data.gameType
            if(data.gameType == 'puzzleWithTime') {
                selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("stats",
                        new Document()
                                .append("points", data.points)
                                .append("partialPoints", data.partialPoints)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("remainingTime", data.remainingTime)
                                .append("gameSize", data.gameSize)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)
                )))
            } else if(data.gameType == 'questionAndAnswer') {
                selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("stats",
                        new Document()
                                .append("points", data.points)
                                .append("partialPoints", data.partialPoints)
                                .append("errors", data.errors)
                                .append("question", data.question)
                                .append("answer", data.answer)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("gameSize", data.gameSize)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)
                )))
            } else if(data.gameType == 'multipleChoice'){
                selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("stats",
                        new Document()
                                .append("question", data.question)
                                .append("answer", data.answer)
                                .append("choices", data.choices)
                                .append("choice", data.choice)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)
                                .append("gameSize", data.gameSize)
                )))
            } else if(data.gameType == 'ranking') {
                selectedCollection.updateOne(new Document("userId", data.userId).append("stats",
                        asList(new Document()
                            .append("gameType", data.gameType)
                            .append("exportedResourceId", data.exportedResourceId)
                            .append("score", data.score)
                        )))
            }

        }else{
            println "creating"
            println data.gameType

            if(data.gameType == 'puzzleWithTime'){
                selectedCollection.insertOne(new Document("userId", data.userId).append("stats",
                        asList(new Document()
                                .append("points", data.points)
                                .append("partialPoints", data.partialPoints)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("remainingTime", data.remainingTime)
                                .append("gameSize", data.gameSize)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)

                        )))
            } else if(data.gameType == 'questionAndAnswer') {
                selectedCollection.insertOne(new Document("userId", data.userId).append("stats",
                        asList(new Document()
                                .append("points", data.points)
                                .append("partialPoints", data.partialPoints)
                                .append("errors", data.errors)
                                .append("question", data.question)
                                .append("answer", data.answer)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("gameSize", data.gameSize)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)

                        )))
            } else if(data.gameType == 'multipleChoice') {
                selectedCollection.insertOne(new Document("userId", data.userId).append("stats",
                        asList(new Document()
                                .append("question", data.question)
                                .append("answer", data.answer)
                                .append("choices", data.choices)
                                .append("choice", data.choice)
                                .append("win", data.win)
                                .append("levelId", data.levelId)
                                .append("exportedResourceId", data.exportedResourceId)
                                .append("timestamp", data.timestamp)
                                .append("gameType", data.gameType)
                                .append("gameSize", data.gameSize)
                        )))
            } else if(data.gameType == 'ranking') {
                selectedCollection.insertOne(new Document("userId", data.userId).append("stats",
                        asList(new Document()
                            .append("gameType", data.gameType)
                            .append("exportedResourceId", data.exportedResourceId)
                            .append("score", data.score)
                        )))
            }
        }
    }

    def insertRank(Object data) {
        def rankingCollection = db.getCollection("ranking");

        if (rankingCollection.find(new Document("userId", data.userId)).size() != 0) {
            def lista = getScore(data.exportedResourceId, data.userId)
            def score = (lista.size() > 0) ? lista[0].ranking.score[0] as int : -1

            println lista
            println lista.size()
            println score

            if ((data.score as int) > score) {
                println "deleting"

                rankingCollection.deleteOne(new Document("userId", data.userId).append("ranking",
                    asList(new Document()
                        .append("exportedResourceId", data.exportedResourceId)
                    )))

                println "updating"

                rankingCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("ranking",
                    new Document()
                        .append("exportedResourceId", data.exportedResourceId)
                        .append("score", data.score)
                        .append("timestamp", data.timestamp)
                    )))
            } else {
                println "nothing to update"
            }
        } else {
            println "creating"

            rankingCollection.insertOne(new Document("userId", data.userId).append("ranking",
                asList(new Document()
                    .append("exportedResourceId", data.exportedResourceId)
                    .append("score", data.score)
                    .append("timestamp", data.timestamp)
                )))
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
                            .append("monster", data.monster)
                            .append("timestamp", data.timestamp)
                            .append("exportedResourceId", data.exportedResourceId)
                            .append("gameType", data.gameType)
            )))
        }else {

            selectedCollection.insertOne(new Document("userId", data.userId).append("playStats",
                    asList(new Document()
                            .append("level", data.level)
                            .append("sector", data.sector)
                            .append("monster", data.monster)
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

    def getScore(int exportedResourceId, Long userId) {
        return db.getCollection("ranking").find(new Document('userId', userId)
            .append("ranking.exportedResourceId", exportedResourceId))
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

}
