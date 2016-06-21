package br.ufscar.sead.loa.remar

import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import org.bson.Document
import org.bson.types.ObjectId


@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db

    def init(Map options) {
        def credential = MongoCredential.createCredential(options.username as String, 'admin',
                options.password as char[])

        this.mongoClient = new MongoClient(new ServerAddress(), Arrays.asList(credential))
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

    def getData(String collection, int resourceId) {
        return db.getCollection(collection).find(new Document("game", resourceId))
    }

    def getData(String collection, int resourceId, int userId) {
        return db.getCollection(collection).find(new Document ("game", resourceId).append("user", userId))
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