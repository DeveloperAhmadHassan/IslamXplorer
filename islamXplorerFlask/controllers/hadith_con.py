from neo4j import GraphDatabase
import os
import json

from extensions.int_extensions import IntExtensions
from extensions.string_extensions import StringExtensions
from models.hadith import Hadith
from conn.neo4j_conn import Neo4jConn
from models.verse import Verse
from utils.utils import createDataJSON as dataJSON


class HadithCon:
    @staticmethod
    def getAllHadiths():
        query = """
                    MATCH (h:Hadith) 
                    RETURN h.hadithID as ID, h.source as Source, h.arabicText as ArabicText, 
                    h.englishText as EnglishText, h.hadithNo as HadithNo, h.narratedBy as NarratedBy
                    LIMIT 100
                """
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            database_="neo4j",
        )
        hadiths = []
        for record in records:
            hadith = Hadith(
                record['ID'],
                record['HadithNo'],
                record['EnglishText'],
                record['ArabicText'],
                record['Source'],
                record['NarratedBy']
            )
            hadiths.append(hadith)
        return createDataJSON(summary.query, summary.result_available_after, hadiths)

    @staticmethod
    def getAllHadithsByChapter(chapter: int):
        query = """
                    MATCH (h:Hadith)
                    WITH h, split(h.hadithID, ' ')[1] AS d1
                    WITH h, split(d1, ':')[0] AS d2
                    WHERE toInteger(d2) = $chapter
                    RETURN h.hadithID AS ID, h.arabicText AS ArabicText, h.englishText AS EnglishText
                """
        parameters = {
            "chapter": chapter
        }
        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        records = session.run(query, parameters)

        hadiths = []
        for record in records:
            hadith = Hadith(
                hadithID=record['ID'],
                englishText=record['EnglishText'],
                arabicText=record['ArabicText'],
            )
            hadiths.append(hadith)
        summary = records.consume()

        return createDataJSON(summary.query, summary.result_available_after, hadiths)

    @staticmethod
    def getHadithByID(hadithID: str):
        query = """
            MATCH (h:Hadith)
            WHERE h.hadithID = $hadithID  
            RETURN h.hadithID as ID, h.source as Source, h.arabicText as ArabicText, 
            h.englishText as EnglishText, h.hadithNo as HadithNo, h.narratedBy as NarratedBy
            LIMIT 1
        """
        parameters = {"hadithID": hadithID}
        driver = Neo4jConn.createNeo4jConnection()
        try:
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            if records:
                record = records[0]
                hadith = Hadith(
                    hadithID=record['ID'],
                    hadithNo=record['HadithNo'],
                    englishText=record['EnglishText'],
                    arabicText=record['ArabicText'],
                    source=record['Source'],
                    narratedBy=record['NarratedBy']
                )
                return createDataJSON(summary.query, summary.result_available_after, [hadith])
            else:
                return createDataJSON(summary.query, summary.result_available_after, [])

        except Exception as e:
            # Handle exceptions (e.g., log the error)
            print(f"Error fetching Hadith by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def getHadithSources():
        query = """
                    MATCH (h:Hadith)
                    WHERE h.source IS NOT NULL AND h.source <> ""
                    RETURN DISTINCT h.source AS Source
                """
        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        records = session.run(query)

        sourceChapters = []
        for record in records:
            sourceChapters.append(record['Source'])

        summary = records.consume()
        return createDataJSON(summary.query, summary.result_available_after, sourceChapters, key="sourceName")

    @staticmethod
    def getHadithSourceChapters(source: str):
        query = """
                        MATCH (h:Hadith {source: $source})
                        WITH DISTINCT split(h.hadithID, ':')[0] AS uniqueValueBeforeColon
                        WITH DISTINCT split(uniqueValueBeforeColon, ' ')[1] AS uniqueValueBeforeColonNew
                        WHERE uniqueValueBeforeColonNew <> '' 
                        WITH toInteger(uniqueValueBeforeColonNew) AS uniqueValueAsInteger
                        RETURN uniqueValueAsInteger
                        ORDER BY uniqueValueAsInteger ASC
                    """
        parameters = {
            "source": source
        }
        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        records = session.run(query, parameters)

        sourceChapters = []
        for record in records:
            sourceChapters.append(record['uniqueValueAsInteger'])

        summary = records.consume()
        return createDataJSON(summary.query, summary.result_available_after, sourceChapters, key="chapterID")

    @staticmethod
    def addHadith(hadith: Hadith):
        query = """
            CREATE (:Hadith:EXTERNAL {
                hadithID: $verseID,
                hadithNo: $hadithNo,
                arabicText: $arabicText,
                englishText: $englishText,
                narratedBy: $narratedBy,
                source: $source
            })
        """

        parameters = {
            "verseID": hadith.id,
            "hadithNo": hadith.hadithNo,
            "arabicText": hadith.arabicText,
            "englishText": hadith.englishText,
            "narratedBy": hadith.narratedBy,
            "source": hadith.source
        }

        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        try:
            result = session.run(query, parameters)
            summary = result.consume()
            keys = result.keys()
            return summary, keys
        finally:
            session.close()
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def updateHadithByID(hadith: Hadith, hadithID: str):
        query = """
                    MATCH (h:Hadith {hadithID: $hadithID})
                    SET h.hadithID = $newHadithID,
                        h.hadithNo = $newHadithNo,
                        h.arabicText = $newArabicText,
                        h.englishText = $newEnglishText,
                        h.narratedBy = $newNarratedBy,
                        h.source = $newSource
                    RETURN h.hadithID as ID, h.source as Source, h.arabicText as ArabicText, 
                    h.englishText as EnglishText, h.hadithNo as HadithNo, h.narratedBy as NarratedBy
                """

        parameters = {
            "hadithID": hadithID,
            "newHadithID": hadith.id,
            "newHadithNo": hadith.hadithNo,
            "newArabicText": hadith.arabicText,
            "newEnglishText": hadith.englishText,
            "newNarratedBy": hadith.narratedBy,
            "newSource": hadith.source
        }

        driver = Neo4jConn.createNeo4jConnection()

        try:
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            if records:
                record = records[0]
                hadith = Hadith(
                    record['ID'],
                    record['HadithNo'],
                    record['EnglishText'],
                    record['ArabicText'],
                    record['Source'],
                    record['NarratedBy']
                )
                return createDataJSON(summary.query, summary.result_available_after, [hadith])
            else:
                return createDataJSON(summary.query, summary.result_available_after, [])

        except Exception as e:
            print(f"Error updating Hadith by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def deleteHadithByID(hadithID: str):
        query = """
            MATCH (h:Hadith {hadithID: $hadithID})
            DELETE h;
        """

        parameters = {
            "hadithID": hadithID,
        }

        driver = Neo4jConn.createNeo4jConnection()
        try:
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            return json.dumps(summary)

        except Exception as e:
            print(f"Error deleting Hadith by ID: {e}")

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def getHadithRelatedContent(hadithID: str):
        query = """
                    MATCH (h1:Hadith)-[:REFERS]->(n)
                    WHERE h1.hadithID = $hadithID
                    RETURN 
                      CASE 
                        WHEN labels(n) = ["Verse"] THEN "Verse" 
                        ELSE "Hadith"
                      END AS Label,
                      CASE 
                        WHEN labels(n) = ["Verse"] THEN n.verseID 
                        ELSE n.hadithID 
                      END AS ID,
                      n.arabicText AS ArabicText,
                      n.englishText AS EnglishText,
                      'referred' AS Type
                    
                    UNION
                    
                    MATCH (n)-[:REFERS]->(h2:Hadith)
                    WHERE h2.hadithID = $hadithID
                    RETURN 
                        "Hadith" AS Label,
                        n.hadithID AS ID,
                        n.arabicText AS ArabicText,
                        n.englishText AS EnglishText,
                        'referring' AS Type


        """
        parameters = {
            "hadithID": hadithID,
        }

        records, summary, keys = Neo4jConn.executeNeo4jQuery(query=query, parameters=parameters)
        hadiths = []
        verses = []

        for record in records:
            if record["Label"] == "Hadith":
                hadiths.append(
                    Hadith(hadithID=record["ID"], englishText=record["EnglishText"], arabicText=record["ArabicText"])
                )
            elif record["Label"] == "Verse":
                verses.append(
                    Verse(verseID=record["ID"], englishText=record["EnglishText"], arabicText=record["ArabicText"])
                )

        return dataJSON(summary.query, summary.result_available_after, verses, hadiths)


def createDataJSON(query, time, records, key=None):
    totalResults = len(records)
    data = []

    for record in records:
        if isinstance(record, int):
            data.append(IntExtensions.to_dict(key, record))
        elif isinstance(record, str):
            data.append(StringExtensions.to_dict(key, record))
        else:
            data.append(record.to_dict())

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
