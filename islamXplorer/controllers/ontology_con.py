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
        # Define the base Cypher query
        base_query = """
            MATCH (c:Concept {verseID: $conceptIdentifier})
            """

        # Define a function to construct Cypher pattern and relationship type
        patterns_relationships = {
            DataType.Verse: (lambda data_id: (f"(t:Verse {{verseID: \"{data_id}\"}})", "MENTIONED_IN", "<")),
            DataType.Hadith: (lambda data_id: (f"(t:Hadith {{hadithID: \"{data_id}\"}})", "DESCRIBES", "->")),
            DataType.Surah: (lambda data_id: (f"(t:Surah {{surahID: \"{data_id}\"}})", "MENTIONED_IN", "<"))
        }

        # Get the lambda function based on dataType
        pattern_relationship_lambda = patterns_relationships.get(ont.dataType)
        if not pattern_relationship_lambda:
            raise ValueError("Unsupported dataType")

        # Construct the Cypher pattern, relationship type, and direction using the lambda function
        pattern, relationship_type, direction = pattern_relationship_lambda(ont.dataID)

        # Construct the complete Cypher query
        query = base_query + f"""
            MATCH {pattern}
            CREATE {''.join(("(t)", direction, '-'))}[r:{relationship_type} {{externalUserID: $userID}}]-(c)
            RETURN t,c,r
            """

        print(query)

        parameters = {
            "conceptIdentifier": ont.concept,
            "userID": ont.uid
        }

        driver = Neo4jConn.createNeo4jConnection()
        session = driver.session(database="neo4j")

        try:
            result = session.run(query, parameters)
            # records = result.records()
            summary = result.consume()
            keys = result.keys()
            print(summary.query)
            print(summary.result_available_after)
            print(summary.parameters)
            print(result)
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
