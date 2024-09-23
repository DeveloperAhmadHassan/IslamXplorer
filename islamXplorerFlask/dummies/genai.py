# # import google.generativeai as genai
# # import base64
# # import json
# #
# # from dotenv import load_dotenv
# # from neo4j import GraphDatabase
# # import re
# #
# # from conn.neo4j_conn import Neo4jConn
# # from models.hadith import Hadith
# # from models.surah import Surah
# # from models.verse import Verse
# # from utils.utils import createDataJSON
# #
# # load_dotenv()
# #
# # # genai.configure(api_key = "AIzaSyA9uVf7X2FNRPh8Z3MQrSNaK7P-vwYD6mM")
# #
# # # model = genai.GenerativeModel('gemini-pro')
# #
# # # result = genai.embed_content(
# # #     model="models/embedding-001",
# # #     content="O believers! Do not waste your charity with reminders ˹of your generosity˺ or hurtful words, like those who donate their wealth just to show off and do not believe in Allah or the Last Day. Their example is that of a hard barren rock covered with a thin layer of soil hit by a strong rain—leaving it just a bare stone. Such people are unable to preserve the reward of their charity. Allah does not guide ˹such˺ disbelieving people",
# # #     task_type="retrieval_document",
# # #     title="Embedding of single string")
# # #
# # # print(result['embedding'])
# # #
# # # records, summary, keys = Neo4jConn.executeNeo4jQuery(
# # #     query=
# # #     """
# # #         MATCH(h:Hadith)
# # #         RETURN h.hadithID as ID, h.englishText AS EnglishText
# # #     """
# # # )
# # #
# # # ids = []
# # # i = 1
# # #
# # # for record in records:
# # #     print(i)
# # #     i += 1
# # #
# # #     if record["EnglishText"] != "":
# # #         result = genai.embed_content(
# # #             model="models/embedding-001",
# # #             content=record["EnglishText"],
# # #             task_type="retrieval_document",
# # #             title="Embedding of single string")
# # #
# # #         parameters = {"hadithID": str(record["ID"]), "embeddingsFlag": result['embedding']}
# # #
# # #         records, summary, keys = Neo4jConn.executeNeo4jQuery(
# # #             query=
# # #             """
# # #                 MATCH(h:Hadith)
# # #                 WHERE h.hadithID = $hadithID
# # #                 SET h.embeddingsFlag = $embeddingsFlag
# # #             """,
# # #             parameters=parameters
# # #         )
# # #         ids.append(record["ID"])
# # #
# # # print(ids)
# # # print(ids.__len__())
# #
# # # result = genai.embed_content(
# # #     model="models/embedding-001",
# # #     content=record["EnglishText"],
# # #     task_type="retrieval_document",
# # #     title="Embedding of single string")
# # #
# # # parameters = {"verseID": str(record["ID"]), "embeddingsFlag": result['embedding']}
# # #
# # # records, summary, keys = Neo4jConn.executeNeo4jQuery(
# # #     query=
# # #     """
# # #         MATCH(v:Verse)
# # #         WHERE v.verseID = $verseID
# # #         SET v.embeddingsFlag = $embeddingsFlag
# # #     """,
# # #     parameters=parameters
# # # )
# # def extractNeo4jResults(records, summary):
# #     verses = []
# #     surahs = []
# #     hadiths = []
# #
# #     dummy_verses = []
# #     dummy_hadiths = []
# #
# #     for record in records:
# #         if 'surahNumber' in record.keys():
# #             surah = Surah(record['surahName'], record['surahNumber'], record['revealedIn'])
# #             surahs.append(surah)
# #
# #         if 'VerseID' in record.keys():
# #             print('here')
# #             verses.append(Verse(record['VerseID'], record['VerseEnglishText'], record['VerseArabicText'], "surah name", 0))
# #             dummy_verses.append(record['VerseID'])
# #
# #         if 'HadithID' in record.keys():
# #             dummy_hadiths.append(record['HadithID'])
# #             hadiths.append(
# #                 Hadith(record['HadithID'], record['HadithNo'], record['HadithEnglishText'], record['HadithArabicText'],
# #                        record['HadithSource'],
# #                        record['HadithNarratedBy']))
# #
# #
# #     return createDataJSON(summary.query, summary.result_available_after, verses, hadiths)
# #
# # parameters = {"verseID": "2:158"}
# #
# # records, summary, keys = Neo4jConn.executeNeo4jQuery(query="""
# #             MATCH (v:Verse)<-[:REFERS]-(hadith:Hadith)
# #             WHERE v.verseID = $verseID
# #             RETURN hadith.hadithID as HadithID, hadith.arabicText as HadithArabicText,hadith.englishText as HadithEnglishText, hadith.source as HadithSource,hadith.narratedBy as HadithNarratedBy, hadith.hadithNo as HadithNo
# #             """, parameters=parameters)
# #
# # queryResults = extractNeo4jResults(records, summary)
# #
# # print(queryResults)
#
#
# # from googleapiclient.discovery import build
# #
# # my_api_key = "AIzaSyBYysZJWoaIOUKHUMKyES6HUbtkV0WDCk0"
# # my_cse_id = "16f7e740ea834427a"
# #
# #
# # def google_search(search_term, api_key, cse_id, **kwargs):
# #     service = build("customsearch", "v1", developerKey=api_key)
# #     res = service.cse().list(q=search_term, cx=cse_id, **kwargs).execute()
# #     return res['items']
# #
# #
# # results = google_search('what are the punishments for interest in Islam', my_api_key, my_cse_id, num=10)
# # for result in results:
# #     print(result)
#
# from pymongo import MongoClient
# #
# # # Connect to MongoDB
# client = MongoClient('mongodb+srv://ahmad921:00123123@cluster0.m1t5eco.mongodb.net/')  # Assuming MongoDB is running locally on default port
# #
# # # Access the database
# db = client.IslamXplorer
# #
# # # Access the collection
# collection = db.quran
# #
# # # Define the new record
# # new_record = {
# #     "verse": "This is a new verse from the Quran.",
# #     "chapter": 1,
# #     "verse_number": 1,
# #     "translation": "This is the translation of the new verse."
# # }
# #
# # # Insert the new record into the collection
# # insert_result = collection.insert_one(new_record)
# # #
# # # # Check if the insertion was successful
# # if insert_result.acknowledged:
# #     print("New record inserted successfully.")
# # else:
# #     print("Failed to insert new record.")
#
# import requests
#
# url = "https://quran.com/1?startingVerse=5"
# response = requests.get(url)
# # Check if the request was successful (status code 200)
# if response.status_code == 200:
#     # Print the JSON data
#     print(response.json())
#     # numberOfVerses = int(response.json()["data"]['numberOfVerses'])
#     # surahNumber = response.json()["data"]['number']
# else:
#     print("Failed to retrieve data from the API.")
# # URL of the API endpoint
#

