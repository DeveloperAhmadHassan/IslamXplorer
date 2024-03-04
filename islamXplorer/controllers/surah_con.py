from neo4j import GraphDatabase
import os
import json
from models.surah import Surah
from models.verse import Verse
from conn.neo4j_conn import Neo4jConn


class SurahCon:
    @staticmethod
    def getAllSurahs():
        query = """
                    MATCH (s:Surah)
                    RETURN s.name as SurahName, s.surah_number as SurahNumber
                    ORDER BY s.surah_number
                """
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            database_="neo4j",
        )
        surahs = []
        for record in records:
            surah = Surah(
                record['SurahName'],
                record['SurahNumber'],
            )
            surahs.append(surah)
        return createDataJSON(summary.query, summary.result_available_after, surahs)

    @staticmethod
    def getSurahByID(id: str):
        query = """
            MATCH (v:Verse)-[:VERSE_OF]->(s:Surah)
            WHERE s.surah_number = $verseID
            RETURN v.verseID as ID, v.arabicText as ArabicText, v.englishText as EnglishText, s.name as SurahName,
                    s.surah_number as SurahNumber, s.revelation_place as RevelationPlace
            ORDER BY v.verseID
        """
        parameters = {"verseID": int(id)}

        try:
            driver = Neo4jConn.createNeo4jConnection()
            records, summary, keys = driver.execute_query(
                query,
                parameters,
                database_="neo4j",
            )

            verses = []

            dummy_record = records[0]
            surah = Surah(dummy_record['SurahName'], dummy_record['SurahNumber'], dummy_record['RevelationPlace'])

            for record in records:
                verse = Verse(
                    record['ID'],
                    record['EnglishText'],
                    record['ArabicText'],
                )
                verses.append(verse)

            surah.setVerses(verses)
            return createDataJSON(summary.query, summary.result_available_after, [surah])
            # else:
            #     return createDataJSON(summary.query, summary.result_available_after, [])

        except Exception as e:
            # Handle exceptions (e.g., log the error)
            print(f"Error fetching Verse by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    # @staticmethod
    # def addVerse(verse: Verse):
    #     query = """
    #         CREATE (:Verse:EXTERNAL {
    #             verseID: $verseID,
    #             arabicText: $arabicText,
    #             englishText: $englishText
    #         })
    #     """
    #
    #     parameters = {
    #         "verseID": verse.verseID,
    #         "arabicText": verse.arabicText,
    #         "englishText": verse.englishText,
    #     }
    #
    #     driver = Neo4jConn.createNeo4jConnection()
    #     session = driver.session(database="neo4j")
    #
    #     try:
    #         result: Transaction = session.run(query, parameters)
    #         # records = result.records()
    #         summary = result.consume()
    #         keys = result.keys()
    #         return summary, keys
    #     finally:
    #         session.close()
    #         Neo4jConn.closeConnection(driver)
    #
    # @staticmethod
    # def updateVerseByID(verse: Verse, verseID:str):
    #     query = """
    #                 MATCH (v:Verse {verseID: $verseID})
    #                 SET v.verseID = $newVerseID,
    #                     v.arabicText = $newArabicText,
    #                     v.englishText = $newEnglishText
    #                 RETURN v.verseID as ID, v.arabicText as ArabicText,
    #                 v.englishText as EnglishText
    #             """
    #
    #     parameters = {
    #         "verseID": verseID,
    #         "newVerseID": verse.verseID,
    #         "newArabicText": verse.arabicText,
    #         "newEnglishText": verse.englishText,
    #     }
    #
    #     try:
    #         driver = Neo4jConn.createNeo4jConnection()
    #         records, summary, keys = driver.execute_query(
    #             query,
    #             parameters,
    #             database_="neo4j",
    #         )
    #
    #         if records:
    #             record = records[0]
    #             verse = Verse(
    #                 record['ID'],
    #                 record['EnglishText'],
    #                 record['ArabicText'],
    #                 "",
    #                 0
    #             )
    #             return createDataJSON(summary.query, summary.result_available_after, [verse])
    #         else:
    #             return createDataJSON(summary.query, summary.result_available_after, [])
    #
    #     except Exception as e:
    #         print(f"Error updating Verse by ID: {e}")
    #         return createDataJSON("Error", 0, [])
    #
    #     finally:
    #         Neo4jConn.closeConnection(driver)
    #
    # @staticmethod
    # def deleteVerseByID(verseID: str):
    #     query = """
    #         MATCH (v:Verse {verseID: $verseID})
    #         DELETE v;
    #     """
    #
    #     parameters = {
    #         "verseID": verseID,
    #     }
    #
    #     try:
    #         driver = Neo4jConn.createNeo4jConnection()
    #         records, summary, keys = driver.execute_query(
    #             query,
    #             parameters,
    #             database_="neo4j",
    #         )
    #
    #         # Handle the result or return it if needed
    #         return json.dumps(summary)
    #
    #     except Exception as e:
    #         # Handle exceptions (e.g., log the error)
    #         print(f"Error deleting Hadith by ID: {e}")
    #
    #     finally:
    #         Neo4jConn.closeConnection(driver)
    @staticmethod
    def addSurah(surah: Surah):
        query = """
                CREATE (:Surah:EXTERNAL {
                    surah_number: $surah_number,
                    revelation_place: $revealedIn,
                    name: $name,
                    totalAyahs: $totalVerses,
                    euid: $euid
                })
            """

        parameters = {
            "surah_number": surah.number,
            "revealedIn": surah.revealedIn,
            "totalVerses": surah.totalVerses,
            "name": surah.name,
            "euid": surah.euid
        }

        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        try:
            result = session.run(query, parameters)
            # records = result.records()
            summary = result.consume()
            keys = result.keys()
            return {
                "status": 201,
                "message": "Surah created Successfully"
            }
        finally:
            session.close()
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
