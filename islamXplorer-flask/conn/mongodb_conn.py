import pymongo
import json
import os

from bson import ObjectId
from models.dua import Dua


class MongoDBConn:
    @staticmethod
    def createMongoDBConnection():
        myclient = pymongo.MongoClient(os.getenv("MONGODB_URI"))
        return myclient

    @staticmethod
    def getDuaMongoDB(myclient):
        return myclient["IslamXplorer"]

    @staticmethod
    def getQuranicDuaCollection(mydb):
        return mydb["quranic_duas"]

    @staticmethod
    def getTypesCollection(mydb):
        return mydb["dua_types"]

    @staticmethod
    def closeClient(myclient):
        myclient.close()

