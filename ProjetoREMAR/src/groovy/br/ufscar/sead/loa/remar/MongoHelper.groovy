package br.ufscar.sead.loa.remar

import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import com.mongodb.util.JSON
import org.bson.Document


@Singleton
class MongoHelper {

    MongoClient mongoClient
    MongoDatabase db
    String dbName = 'remar'

    def init() {
        this.mongoClient = new MongoClient()
        this.db = mongoClient.getDatabase(dbName)
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

    def insertData(String collection, Document data) {
        db.getCollection(collection).insertOne(data)
    }

}
