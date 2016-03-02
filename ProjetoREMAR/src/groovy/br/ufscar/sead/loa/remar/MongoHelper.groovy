package br.ufscar.sead.loa.remar

import com.mongodb.client.MongoDatabase
import com.mongodb.MongoClient
import org.bson.Document
import org.bson.types.ObjectId


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
        if (collectionName in db.listCollectionNames()) {
            println "Collection '${collectionName}' already exists."
        }
        else {
            db.createCollection(collectionName)
            println "COllection '${collectionName}' succssesfully created."
        }
    }

    def insertData(String collection, Document data) {
        db.getCollection(collection).insertOne(data)
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