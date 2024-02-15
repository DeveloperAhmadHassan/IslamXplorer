from neo4j import GraphDatabase
import os
import json
from models.topic import Topic
from models.verse import Verse
from conn.neo4j_conn import Neo4jConn


class TopicCon:
    @staticmethod
    def getAllTypes():
        query = """
                    MATCH (t:Type)
                    RETURN t.name as TypeName, t.identifier as TypeIdentifier
                    ORDER BY t.name
                """
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            database_="neo4j",
        )
        types = []
        for record in records:
            typeItem = Topic(
                record['TypeName'],
                record['TypeIdentifier'],
            )
            types.append(typeItem)
        return createDataJSON(summary.query, summary.result_available_after, types)

    @staticmethod
    def getAllConceptsByType(id: str):
        query = """
                    MATCH (t:Type)-[:OF]-(c:Concept)
                    WHERE t.identifier = $id 
                    RETURN t.name as TypeName, t.identifier as TypeIdentifier, c.name as ConceptName, c.identifier as ConceptIdentifier
                    ORDER BY c.name
                """
        parameters = {"id": str(id)}
        driver = Neo4jConn.createNeo4jConnection()
        records, summary, keys = driver.execute_query(
            query,
            parameters,
            database_="neo4j",
        )

        mainTypeItem = Topic(records[0]['TypeName'], records[0]['TypeIdentifier'])

        concepts = []
        for record in records:
            conceptItem = Topic(
                record['ConceptName'],
                record['ConceptIdentifier'],
            )
            concepts.append(conceptItem)

        mainTypeItem.setConcepts(concepts)
        return createDataJSON(summary.query, summary.result_available_after, [mainTypeItem])


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
