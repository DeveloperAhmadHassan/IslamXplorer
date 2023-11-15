from neo4j import GraphDatabase
import json

URI = "neo4j+s://09971ffa.databases.neo4j.io"
AUTH = ("neo4j", "cQicn0wJTQ5KTVrwqkP5C-7nfcV5D88NNegHLK4wo_0")

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    driver.verify_connectivity()
    print('Hello')

    records, summary, keys = driver.execute_query(
        "MATCH (v:Verse) \n RETURN v.verseID as ID, v.englishText as EnglishText, v.arabicText as ArabicText",
        database_="neo4j",
    )

    json_verses = []
    verses = []
    # Loop through results and do something with them
    for person in records:
        # print(person)
        verses.append(person.data())
        json_verses.append(json.dumps(verses, ensure_ascii=False))
        # print(json_verses)

        # arabicVerse = verse['ArabicText']
        # new_verse = arabicVerse.replace('\u065C', '').replace('\uE01C', '')
        # new_verse = arabicVerse.replace('ۡ', '')

        # verses =[]
        # verses.append(arabicVerse)
        #
        # print(new_verse)
        #
        # for i in range(len(verses)):
        #     # for each string in the text list
        #     for char in verses[i]:
        #         # for each character in the individual string
        #         if ord(char) > 128:
        #             verses[i] = verses[i].replace(char, '')
        #
        # print(verses[0])

    X = {
        "Surahs": [
            {
                "name": "Surah Name",
                "revealedIn": "Revealed Place",
                "verses": [
                    verses
                ]
            }
        ]
    }
    Y = json.dumps(X, ensure_ascii=False, indent=4)
    # print(Y)

    # Summary information
    print("The query `{query}` returned {records_count} records in {time} ms.".format(
        query=summary.query, records_count=len(records),
        time=summary.result_available_after,
    ))
    print(type(summary.result_available_after))

    # session.close()
    driver.close()