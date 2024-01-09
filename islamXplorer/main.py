from dotenv import load_dotenv
import os
import json

from flask import Flask, redirect, url_for, request, Response

from models.surah import Surah
from models.verse import Verse
from models.hadith import Hadith
from models.dua import Dua
from utils.utils import getUniqueSurahs, getUniqueVerses, getUniqueHadiths, groupVerses, setSurahAndVerseJson, \
    setSurahJson, createDataJSON

from conn.mongodb_conn import MongoDBConn
from conn.neo4j_conn import Neo4jConn
from controllers.dua_con import DuaCon
from controllers.hadith_con import HadithCon
from controllers.verse_con import VerseCon

app = Flask(__name__)
load_dotenv()

# print("TOTAL UNIQUE VERSES: " + str(len(unique_verse_list)))
# print("TOTAL UNIQUE HADITHS: " + str(len(unique_hadith_list)))
# # for item in unique_list:
# #     print(item)
#
#
# print()
# # Summary information
# print("The query `{query}` returned {records_count} records in {time} ms.".format(
#     query=summary.query, records_count=len(records),
#     time=summary.result_available_after,
# ))
# print(summary.result_available_after)


# session.close()
# driver.close()


methodNotAllowedJson = json.dumps(
    {
        "status": 405,
        "error": "Method Not Allowed"
    },
    ensure_ascii=False, default=str, indent=2
)

duaParameters = {
    'duaID': ["required", "str"],
    'title': ["required", "str"],
    'arabicText': ["required", "str"],
    'englishText': ["required", "str"],
    'explanation': ["optional", "str"],
    'surah': ["required", "int"],
    'verses': ["required", "str"],
    'transliteration': ["optional", "str"],
    'types': ["required", "list"],
}


@app.route('/')
def root():
    # jsonData = MongoDBConn.getAllDuas()
    # return Response(jsonData, mimetype="text/json", ), 200
    return 'Hello'


@app.route('/duas', methods=["GET"])
def getDuas():
    duaID = request.args.get('id')
    duaType = request.args.get('type')

    if duaID:
        jsonData = DuaCon.getDuaByID(duaID)
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200
    elif duaType is not None:
        print(duaType)
        jsonData = DuaCon.getDuasFromType(duaType)
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200
    else:
        jsonData = DuaCon.getAllDuas()
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200


@app.route('/duas', methods=["DELETE"])
def deleteDua():
    duaID = str(request.args.get('id'))
    if duaID is not None:
        jsonData = DuaCon.deleteDuaByID(duaID)
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200

    else:
        return Response(methodNotAllowedJson, mimetype="text/json"), 405


@app.route('/duas', methods=["PUT"])
def updateDua():
    oldID = request.args.get('id')
    params = request.json
    dua = Dua(**params)
    jsonData = DuaCon.updateDuaByID(oldID, dua)
    parsed_data = json.loads(jsonData)
    if parsed_data["status"] != 200:
        print("Fail")
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/duas', methods=["POST"])
def addDua():
    if request.method == "POST":
        params = request.json
        print(params)
        errors = []

        for param, [required, expected_type] in duaParameters.items():
            if required == 'required' and param not in params:
                errors.append(param.__str__())
            elif param in params and not isinstance(params[param], eval(expected_type)):
                errors.append(
                    f'Invalid data type for parameter {param}. Expected {expected_type}, got {type(params[param])}')

        if errors:
            return Response(
                json.dumps({
                    'status': 400,
                    'requiredParameters': {", ".join(errors)}
                },
                    ensure_ascii=False, default=str, indent=2
                ),
                mimetype="text/json"
            ), 400
        else:
            dua = Dua(**params)
            print(dua.types)
            jsonData = DuaCon.addDua(dua)

            if 'error' in jsonData:
                return Response(json.dumps({'status': 500, 'error': jsonData['error']}),
                                mimetype="text/json"), 500
            else:
                return Response(jsonData, mimetype="text/json"), 201

            # return Response(jsonData, mimetype="text/json"), 201
    # else:
    #     return Response(methodNotAllowedJson, mimetype="text/json"), 405


@app.route('/getDuasFromType', methods=["GET"])
def getDuasFromType():
    duaType = str(request.args.get('duaType'))
    jsonData = DuaCon.getDuasFromType(duaType)
    return Response(jsonData, mimetype="text/json"), 200


