import utils.constants as constants

from flask import Flask, redirect, url_for, request, Response
from neo4j import GraphDatabase

from models.surah import Surah
from models.verse import Verse
from utils.utils import getUniqueSurahs, groupVerses, setSurahAndVerseJson, setSurahJson

app = Flask(__name__)


with GraphDatabase.driver(constants.URI, auth=constants.AUTH) as driver:
    driver.verify_connectivity()

    records, summary, keys = driver.execute_query(
        "MATCH (v:Verse),(s:Surah)"
        + "\nMATCH (v)-[:VERSE_OF]->(s)"
        + "\nRETURN v.verseID as ID, v.englishText as EnglishText, v.arabicText as ArabicText,"
        + "\ns.name as surahName, s.revelation_place as revealedIn, s.surah_number as surahNumber",
        database_="neo4j",
    )

    verses = []
    surahs = []

    for record in records:
        surahs.append(Surah(record['surahName'], record['surahNumber'], record['revealedIn']))
        verses.append(Verse(record['ID'], record['EnglishText'], record['ArabicText']))

    surahs = getUniqueSurahs(surahs)
    groupedVerses = groupVerses(verses)
    surahs = setSurahAndVerseJson(surahs, groupedVerses)

    data = setSurahJson(surahs)
    print(data)

    print()
    # Summary information
    print("The query `{query}` returned {records_count} records in {time} ms.".format(
        query=summary.query, records_count=len(records),
        time=summary.result_available_after,
    ))
    print(type(summary.result_available_after))

    # session.close()
    driver.close()


@app.route('/')
def root():
    return Response(data, mimetype="text/json", ), 200
    # return 'Hello'


@app.route('/success/<name>')
def success(name):
    return 'welcome %s' % name


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        user = request.form['nm']
        return redirect(url_for('success', name=user))
    else:
        user = request.args.get('nm')
        return redirect(url_for('success', name=user))


if __name__ == '__main__':
    app.run(debug=True)
