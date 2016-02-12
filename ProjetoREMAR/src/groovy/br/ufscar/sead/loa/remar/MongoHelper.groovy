package br.ufscar.sead.loa.remar

import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
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
        db.createCollection(collectionName)
    }

    def insertData(String collection, Document data) {
        db.getCollection(collection).insertOne(data)
    }

}
