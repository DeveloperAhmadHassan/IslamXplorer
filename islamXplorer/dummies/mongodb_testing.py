import pymongo
import os

print("Hello")
client = pymongo.MongoClient('mongodb+srv://ahmad921:00123123@cluster0.m1t5eco.mongodb.net/')
print("Hello1")
db = client["IslamXplorer"]
print("Hello2")

quranic_duas_collection = db["quranic_duas"]
print("Hello3")
dua_types_collection = db["dua_types"]
print("Hello4")

# Retrieve all documents from quranic_duas collection
quranic_duas = quranic_duas_collection.find()

print(quranic_duas_collection.count_documents({}))

# Iterate through each document
for dua in quranic_duas:
    # Extract the types from the current document
    print('hello')
    types = dua.get("types", [])
    print(types)

    # Replace each type with its corresponding _id from dua_types collection
    updated_types = []
    for t in types:
        # Find the _id from dua_types collection
        type_document = dua_types_collection.find_one({"name": t})
        if type_document:
            updated_types.append(type_document["_id"])

    # Update the types field in the current document
    quranic_duas_collection.update_one({"_id": dua["_id"]}, {"$set": {"types": updated_types}})

# Close the MongoDB connection
client.close()


# for x in quarnicDuaCollection.find({"types": "repentance"}):
#     print(x['title'])

# documents_to_update = mycol.find({"type": {"$exists": True}})
# for doc in documents_to_update:
#     mycol.update_one(
#         {"_id": doc["_id"]},
#         {"$rename": {"type": "types"}}
#     )

# documents_to_update = quranicDuaCollection.find({"verse": {"$exists": True}})
#
# for doc in documents_to_update:
#
#     updated_value = str(doc["verses"])
#     quranicDuaCollection.update_one(
#         {"_id": doc["_id"]},
#         {
#             "$rename": {"verse": "verses"},
#             "$set": {"verses": updated_value}
#         }
#     )

# mongoClient.close()

# import pymongo
# import json
# from pymongo import MongoClient, InsertOne
#
# client = pymongo.MongoClient('mongodb+srv://ahmad921:00123123@cluster0.m1t5eco.mongodb.net/')
# db = client["IslamXplorer"]
# collection = db["new_quranic_duas"]
# requesting = []
#
# with open(r"<FILENAME>") as f:
#     for jsonObj in f:
#         myDict = json.loads(jsonObj)
#         requesting.append(InsertOne(myDict))

# client = pymongo.MongoClient('mongodb+srv://ahmad921:00123123@cluster0.m1t5eco.mongodb.net/')
# db = client['IslamXplorer']
#
# # Access dua_types collection
# dua_types_collection = db.dua_types
# quranic_dua_collection = db.quranic_duas
#
# dua_type = "mercy"
#
# # Calculate the total duas for a specific type
# total_duas = quranic_dua_collection.count_documents({"types": dua_type})
#
# print(f"Total Duas for {dua_type}: {total_duas}")
#
# # Update the total attribute
# result = dua_types_collection.update_one(
#     {"name": dua_type},
#     {"$set": {"total": total_duas}},
#     upsert=True  # Create a new document if the type doesn't exist
# )
#
# print(f"Modified {result.modified_count} document")
#
# # Close the MongoDB connection
# client.close()