@app.route('/getAllDuaTypes')
def getAllDuaTypes():
    jsonData = DuaCon.getAllDuaTypes()

    if 'error' in jsonData:
        return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                        mimetype="text/json"), 500
    else:
        return Response(jsonData, mimetype="text/json"), 200


@app.route('/hadiths', methods=["GET"])
def getHadiths():
    hadithID = request.args.get('id')
    if hadithID:
        # print(hadithID)
        jsonData = HadithCon.getHadithByID(hadithID)
        return Response(jsonData, mimetype="text/json", ), 200
    else:
        jsonData = HadithCon.getAllHadiths()
        return Response(jsonData, mimetype="text/json", ), 200


@app.route('/hadiths', methods=["POST"])
def addHadith():
    if request.method == "POST":
        params = request.json
        hadith = Hadith(**params)
        # print(dua.types)
        HadithCon.addHadith(hadith)
    return 'Done!!!!'


@app.route('/hadiths', methods=["PUT"])
def updateHadith():
    # print(id)
    oldID = request.args.get('id')
    params = request.json
    hadith = Hadith(**params)
    jsonData = HadithCon.updateHadithByID(hadith, oldID)
    parsed_data = json.loads(jsonData)
    if parsed_data["status"] != 200:
        print("Fail")
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/hadiths', methods=["DELETE"])
def deleteHadith():
    hadithID = request.args.get('id')
    jsonData = HadithCon.deleteHadithByID(hadithID)
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/verses', methods=["GET"])
def getVerses():
    verseID = request.args.get('id')
    if verseID:
        jsonData = VerseCon.getVerseByID(verseID)
        return Response(jsonData, mimetype="text/json", ), 200
    else:
        jsonData = VerseCon.getAllVerses()
        return Response(jsonData, mimetype="text/json", ), 200


@app.route('/verses', methods=["POST"])
def addVerse():
    if request.method == "POST":
        params = request.json
        verse = Verse(**params)
        # print(dua.types)
        VerseCon.addVerse(verse)
    return 'Done!!!!'


@app.route('/verses', methods=["PUT"])
def updateVerse():
    print(id)
    oldID = request.args.get('id')
    params = request.json
    verse = Verse(**params)
    jsonData = VerseCon.updateVerseByID(verse, oldID)
    parsed_data = json.loads(jsonData)
    if parsed_data["status"] != 200:
        print("Fail")
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/verses/<id>', methods=["DELETE"])
def deleteVerse(id):
    print(id)
    jsonData = VerseCon.deleteVerseByID(id)
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/results', methods=["GET"])
def results():
    records, summary, keys = Neo4jConn.executeNeo4jQuery()
    queryResults = extractNeo4jResults(records, summary)

    return Response(queryResults, mimetype="text/json"), 200


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        user = request.form['nm']
        return redirect(url_for('success', name=user))
    else:
        user = request.args.get('nm')
        return redirect(url_for('success', name=user))


def extractNeo4jResults(records, summary):
    verses = []
    surahs = []
    hadiths = []

    dummy_verses = []
    dummy_hadiths = []

    for record in records:
        surah = Surah(record['surahName'], record['surahNumber'], record['revealedIn'])
        surahs.append(surah)
        verses.append(Verse(record['VerseID'], record['VerseEnglishText'], record['VerseArabicText'], surah.name,
                            record['surahNumber']))
        dummy_verses.append(record['VerseID'])
        dummy_hadiths.append(record['HadithID'])
        hadiths.append(
            Hadith(record['HadithID'], record['HadithNo'], record['HadithEnglishText'], record['HadithArabicText'],
                   record['HadithSource'],
                   record['HadithNarratedBy']))

    surahs = getUniqueSurahs(surahs)
    verses = getUniqueVerses(verses)
    hadiths = getUniqueHadiths(hadiths)
    groupedVerses = groupVerses(verses)
    surahs = setSurahAndVerseJson(surahs, groupedVerses)

    return createDataJSON(summary.query, summary.result_available_after, verses, hadiths)

    # print("TOTAL HADITHS: " + str(len(hadiths)))
    # print("TOTAL VERSES: " + str(len(verses)))
    # for hadith in hadiths:
    #     print(hadith)

    # unique_hadith_list = []
    # for item in dummy_hadiths:
    #     if item not in unique_hadith_list:
    #         unique_hadith_list.append(item)
    #
    # unique_verse_list = []
    # for item in dummy_verses:
    #     if item not in unique_verse_list:
    #         unique_verse_list.append(item)


if __name__ == '__main__':
    app.run(debug=True, port=48275, host="192.168.56.1")
