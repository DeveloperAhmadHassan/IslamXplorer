from neo4j import GraphDatabase
import os
import json
from models.verse import Verse
from models.hadith import Hadith
from conn.neo4j_conn import Neo4jConn


class VerseCon:
    @staticmethod
    def getAllVerses():
        query = """
                    MATCH (v:Verse)-[:VERSE_OF]->(s:Surah)
                    RETURN v.verseID as ID, v.arabicText as ArabicText, v.englishText as EnglishText, s.name as SurahName,
                    s.surah_number as SurahNumber
                    ORDER BY s.surah_number, v.verseID
                """
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            database_="neo4j",
        )
        verses = []
        for record in records:
            verse = Verse(
                record['ID'],
                record['EnglishText'],
                record['ArabicText'],
                record['SurahName'],
                record['SurahNumber']
            )
            verses.append(verse)
        return createDataJSON(summary.query, summary.result_available_after, verses)

    @staticmethod
    def getVerseByID(id: str):
        query = """
            MATCH (v:Verse)-[:VERSE_OF]->(s:Surah)
            WHERE v.verseID = $id  
            RETURN v.verseID as ID, v.arabicText as ArabicText, v.englishText as EnglishText, s.name as SurahName,
                    s.surah_number as SurahNumber
            LIMIT 1
        """
        parameters = {"id": id}

        try:
            driver = Neo4jConn.createNeo4jConnection()
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            if records:
                record = records[0]
                verse = Verse(
                    record['ID'],
                    record['EnglishText'],
                    record['ArabicText'],
                    record['SurahName'],
                    record['SurahNumber']
                )
                return createDataJSON(summary.query, summary.result_available_after, [verse])
            else:
                return createDataJSON(summary.query, summary.result_available_after, [])

        except Exception as e:
            # Handle exceptions (e.g., log the error)
            print(f"Error fetching Verse by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def addVerse(verse: Verse):
        query = """
            CREATE (:Verse:EXTERNAL {
                verseID: $id,
                arabicText: $arabicText,
                englishText: $englishText
            })
        """

        parameters = {
            "id": verse.id,
            "arabicText": verse.arabicText,
            "englishText": verse.englishText,
        }

        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        try:
            result: Transaction = session.run(query, parameters)
            # records = result.records()
            summary = result.consume()
            keys = result.keys()
            return summary, keys
        finally:
            session.close()
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def updateVerseByID(verse: Verse, id:str):
        query = """
                    MATCH (v:Verse {verseID: $id})
                    SET v.verseID = $newVerseID,
                        v.arabicText = $newArabicText,
                        v.englishText = $newEnglishText
                    RETURN v.verseID as ID, v.arabicText as ArabicText, 
                    v.englishText as EnglishText
                """

        parameters = {
            "id": id,
            "newVerseID": verse.id,
            "newArabicText": verse.arabicText,
            "newEnglishText": verse.englishText,
        }

        try:
            driver = Neo4jConn.createNeo4jConnection()
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            if records:
                record = records[0]
                verse = Verse(
                    record['ID'],
                    record['EnglishText'],
                    record['ArabicText'],
                    "",
                    0
                )
                return createDataJSON(summary.query, summary.result_available_after, [verse])
            else:
                return createDataJSON(summary.query, summary.result_available_after, [])

        except Exception as e:
            print(f"Error updating Verse by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def deleteVerseByID(id: str):
        query = """
            MATCH (v:Verse {verseID: $id})
            DELETE v;
        """

        parameters = {
            "id": id,
        }

        try:
            driver = Neo4jConn.createNeo4jConnection()
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            # Handle the result or return it if needed
            return json.dumps(summary)

        except Exception as e:
            # Handle exceptions (e.g., log the error)
            print(f"Error deleting Hadith by ID: {e}")

        finally:
            Neo4jConn.closeConnection(driver)


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
