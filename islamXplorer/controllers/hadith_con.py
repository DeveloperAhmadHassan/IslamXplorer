from neo4j import GraphDatabase
import os
import json
from models.hadith import Hadith
from conn.neo4j_conn import Neo4jConn


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
    def getHadithByID(id: str):
        query = """
            MATCH (h:Hadith)
            WHERE h.hadithID = $id  
            RETURN h.hadithID as ID, h.source as Source, h.arabicText as ArabicText, 
            h.englishText as EnglishText, h.hadithNo as HadithNo, h.narratedBy as NarratedBy
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
            # Handle exceptions (e.g., log the error)
            print(f"Error fetching Hadith by ID: {e}")
            return createDataJSON("Error", 0, [])

        finally:
            Neo4jConn.closeConnection(driver)

    @staticmethod
    def addHadith(hadith: Hadith):
        query = """
            CREATE (:Hadith:EXTERNAL {
                hadithID: $id,
                hadithNo: $hadithNo,
                arabicText: $arabicText,
                englishText: $englishText,
                narratedBy: $narratedBy,
                source: $source
            })
        """

        parameters = {
            "id": hadith.id,
            "hadithNo": hadith.hadithNo,
            "arabicText": hadith.arabicText,
            "englishText": hadith.englishText,
            "narratedBy": hadith.narratedBy,
            "source": hadith.source
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
    def updateHadithByID(hadith: Hadith, id: str):
        query = """
                    MATCH (h:Hadith {hadithID: $id})
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
            "id": id,
            "newHadithID": hadith.id,
            "newHadithNo": hadith.hadithNo,
            "newArabicText": hadith.arabicText,
            "newEnglishText": hadith.englishText,
            "newNarratedBy": hadith.narratedBy,
            "newSource": hadith.source
        }

        # driver = Neo4jConn.createNeo4jConnection()
        # session = driver.session(database="neo4j")

        try:
            driver = Neo4jConn.createNeo4jConnection()
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
    def deleteHadithByID(id: str):
        query = """
            MATCH (h:Hadith {hadithID: $id})
            DELETE h;
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
