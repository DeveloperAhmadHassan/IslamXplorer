from neo4j import GraphDatabase
import os
import json

from models.ontology import Ontology, DataType
from models.topic import Topic
from models.verse import Verse
from conn.neo4j_conn import Neo4jConn


class OntologyCon:
    @staticmethod
    def addOntology(ont: Ontology):
        base_query = """
            MATCH (c:Concept {identifier: $conceptID})
            """

        patterns_relationships = {
            DataType.Verse: (lambda data_id: (f"(t:Verse {{verseID: \"{data_id}\"}})", "MENTIONED_IN", "<")),
            DataType.Hadith: (lambda data_id: (f"(t:Hadith {{hadithID: \"{data_id}\"}})", "DESCRIBES", "->")),
            DataType.Surah: (lambda data_id: (f"(t:Surah {{surahID: \"{data_id}\"}})", "MENTIONED_IN", "<"))
        }

        pattern_relationship_lambda = patterns_relationships.get(ont.dataType)
        if not pattern_relationship_lambda:
            raise ValueError("Unsupported dataType")

        pattern, relationship_type, direction = pattern_relationship_lambda(ont.dataID)

        query = base_query + f"""
            MATCH {pattern}
            CREATE {''.join(("(t)", direction, '-'))}[r:{relationship_type} {{externalUserID: $userID}}]-(c)
            RETURN t,c,r
            """

        print(query)

        parameters = {
            "dataID": ont.dataID,
            "conceptID": ont.concept,
            "userID": ont.uid
        }

        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        try:
            result = session.run(query, parameters)
            # records = result.records()
            summary = result.consume()
            keys = result.keys()
            return summary, keys
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
