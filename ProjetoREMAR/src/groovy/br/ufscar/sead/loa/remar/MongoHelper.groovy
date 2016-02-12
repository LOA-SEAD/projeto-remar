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

    def insertTestData(String collection) {
        db.getCollection(collection).insertOne(
            new Document (
                "address",
                new Document()
                    .append("street", "2 Avenue")
                    .append("zipcode", "10075")
                    .append("building", "1480")
            )
            .append("borough", "Manhattan")
            .append("cuisine", "Italian")
        )
    }

    def insertData(String collection, Document data) {
        db.getCollection(collection).insertOne(data)
    }

}
