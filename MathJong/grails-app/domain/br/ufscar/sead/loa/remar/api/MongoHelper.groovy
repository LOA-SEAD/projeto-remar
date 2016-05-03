package br.ufscar.sead.loa.remar.api

import com.mongodb.MongoClient
import com.mongodb.client.MongoDatabase
import org.bson.Document
import org.bson.types.ObjectId

/**
 * Created by matheus on 3/2/16.
 * https://github.com/matheuss
 */
class MongoHelper {
    static boolean inited
    static MongoDatabase db

    static String putFile(String path) {
        if (!inited) {
            db = new MongoClient().getDatabase('remar')
        }
        ObjectId id = new ObjectId()
        db.getCollection('file').insertOne(
                new Document()
                        .append('_id', id)
                        .append('path', path))

        return id.toString()
    }
}