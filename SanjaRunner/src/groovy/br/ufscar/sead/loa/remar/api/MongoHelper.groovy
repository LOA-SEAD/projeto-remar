package br.ufscar.sead.loa.remar.api

import com.mongodb.MongoClient
import com.mongodb.MongoClientOptions
import com.mongodb.MongoCredential
import com.mongodb.ServerAddress
import com.mongodb.client.MongoDatabase
import grails.util.Holders
import org.bson.Document
import org.bson.types.ObjectId

class MongoHelper {
    static boolean inited
    static MongoDatabase db

    static String putFile(String path) {
        if (!inited) {
            def dataSource = Holders.grailsApplication.config.dataSource as Map
            def credential = MongoCredential.createCredential(dataSource.username as String,
                    'admin', dataSource.password as char[])
            def options = MongoClientOptions.builder().serverSelectionTimeout(1000).build()

            db = new MongoClient(new ServerAddress(dataSource.dbHost as String), Arrays.asList(credential), options).getDatabase('remar')
        }
        ObjectId id = new ObjectId()
        db.getCollection('file').insertOne(
                new Document()
                        .append('_id', id)
                        .append('path', path))

        return id.toString()
    }
}