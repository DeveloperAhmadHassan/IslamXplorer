from neo4j import GraphDatabase
import os
import json

from neo4j._async import driver

from models.ontology import Ontology, DataType
from models.topic import Topic
from models.verse import Verse
from conn.neo4j_conn import Neo4jConn

import google.generativeai as genai
import base64
import json
from neo4j import GraphDatabase
import re

from googleapiclient.discovery import build

genai.configure(api_key="AIzaSyA9uVf7X2FNRPh8Z3MQrSNaK7P-vwYD6mM")
my_api_key = "AIzaSyBYysZJWoaIOUKHUMKyES6HUbtkV0WDCk0"
my_cse_id = "16f7e740ea834427a"


def get_answer(input):
    generation_config = {
        "temperature": 0.9,
        "top_p": 1,
        "top_k": 1,
        "max_output_tokens": 2048,
    }
    safety_settings = [
        {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
    ]
    model = genai.GenerativeModel(model_name="gemini-1.0-pro",
                                  generation_config=generation_config,
                                  safety_settings=safety_settings)

    # defaults = {
    #     'model': 'models/text-bison-001',
    #     'temperature': 0.7,
    #     'candidate_count': 1,
    #     'top_k': 40,
    #     'top_p': 0.95,
    #     'max_output_tokens': 1024,
    #     'stop_sequences': [],
    #     'safety_settings': [{"category": "HARM_CATEGORY_DEROGATORY", "threshold": 1},
    #                         {"category": "HARM_CATEGORY_TOXICITY", "threshold": 1},
    #                         {"category": "HARM_CATEGORY_VIOLENCE", "threshold": 2},
    #                         {"category": "HARM_CATEGORY_SEXUAL", "threshold": 2},
    #                         {"category": "HARM_CATEGORY_MEDICAL", "threshold": 2},
    #                         {"category": "HARM_CATEGORY_DANGEROUS", "threshold": 2}],
    # }

    prompt = f"""You are an expert in converting English questions to Neo4j Cypher Graph code!
    The Graph has following Node Labels - Hadith, Concept, Verse, Surah, Type, Grouped_Verses
    The Hadith Node has the following properties narratedBy, englishText, source, hadithID, arabicText, hadithNo
    The Concept Node has the following properties identifier, name
    The Verse Node has the following properties arabicText, englishText, verseID
    The Type Node has the following properties identifier, name
    The Grouped_Verses Node has the following properties groupID

    The Graph has the following Relationship types DESCRIBES, REFERS, MENTIONED_IN, OF, VERSE_OF, IN!

    The details are following

    The relationship DESCRIBES starts from Hadith to Concept.
    The relationship REFERS starts from Hadith to Verse.
    The relationship REFERS starts from Hadith to Surah.
    The relationship DESCRIBES starts from Hadith to Type.
    The relationship REFERS starts from Hadith to Hadith.

    The relationship MENTIONED_IN starts from Concept to Verse.
    The relationship OF starts from Concept to Type.
    The relationship MENTIONED_IN starts from Concept to Grouped_Verses.
    The relationship OF starts from Concept to Concept.

    The relationship VERSE_OF starts from Verse to Surah.

    The relationship MENTIONED_IN starts from Type to Verse.
    The relationship IN starts from Type to Concept.
    The relationship OF starts from Type to Concept.


    For example,
    Example 1 - What are the punishments for not paying Zakat, the Cypher command will be something like this
    ```
    MATCH (t:Type)-[:OF]-(c:Concept)-[:MENTIONED_IN]-(v:Verse)
    WHERE t.name = 'Zakat' AND c.name = 'Punishments
    RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText
    ```

    Example 2 - What does the Prophet say about those who don't pray.
    ```
    MATCH (t:Type)-[:OF]-(c:Concept)-[:DESCRIBES]-(h:Hadith)
    WHERE t.name = 'Salat' AND c.name = 'Punishments'
    RETURN h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText, h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
    ```

    Example 3 - What rewards of Fasting are mentioned in the Quran
    ```
    MATCH (t:Type)-[:OF]-(c:Concept)-[:MENTIONED_IN]-(v:Verse)
    WHERE t.name = 'Fasting' AND c.name = 'Rewards'
    RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText
    ```

    Example 4 - What does Quran say about Fasting in Ramadan
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)<-[:OF]-(c2:Concept)-[:MENTIONED_IN]-(v:Verse)
    WHERE t.name = 'Fasting' AND c1.name = 'Ramadan' AND c2.name = 'Rewards'
    RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText
    ```

    Example 5 - What does Quran say about Salah
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)-[:MENTIONED_IN]-(v:Verse)
    WHERE t.name = 'Salah' AND c1.name = 'Rewards'
    RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText
    ```

    Example 6 - What happens if I don't pray
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)-[:MENTIONED_IN]-(v:Verse)
    OPTIONAL MATCH (t)-[:OF]->(c1)-[:DESCRIBES]-(h:Hadith)
    WHERE t.name = 'Salah' AND c1.name = 'Punishments'
    RETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText, h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText, h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
    ```

    Example 6 - How did the prophet pay Zakah
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)-[:DESCRIBES]-(h:Hadith)
    WHERE t.name = 'Zakah' AND c1.name = 'Eligibility'
    RETURN h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText, h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
    ```
    
    Example 7 - What is the importance of Umrah
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)-[:DESCRIBES]-(h:Hadith)  
    WHERE t.name = 'Umrah' AND c1.name = 'Importance' 
    RETURN  h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText, h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
    ```
    
    Example 8 - How to perform Umrah
    ```
    MATCH (t:Type)-[:OF]-(c1:Concept)-[:DESCRIBES]-(h:Hadith)  
    WHERE t.name = 'Umrah' AND c1.name = 'Performance' 
    RETURN  h.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText, h.source as HadithSource,h.narratedBy as HadithNarratedBy, h.hadithNo as HadithNo
    ```

    Dont include ``` and \n in the output

    Remember Quran, Allah, Divine Revelation, etc. - all correponds to 'Verse' label node
    Remember Muhammad, Prophet, Sunnah, etc. - all correponds to 'Hadith' label node
    
    Remember to get both Hadith and Verse results if not mentioned explicitly
    
    Remember, if the data is coming from a Hadith label, use AS HadithArabicText, AS HadithEnglishText. If the data is from Verse label, use AS VerseArabicText, AS VerseEnglishText. Do this for all the attributes that you are calling

    Remember to use original terms for topics such as \"Salat\" for Prayer, \"Zakat\" for Charity, \"Hajj\" for Pilgirimage, and so on
    
    {input}"""
    # response = genai.generate_text(**defaults, prompt=prompt)
    response = model.generate_content(prompt)
    print(response.text)
    new_string = response.text.replace("Zakah", "Zakat")
    new_string = new_string.replace(">", "")
    new_string = new_string.replace("<", "")
    new_string = new_string.replace("v.verseID", "v.embeddings AS VerseEmbeddings, v.verseID")
    new_string = new_string.replace("h.hadithID", "h.embeddings AS HadithEmbeddings, h.hadithID")
    return new_string


def extract_query_and_return_key(input_query_result):
    slash_n_pattern = r'[ \n]+'
    ret_pattern = r'RETURN\s+(.*)'
    replacement = ' '

    cleaned_query = re.sub(slash_n_pattern, replacement, input_query_result)
    if cleaned_query:
        match = re.search(ret_pattern, cleaned_query)
        if match:
            extracted_string = match.group(1)
        else:
            extracted_string = ""
    return cleaned_query, extracted_string


def format_names_with_ampersand(names):
    if len(names) == 0:
        return ""
    elif len(names) == 1:
        return names[0]
    else:
        formatted_names = ", ".join(names[:-1]) + " & " + names[-1]
        return formatted_names


def run_cypher_on_neo4j(inp_query, inp_key):
    out_list = []
    with driver.session() as session:
        result = session.run(inp_query)
        for record in result:
            out_list.append(record[inp_key])
    driver.close()
    if len(out_list) > 1:
        print("Here 1")
        return format_names_with_ampersand(out_list)
    else:
        print("Here 2")
        return "out_list[0]"


def generate_and_exec_cypher(input_query):
    gen_query, gen_key = extract_query_and_return_key(get_answer(input_query))
    print(gen_query)
    return gen_query
    # return run_cypher_on_neo4j(gen_query, gen_key)


def getQueryEmbeddings(input_query):
    result = genai.embed_content(
        model="models/embedding-001",
        content=input_query,
        task_type="retrieval_document",
        title="Embedding of single string")

    return result['embedding']


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

    @staticmethod
    def getOntologies():
        records, summary, keys = Neo4jConn.executeNeo4jQuery(query="""
                MATCH (start)-[r:MENTIONED_IN|DESCRIBES|OF]->(end)
                RETURN 
                  r.externalUserID AS SCHOLAR_ID,
                  ID(r) AS REL_ID, 
                  CASE WHEN 'Verse' IN labels(start) THEN "Verse"
                       WHEN 'Hadith' IN labels(start) THEN "Hadith"
                       WHEN 'Surah' IN labels(start) THEN "Surah"
                       WHEN 'Concept' IN labels(start) THEN "Concept"
                       WHEN 'Type' IN labels(start) THEN "Type"
                       ELSE labels(start)
                  END AS STARTLABELTYPE,
                  CASE WHEN 'Verse' IN labels(start) THEN start.verseID
                       WHEN 'Hadith' IN labels(start) THEN start.hadithID
                       WHEN 'Surah' IN labels(start) THEN start.surah_number
                       WHEN 'Concept' IN labels(start) THEN start.identifier
                       WHEN 'Type' IN labels(start) THEN start.identifier
                       ELSE labels(start)
                  END AS STARTLABELID,
                  CASE WHEN 'Verse' IN labels(start) THEN start.englishText
                       WHEN 'Hadith' IN labels(start) THEN start.englishText
                       WHEN 'Surah' IN labels(start) THEN start.name
                       WHEN 'Concept' IN labels(start) THEN start.name
                       WHEN 'Type' IN labels(start) THEN start.name
                       ELSE labels(start)
                  END AS STARTLABELNAME,
                  type(r) AS RELNAME,
                  CASE WHEN 'Verse' IN labels(end) THEN "Verse"
                       WHEN 'Hadith' IN labels(end) THEN "Hadith"
                       WHEN 'Surah' IN labels(end) THEN "Surah"
                       WHEN 'Concept' IN labels(end) THEN "Concept"
                       WHEN 'Type' IN labels(end) THEN "Type"
                       ELSE labels(end)
                  END AS ENDLABELTYPE,
                  CASE WHEN 'Verse' IN labels(end) THEN end.verseID
                       WHEN 'Hadith' IN labels(end) THEN end.hadithID
                       WHEN 'Surah' IN labels(end) THEN end.surah_number
                       WHEN 'Concept' IN labels(end) THEN end.identifier
                       WHEN 'Type' IN labels(end) THEN end.identifier
                       ELSE labels(end)
                  END AS ENDLABELID,
                  CASE WHEN 'Verse' IN labels(end) THEN end.englishText
                       WHEN 'Hadith' IN labels(end) THEN end.englishText
                       WHEN 'Surah' IN labels(end) THEN end.name
                       WHEN 'Concept' IN labels(end) THEN end.name
                       WHEN 'Type' IN labels(end) THEN end.name
                       ELSE labels(end)
                  END AS ENDLABELNAME
            """)
        return records, summary, keys

    @staticmethod
    def deleteOntology(ontID, scholarID):
        query = """
            MATCH ()-[r]-() 
            WHERE id(r)=$relID AND r.externalUserID=$scholarID
            DELETE r
        """
        parameters = {"relID": int(ontID), "scholarID": str(scholarID)}
        records, summary, keys = Neo4jConn.executeNeo4jQuery(query=query, parameters=parameters)
        return records, summary, keys

    @staticmethod
    def getResults(query):
        return generate_and_exec_cypher(query), getQueryEmbeddings(query)

    @staticmethod
    def googleSearch(searchTerm, **kwargs):
        service = build("customsearch", "v1", developerKey=my_api_key)
        res = service.cse().list(q=searchTerm, cx=my_cse_id, **kwargs).execute()
        return res['items']


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