# # for surahNumber in range(1, 115):
# #     surahUrl = f"""https://api.quran.gading.dev/surah/{surahNumber}"""
# #     response = requests.get(surahUrl)
# #

# #     if response.status_code == 200:
# #         numberOfVerses = int(response.json()["data"]['numberOfVerses'])
# #         surahNumber = response.json()["data"]['number']
# #
# #         for verseNumber in range(1, numberOfVerses + 1):
# #             verseUrl = f"""https://api.quran.gading.dev/surah/{surahNumber}/{verseNumber}"""
# #             response = requests.get(verseUrl)
# #             print(response.json()["data"]['text']["arab"])
# #
# #             new_record = {
# #                 "verseId": f"""{surahNumber}:{verseNumber}""",
# #                 "arabicText": response.json()["data"]['text']["arab"],
# #                 "englishTText": response.json()["data"]['translation']["en"],
# #                 "transliteration": response.json()["data"]['text']["transliteration"]["en"],
# #                 "verseNumber": f"""{verseNumber}""",
# #                 "audioLink": response.json()["data"]['audio']["primary"],
# #                 "juz": response.json()["data"]['meta']["juz"],
# #                 "page": response.json()["data"]['meta']["page"],
# #                 "manzil": response.json()["data"]['meta']["manzil"],
# #                 "ruku": response.json()["data"]['meta']["ruku"],
# #                 "hizbQuarter": response.json()["data"]['meta']["hizbQuarter"],
# #                 "sajda": {
# #                     "recommended": response.json()["data"]['meta']["sajda"]["recommended"],
# #                     "obligatory": response.json()["data"]['meta']["sajda"]["obligatory"]
# #                 }
# #             }
# #
# #             insert_result = collection.insert_one(new_record)
# #             #
# #             if insert_result.acknowledged:
# #                 print(f"""New record inserted successfully. {surahNumber}:{verseNumber}""")
# #             else:
# #                 print("Failed to insert new record.")
# #     else:
# #         print("Failed to retrieve data from the API.")
import requests
from bs4 import BeautifulSoup
import json
from pymongo import MongoClient

