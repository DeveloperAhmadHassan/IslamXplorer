from enum import verify

from neo4j import GraphDatabase
import json
import os
import openai
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.vectorstores.neo4j_vector import Neo4jVector
from langchain.graphs import Neo4jGraph
import requests
import tiktoken

from langchain.chat_models import vertexai
from langchain.chains import GraphCypherQAChain
from langchain.graphs import Neo4jGraph

os.environ['OPENAI_API_KEY'] = "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"

graph = Neo4jGraph(
        url = "neo4j+s://09971ffa.databases.neo4j.io",
        username = "neo4j",
        password = "cQicn0wJTQ5KTVrwqkP5C-7nfcV5D88NNegHLK4wo_0"
)

# chain = GraphCypherQAChain.from_llm(
#     ChatOpenAI(temperature=0), graph=graph, verbose=True,
# )

chain = GraphCypherQAChain.from_llm(
        vertexai, graph=graph
)

# chain.run("""
# Which intermediary is connected to most entites?
# """)

# model_id = "sentence-transformers/all-MiniLM-L6-v2"
# hf_token = "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"
#
# api_url = f"https://api-inference.huggingface.co/pipeline/feature-extraction/{model_id}"
# headers = {"Authorization": f"Bearer {hf_token}"}
#
# def query(texts):
#     response = requests.post(api_url, headers=headers, json={"inputs": texts, "options":{"wait_for_model":True}})
#     return response.json()
#
# texts = ["How do I get a replacement Medicare card?",
#         "What is the monthly premium for Medicare Part B?",
#         "How do I terminate my Medicare Part B (medical insurance)?",
#         "How do I sign up for Medicare?",
#         "Can I sign up for Medicare Part B if I am working and have health insurance through an employer?",
#         "How do I sign up for Medicare Part B if I already have Part A?",
#         "What are Medicare late enrollment penalties?",
#         "What is Medicare and who can get it?",
#         "How can I get help with my Medicare Part A and Part B premiums?",
#         "What are the different parts of Medicare?",
#         "Will my Medicare premiums be higher because of my higher income?",
#         "What is TRICARE ?",
#         "Should I sign up for Medicare Part B if I have Veterans' Benefits?"]
#
# output = query(texts)
#
# import pandas as pd
# embeddings = pd.DataFrame(output)
# embeddings.to_csv("embeddings.csv", index=False)
# print(embeddings)


# url = "neo4j+s://09971ffa.databases.neo4j.io"
# username = "neo4j"
# password = "cQicn0wJTQ5KTVrwqkP5C-7nfcV5D88NNegHLK4wo_0"
# AUTH = ("neo4j", "cQicn0wJTQ5KTVrwqkP5C-7nfcV5D88NNegHLK4wo_0")
#

#
# vector_index = Neo4jVector.from_existing_graph(
#     OpenAIEmbeddings(),
#     url=url,
#     username = username,
#     password =password,
#     index_name="verses",
#     node_label="Verse",
#     text_node_properties=['englishText', 'verseID'],
#     embedding_node_property='embedding'
# )

# with GraphDatabase.driver(URI, auth=AUTH) as driver:
#     driver.verify_connectivity()
#     print('Hello')
#
#     records, summary, keys = driver.execute_query(
#         "MATCH (v:Verse) \n RETURN v.verseID as ID, v.englishText as EnglishText, v.arabicText as ArabicText",
#         database_="neo4j",
#     )
#
#     json_verses = []
#     verses = []
#     # Loop through results and do something with them
#     for person in records:
#         # print(person)
#         verses.append(person.data())
#         json_verses.append(json.dumps(verses, ensure_ascii=False))
#         # print(json_verses)
#
#         # arabicVerse = verse['ArabicText']
#         # new_verse = arabicVerse.replace('\u065C', '').replace('\uE01C', '')
#         # new_verse = arabicVerse.replace('ۡ', '')
#
#         # verses =[]
#         # verses.append(arabicVerse)
#         #
#         # print(new_verse)
#         #
#         # for i in range(len(verses)):
#         #     # for each string in the text list
#         #     for char in verses[i]:
#         #         # for each character in the individual string
#         #         if ord(char) > 128:
#         #             verses[i] = verses[i].replace(char, '')
#         #
#         # print(verses[0])
#
#     X = {
#         "Surahs": [
#             {
#                 "name": "Surah Name",
#                 "revealedIn": "Revealed Place",
#                 "verses": [
#                     verses
#                 ]
#             }
#         ]
#     }
#     Y = json.dumps(X, ensure_ascii=False, indent=4)
#     # print(Y)
#
#     # Summary information
#     print("The query `{query}` returned {records_count} records in {time} ms.".format(
#         query=summary.query, records_count=len(records),
#         time=summary.result_available_after,
#     ))
#     print(type(summary.result_available_after))
#
#     # session.close()
#     driver.close()