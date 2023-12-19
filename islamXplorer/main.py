import utils.constants as constants

from flask import Flask, redirect, url_for, request, Response
from neo4j import GraphDatabase

from models.surah import Surah
from models.verse import Verse
from models.hadith import Hadith
from utils.utils import getUniqueSurahs, getUniqueVerses, getUniqueHadiths, groupVerses, setSurahAndVerseJson, setSurahJson, createDataJSON

app = Flask(__name__)

with GraphDatabase.driver(constants.URI, auth=constants.AUTH) as driver:
    driver.verify_connectivity()

    records, summary, keys = driver.execute_query(
        "MATCH (v:Verse),(s:Surah)"
        + "\nOPTIONAL MATCH (h:Hadith)"
        + "\nMATCH (v)-[:VERSE_OF]->(s)"
        + "\nRETURN v.verseID as VerseID, v.englishText as VerseEnglishText, v.arabicText as VerseArabicText,"
        + "\ns.name as surahName, s.revelation_place as revealedIn, s.surah_number as surahNumber,"
        + "\nh.hadithID as HadithID, h.arabicText as HadithArabicText,h.englishText as HadithEnglishText,h.source as "
          "HadithSource,h.narratedBy as HadithNarratedBy",
        database_="neo4j",
    )

    verses = []
    surahs = []
    hadiths = []

    dummy_verses=[]
    dummy_hadiths = []

    for record in records:
        surah = Surah(record['surahName'], record['surahNumber'], record['revealedIn'])
        surahs.append(surah)
        verses.append(Verse(record['VerseID'], record['VerseEnglishText'], record['VerseArabicText'], surah.name))
        dummy_verses.append(record['VerseID'])
        dummy_hadiths.append(record['HadithID'])
        hadiths.append(Hadith(record['HadithID'], record['HadithEnglishText'], record['HadithArabicText'], record['HadithSource'], record['HadithNarratedBy']))

    surahs = getUniqueSurahs(surahs)
    verses = getUniqueVerses(verses)
    hadiths = getUniqueHadiths(hadiths)
    groupedVerses = groupVerses(verses)
    surahs = setSurahAndVerseJson(surahs, groupedVerses)

    results = createDataJSON(summary.query, summary.result_available_after, verses, hadiths)
    print(results)

    # results = (data, summary.query, len(records), summary.result_available_after)
    # print(results)

    print("TOTAL HADITHS: "+str(len(hadiths)))
    print("TOTAL VERSES: " + str(len(verses)))
    # for hadith in hadiths:
    #     print(hadith)

    unique_hadith_list = []
    for item in dummy_hadiths:
        if item not in unique_hadith_list:
            unique_hadith_list.append(item)

    unique_verse_list = []
    for item in dummy_verses:
        if item not in unique_verse_list:
            unique_verse_list.append(item)
    print("TOTAL UNIQUE VERSES: " + str(len(unique_verse_list)))
    print("TOTAL UNIQUE HADITHS: "+str(len(unique_hadith_list)))
    # for item in unique_list:
    #     print(item)


    print()
    # Summary information
    print("The query `{query}` returned {records_count} records in {time} ms.".format(
        query=summary.query, records_count=len(records),
        time=summary.result_available_after,
    ))
    print(summary.result_available_after)

    # session.close()
    driver.close()


@app.route('/')
def root():
    return Response(results, mimetype="text/json", ), 200
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
