from dotenv import load_dotenv
import os
import json

from flask import Flask, redirect, url_for, request, Response, jsonify

from controllers.ontology_con import OntologyCon
from models.ontology import Ontology, DataType, NodeType
from models.surah import Surah
from models.topic import Topic
from models.verse import Verse
from models.hadith import Hadith
from models.dua import Dua
from utils.authUtils import authenticate, generate_jwt_token, role_required
from utils.utils import getUniqueSurahs, getUniqueVerses, getUniqueHadiths, groupVerses, setSurahAndVerseJson, \
    setSurahJson, createDataJSON, createResultsJSON

from conn.mongodb_conn import MongoDBConn
from conn.neo4j_conn import Neo4jConn
from controllers.dua_con import DuaCon
from controllers.hadith_con import HadithCon
from controllers.verse_con import VerseCon
from controllers.surah_con import SurahCon
from controllers.topic_con import TopicCon

from flask_cors import CORS

from functools import wraps
import jwt
from datetime import datetime, timedelta

app = Flask(__name__)
CORS(app)
load_dotenv()

# app.config['SECRET_KEY'] = 'your_secret_key_here'

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
    return 'Hello World'


@app.route('/duas', methods=["GET"])
def getDuas():
    duaID = request.args.get('id')
    duaTypeTitle = request.args.get('typeTitle')
    duaTypeID = request.args.get('typeID')

    if duaID:
        jsonData = DuaCon.getDuaByID(duaID)
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200
    elif duaTypeID is not None:
        print(duaTypeID)
        jsonData = DuaCon.getDuasFromType(duaTypeID)
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


@app.route('/surahs', methods=["GET"])
def getSurahs():
    surahID = request.args.get('id')
    duaType = request.args.get('type')

    if surahID:
        jsonData = SurahCon.getSurahByID(surahID)
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
        jsonData = SurahCon.getAllSurahs()
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200


@app.route('/types', methods=["GET"])
def getTypes():
    jsonData = TopicCon.getAllTypes()
    return Response(jsonData, mimetype="text/json"), 200


@app.route('/concepts', methods=["GET"])
def getConcepts():
    typeID = request.args.get('type')
    conceptID = request.args.get('id')

    if typeID is not None:
        jsonData = TopicCon.getAllConceptsByType(typeID)
        return Response(jsonData, mimetype="text/json"), 200

    elif conceptID is not None:
        jsonData = TopicCon.getConceptByID(conceptID)
        return Response(jsonData, mimetype="text/json"), 200

    # if surahID:
    #     jsonData = SurahCon.getSurahByID(surahID)
    #     if 'error' in jsonData:
    #         return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
    #                         mimetype="text/json"), 500
    #     else:
    #         return Response(jsonData, mimetype="text/json"), 200
    # elif duaType is not None:
    #     print(duaType)
    #     jsonData = DuaCon.getDuasFromType(duaType)
    #     if 'error' in jsonData:
    #         return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
    #                         mimetype="text/json"), 500
    #     else:
    #         return Response(jsonData, mimetype="text/json"), 200
    # else:
    #     jsonData = SurahCon.getAllSurahs()
    #     if 'error' in jsonData:
    #         return Response(json.dumps({'status': 500, 'totalResults': 0, 'error': jsonData['error']}),
    #                         mimetype="text/json"), 500
    #     else:
    #         return Response(jsonData, mimetype="text/json"), 200


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


