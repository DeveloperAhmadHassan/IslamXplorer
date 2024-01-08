from neo4j import GraphDatabase
import os
import json
from models.hadith import Hadith


# from utils.utils import createDataJSON


class Neo4jConn:
    @staticmethod
    def createNeo4jConnection():
        with GraphDatabase.driver(os.getenv("NEO4J_URI"),
                                  auth=(os.getenv('NEO4J_USERNAME'), os.getenv("NEO4J_PASSWORD"))) as driver:
            driver.verify_connectivity()
        return driver

    @staticmethod
    def executeNeo4jQuery(query=None):
        if query is None:
            query = """
                MATCH (v:Verse),(s:Surah)
                OPTIONAL MATCH (h:Hadith)
                MATCH (v)-[:VERSE_OF]->(s)
                RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText, 
                  s.name as surahName, s.revelation_place as revealedIn, s.surah_number as surahNumber,
                  h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText,
                  h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
                LIMIT 15
                  """
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            database_="neo4j",
        )
        Neo4jConn.closeConnection(driver)
        return records, summary, keys

    @staticmethod
    def closeConnection(driver):
        driver.close()


def createDataJSON(query, time, records):
    totalResults = len(records)

    data = [record.to_dict() for record in records]

    results = {
        "status": 200,
        "cipher": query,
        "totalResults": {
            "total": totalResults,
        },
        "timeTaken": time,
        "data": data
    }
    return json.dumps(results, ensure_ascii=False, indent=4)
