package br.ufscar.sead.loa.remar

import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import org.bson.Document
import org.bson.types.ObjectId

import static java.util.Arrays.asList;

@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

    def init(Map options) {
        def credential = MongoCredential.createCredential(options.username as String, 'admin',
                options.password as char[])

        this.mongoClient = new MongoClient(new ServerAddress(), asList(credential))
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
            selectedCollection.updateOne(new Document("userId", data.userId), new Document('$push', new Document("stats",
                    new Document()
                             .append("points", data.points)
                             .append("partialPoints", data.partialPoints)
                             .append("errors", data.errors)
                             .append("question", data.question)
                             .append("answer", data.answer)
                             .append("win", data.win)
                             .append("levelId", data.levelId)
                             .append("exportedResourceId", data.exportedResourceId)
                             .append("timestamp", data.timestamp)
            )))

        }else{
            println "creating"
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

            )))
        }
    }

    def getData(String collection, int resourceId) {
        return db.getCollection(collection).find(new Document("game", resourceId))
    }

    def getData(String collection, int resourceId, int userId) {
        return db.getCollection(collection).find(new Document ("game", resourceId).append("user", userId))
    }

    def getStats(String collection, int exportedResourceId, List<Long> userGroup) {
        return db.getCollection(collection).find(new Document('userId', new Document('$in', userGroup)).append("stats.exportedResourceId", exportedResourceId)).sort({userId: 1})
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
}