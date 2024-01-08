import pymongo
from mongodb_conn import MongoDBConn

MongoDBConn.getAllDuaTypes()

myclient = pymongo.MongoClient(os.getenv("MONGODB_URI"))
mycol = myclient["IslamXplorer"]
mydoc = mycol["quranic_duas"]

x = mydoc.delete_one()

print(x.)

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