@app.route('/ontologies', methods=["GET"])
def getOntologies():
    records, summary, keys = Neo4jConn.executeNeo4jQuery(query="""
        MATCH (start)-[r:MENTIONED_IN|DESCRIBES|OF]->(end)
RETURN 
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

    dataObj = {
        "topics": [],
    }

    of_records = []
    mentioned_or_describes_records = []

    for record in records:
        if record["RELNAME"] == 'OF':
            of_records.append(record)
        elif record["RELNAME"] == 'MENTIONED_IN' or record["RELNAME"] == 'DESCRIBES':
            mentioned_or_describes_records.append(record)

    for record in of_records:
        dataObj = addConcept(record, dataObj)
    for record in mentioned_or_describes_records:
        dataObj = addRelation(record, dataObj)

    dataObjDict = {
        key: [topic.to_dict() if isinstance(topic, Topic) else topic for topic in value]
        for key, value in dataObj.items()
    }

    response = createResultsJSON(dataObjDict, summary.query, len(records), summary.result_available_after, 200)

    return Response(response, mimetype="application/json"), 200


def addConcept(record, dataObj):
    newCon = Topic(identifier=record['STARTLABELID'], name=record['STARTLABELNAME'], flag=False)
    newTop = Topic(identifier="DefaultID", name="DefaultName")

    if record['ENDLABELTYPE'] == 'Type':
        newTop = Topic(identifier=record['ENDLABELID'], name=record['ENDLABELNAME'])
        if not any(top.id == record['ENDLABELID'] for top in dataObj.get('topics', [])):
            dataObj.setdefault('topics', []).append(newTop)

    if not any(con.id == record['STARTLABELID'] for con in dataObj.get('concepts', [])):
        if newTop.id != 'DefaultID':
            for topic in dataObj['topics']:
                if topic.id == record['ENDLABELID']:
                    topic.concepts.append(newCon)
                    if topic.concepts.index(newCon) == 0:
                        newCon.flag = True
                    break
    return dataObj


def addRelation(record, dataObj):
    if record["RELNAME"] == "MENTIONED_IN":
        dataObj = addVerseRelation(record, dataObj)
    else:
        dataObj = addHadithRelation(record, dataObj)

    return dataObj


def addVerseRelation(record, dataObj):
    ont = Ontology.from_relationship(
        relationshipName=record["RELNAME"],
        startNode=Topic(record['STARTLABELID']),
        endNode=Verse(verseID=record["ENDLABELID"], englishText="something English", arabicText="something Arabic"),
        uid="23324"
    )
    if len(record['STARTLABELID']) <= 2:
        for topic in dataObj['topics']:
            if topic.id == record['STARTLABELID']:
                topic.relationships.append(ont)
                break
    for topic in dataObj['topics']:
        for con in topic.concepts:
            if con.id == record['STARTLABELID']:
                con.relationships.append(ont)
                if con.relationships.index(ont) == 0:
                    ont.flag = True
                break
    return dataObj


def addHadithRelation(record, dataObj):
    ont = Ontology.from_relationship(
        relationshipName=record["RELNAME"],
        endNode=Topic(record['ENDLABELID']),
        startNode=Hadith(hadithID=record["STARTLABELID"], englishText="something English", arabicText="something Arabic"),
        uid="23324"
    )
    if len(record['ENDLABELID']) <= 2:
        for topic in dataObj['topics']:
            if topic.id == record['ENDLABELID']:
                topic.relationships.append(ont)
                break
    for topic in dataObj['topics']:
        for con in topic.concepts:
            if con.id == record['ENDLABELID']:
                con.relationships.append(ont)
                if con.relationships.index(ont) == 0:
                    ont.flag = True
                break
    return dataObj


@app.route('/ontologies', methods=["POST"])
def addOntology():
    dummyJson = {
        "dataType": "verse OR hadith",
        "dataID": "verseID OR hadithID",
        "mainTheme": "TypeID",
        "concept": "ConceptID",
        "userID": "111"
    }
    if request.method == "POST":
        params = request.json
        print(params)
        dataTypeStr = params.get("dataType")
        print(dataTypeStr)

        if dataTypeStr not in DataType.__members__:
            raise ValueError("Invalid dataType provided")

        dataTypeEnum = DataType[dataTypeStr]  # Convert string to enum
        print(dataTypeEnum)
        params["dataType"] = dataTypeEnum

        print(params["dataType"])

        ontology = Ontology(**params)
        OntologyCon.addOntology(ontology)

        print(params)

    return jsonify({'message': 'create Ontology'}), 201


@app.route('/admin')
@role_required('admin')
def admin_route():
    return jsonify({'message': 'Welcome Admin!'})


@app.route('/scholar', methods=['GET'])
@role_required('scholar')
def scholar_route():
    return jsonify({'message': 'Welcome Scholar!'})


@app.route('/user')
@role_required('user')
def user_route():
    return jsonify({'message': 'Welcome User!'})


# Login route to authenticate users and generate JWT token
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    print(data)
    username = data.get('username')
    password = data.get('password')

    user = authenticate(username, password)
    if user:
        token = generate_jwt_token(user)
        return jsonify({'token': token})
    else:
        return jsonify({'error': 'Invalid username or password'}), 401


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


if __name__ == '__main__':
    # ont = Ontology.from_relationship(relationshipName="MENTIONED_IN", startNode=Topic(identifier="ZK"),
    #                                  endNode=Verse(verseID="2:83", englishText="English Text",
    #                                                arabicText="Arabic Text"), uid=111)
    # print(ont.startNode.id)
    # print(ont.relationshipName)
    # print(ont.endNode.id)

    app.run(debug=True, port=48275, host="192.168.56.1")
