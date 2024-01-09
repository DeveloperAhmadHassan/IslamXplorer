import pymongo
import json
import os

from bson import ObjectId
import bson
from models.dua import Dua
from conn.mongodb_conn import MongoDBConn


class DuaCon:
    @staticmethod
    def getAllDuas():
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

            cursor = quranicDuaCollection.find()
            jsonData = setMongoDBJson(cursor, ["_id", "title", "englishText", "arabicText", "transliteration", "surah"])

            MongoDBConn.closeClient(mongoClient)

            return jsonData

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MongoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def getDuaByID(duaID: str):
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

            objectID = ObjectId(duaID)
            cursor = quranicDuaCollection.find({"_id": objectID})
            jsonData = setMongoDBJson(cursor)

            MongoDBConn.closeClient(mongoClient)

            return jsonData

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MongoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def getAllDuaTypes():
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            duaTypesCollection = MongoDBConn.getTypesCollection(duaMongoDB)

            cursor = duaTypesCollection.find()
            jsonData = setMongoDBJson(cursor)

            MongoDBConn.closeClient(mongoClient)

            return jsonData

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MongoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def getDuasFromType(duaType: str):
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

            cursor = quranicDuaCollection.find({"types": duaType})
            jsonData = setMongoDBJson(cursor, ["_id", "title", "englishText", "arabicText", "transliteration", "surah"])

            MongoDBConn.closeClient(mongoClient)

            return jsonData

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MongoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def addDua(dua: Dua):
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

            duaJson = dua.to_dict()
            x = quranicDuaCollection.insert_one(duaJson)

            MongoDBConn.closeClient(mongoClient)

            return json.dumps(
                {
                    'status': 201,
                    'insertedDuaID': x.inserted_id,
                    'acknowledged': x.acknowledged
                },
                ensure_ascii=False, default=str, indent=2
            )

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MongoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def deleteDuaByID(duaID: str):
        try:
            mongoClient = MongoDBConn.createMongoDBConnection()
            duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
            quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

            try:
                objectID = ObjectId(duaID)
            except bson.errors.InvalidId as id_error:
                MongoDBConn.closeClient(mongoClient)
                return {'error': f'Dua ID error: {str(id_error)}'}

            cursor = quranicDuaCollection.delete_one({"_id": objectID})

            MongoDBConn.closeClient(mongoClient)

            return json.dumps({
                "status": 200,
                "message": "Successfully Deleted!",
                "count": cursor.deleted_count,
                "acknowledged": cursor.acknowledged
            }, ensure_ascii=False, default=str, indent=2)

        except pymongo.errors.PyMongoError as mongo_error:
            return {'error': f'MondoDB error: {str(mongo_error)}'}

        except Exception as other_error:
            return {'error': f'Unexpected error: {str(other_error)}'}

    @staticmethod
    def updateDuaByID(duaID: str, dua: Dua):
        mongoClient = MongoDBConn.createMongoDBConnection()
        duaMongoDB = MongoDBConn.getDuaMongoDB(mongoClient)
        quranicDuaCollection = MongoDBConn.getQuranicDuaCollection(duaMongoDB)

        print("ID: " + dua.id)

        try:
            objectID = ObjectId(duaID)

        except Exception as e:
            MongoDBConn.closeClient(mongoClient)
            return json.dumps({
                "status": 400,
                "error": "Invalid ID"
            }, ensure_ascii=False, default=str, indent=2)

        myquery = {"_id": objectID}
        newvalues = {"$set": {
            "englishText": dua.englishText,
            "arabicText": dua.arabicText,
            "title": dua.title,
            "explanation": dua.explanation,
            "transliteration": dua.transliteration,
            "surah": dua.surah,
            "verses": dua.verses,
            "types": dua.types,
        }}
        cursor = quranicDuaCollection.update_one(myquery, newvalues)

        print(cursor.raw_result)
        print(cursor.acknowledged)
        print(cursor.modified_count)

        MongoDBConn.closeClient(mongoClient)

        return json.dumps({
            "status": 200,
            "message": "Successfully Updated!",
            "count": cursor.modified_count
        }, ensure_ascii=False, default=str, indent=2)


def setMongoDBJson(cursor, selectedFields=None):
    documents = list(cursor)
    if selectedFields is None:
        selectedFields = documents[0].keys() if documents else []

    extractedFieldsData = [
        {field: doc[field] for field in selectedFields}
        for doc in documents
    ]
    jsonData = json.dumps({
        "status": 200,
        "totalResults": len(documents),
        "data": extractedFieldsData
    }, ensure_ascii=False, default=str, indent=2)
    return jsonData