# url = "https://sunnah.com/bukhari:8"
# response = requests.get(url)
# if response.status_code == 200:
#     soup = BeautifulSoup(response.content, 'html.parser')
#     print(soup)
#     data_element = soup.find('dic', id="h100080")
#     if data_element:
#         json_data = data_element.string.strip()
#         parsed_data = json.loads(json_data)
#         # totalVerses = parsed_data['props']['pageProps']['chaptersData'][f"""{str(surahNumber)}"""]['versesCount']
#         print(json.dumps(parsed_data, indent=4))

client = MongoClient('mongodb+srv://ahmad921:00123123@cluster0.m1t5eco.mongodb.net/')
db = client.IslamXplorer
collection = db.quran

audioNum = 1

for surahNumber in range(1, 115):
    url = f"""https://quran.com/{surahNumber}/1-1"""
    response = requests.get(url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        data_element = soup.find('script', id="__NEXT_DATA__")
        audioNum += 1

        if data_element:
            json_data = data_element.string.strip()
            parsed_data = json.loads(json_data)
            totalVerses = parsed_data['props']['pageProps']['chaptersData'][f"""{str(surahNumber)}"""]['versesCount']
            print(json.dumps(totalVerses, indent=4))

            for verseNumber in range(1, int(totalVerses)+1):
                url = f"""https://quran.com/{surahNumber}/{verseNumber}-{verseNumber}"""
                response = requests.get(url)

                if response.status_code == 200:
                    ssoup = BeautifulSoup(response.content, 'html.parser')
                    ddata_element = ssoup.find('script', id="__NEXT_DATA__")

                    if data_element:
                        jjson_data = ddata_element.string.strip()
                        pparsed_data = json.loads(jjson_data)
                        print(pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['textUthmani'])

                        new_record = {
                            "verseId": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['verseKey'],
                            "verseNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['verseNumber'],
                            "hizbNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['hizbNumber'],
                            "rubElHizbNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0][
                                'rubElHizbNumber'],
                            "rukuNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['rukuNumber'],
                            "manzilNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['manzilNumber'],
                            "sajdahNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['sajdahNumber'],
                            "arabicTextUthmani": pparsed_data['props']['pageProps']['versesResponse']['verses'][0][
                                'textUthmani'],
                            "arabicTextSimple": pparsed_data['props']['pageProps']['versesResponse']['verses'][0][
                                'textImlaeiSimple'],
                            "surahNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['chapterId'],
                            "pageNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['pageNumber'],
                            "juzNumber": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['juzNumber'],
                            "englishText": pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['translations'][0][
                                'text'],
                            "resourceNumber":
                                pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['translations'][0][
                                    'resourceName'],
                            "audioLink": f"""https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/{pparsed_data['props']['pageProps']['versesResponse']['verses'][0]['id']}""",
                        }
                        insert_result = collection.insert_one(new_record)
                        if insert_result.acknowledged:
                            print(f"""New record inserted successfully. {surahNumber}:{verseNumber}""")
                        else:
                            print("Failed to insert new record.")
        else:
            print("Data element not found.")
    else:
        print("Failed to retrieve data from the website.")
