from dotenv import load_dotenv
import json

from firebase_admin import auth
from flask import Flask, request, Response, jsonify

from controllers.ontology_con import OntologyCon
from models.googleResult import GoogleResult
from models.ontology import Ontology, DataType
from models.surah import Surah
from models.topic import Topic
from models.verse import Verse
from models.hadith import Hadith
from models.dua import Dua
from utils.authUtils import authenticate, generateJWTToken, role_required, getUserRecord, \
    authenticateById
from utils.utils import getUniqueSurahs, getUniqueVerses, getUniqueHadiths, groupVerses, setSurahAndVerseJson, \
    createDataJSON, createResultsJSON

from conn.neo4j_conn import Neo4jConn
from controllers.dua_con import DuaCon
from controllers.hadith_con import HadithCon
from controllers.verse_con import VerseCon
from controllers.surah_con import SurahCon
from controllers.topic_con import TopicCon

from flask_cors import CORS

app = Flask(__name__)
CORS(app)
load_dotenv()

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

surahParameters = {
    'number': ["required", "int"],
    'name': ["required", "str"],
    'revealedIn': ["required", "str"],
    'totalVerses': ["required", "int"],
    'euid': ['required', 'str']
}


@app.route('/')
def root():
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
    duaID = str(request.args.get('duaID'))
    if duaID is not None:
        jsonData = DuaCon.deleteDuaByID(duaID)
        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        else:
            return Response(jsonData, mimetype="text/json"), 200
    return Response(methodNotAllowedJson, mimetype="text/json"), 405


@app.route('/duas', methods=["PUT"])
def updateDua():
    oldID = request.args.get('duaID')
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

        dua = Dua(**params)
        jsonData = DuaCon.addDua(dua)

        if 'error' in jsonData:
            return Response(json.dumps({'status': 500, 'error': jsonData['error']}),
                            mimetype="text/json"), 500
        return Response(jsonData, mimetype="text/json"), 201


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
        print(surahID)
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


@app.route('/surahs', methods=["POST"])
def addSurah():
    if request.method == "POST":
        params = request.json
        errors = []
        for param, [required, expected_type] in surahParameters.items():
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
            surah = Surah(**params)
            jsonData = SurahCon.addSurah(surah)

            if 'error' in jsonData:
                return Response(json.dumps({'status': 500, 'error': jsonData['error']}),
                                mimetype="text/json"), 500
            else:
                return jsonData, 201


@app.route('/types', methods=["GET"])
def getTypes():
    jsonData = TopicCon.getAllTypes()
    return Response(jsonData, mimetype="text/json"), 200


@app.route('/concepts', methods=["GET"])
def getConcepts():
    typeID = request.args.get('type')
    conceptID = request.args.get('verseID')

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
    hadithID = request.args.get('hadithID')
    chapter = request.args.get('chapter')
    if hadithID:
        jsonData = HadithCon.getHadithByID(hadithID)
        return Response(jsonData, mimetype="text/json", ), 200
    elif chapter:
        jsonData = HadithCon.getAllHadithsByChapter(int(chapter))
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
    oldID = request.args.get('verseID')
    params = request.json
    hadith = Hadith(**params)
    jsonData = HadithCon.updateHadithByID(hadith, oldID)
    parsed_data = json.loads(jsonData)
    if parsed_data["status"] != 200:
        print("Fail")
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/hadiths', methods=["DELETE"])
def deleteHadith():
    hadithID = request.args.get('verseID')
    jsonData = HadithCon.deleteHadithByID(hadithID)
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/verses', methods=["GET"])
def getVerses():
    verseID = request.args.get('verseID')
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
    return jsonify({"message": "New Verse Node Created!"}), 201


@app.route('/verses', methods=["PUT"])
def updateVerse():
    oldID = request.args.get('verseID')
    params = request.json
    verse = Verse(**params)
    VerseCon.updateVerseByID(verse, oldID)
    # parsed_data = json.loads(jsonData)
    # if parsed_data["status"] != 200:
    #     print("Fail")
    return jsonify({"message": "Verse Updated"}), 200


@app.route('/verses/<verseID>', methods=["DELETE"])
def deleteVerse(id):
    print(id)
    jsonData = VerseCon.deleteVerseByID(id)
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/results', methods=["GET"])
def results():
    query = request.args.get('query') or request.args.get('q')
    embeddingsFlag = request.args.get('embeddings') or request.args.get('e')

    try:
        embeddingsFlag = bool(int(embeddingsFlag))
    except (ValueError, TypeError):
        embeddingsFlag = False

    if query is None:
        return jsonify({'Message': 'Missing Query'}), 500

    cipherQuery, inputQueryEmbeddings = OntologyCon.getResults(query)

    records, summary, keys = Neo4jConn.executeNeo4jQuery(query=cipherQuery)
    print("Length: "+str(len(records)))
    queryResults = []
    if len(records) > 0:
        queryResults = extractNeo4jResults(records, summary, embeddingsFlag, inputQueryEmbeddings)
    else:
        googleResults = OntologyCon.googleSearch(query, num=10)
        resultsList = []
        for res in googleResults:
            resultsList.append(GoogleResult(
                resID="0.0",
                title=res['title'],
                link=res['link']
            ))
        queryResults = createDataJSON(summary.query, summary.result_available_after, googleObjects=resultsList)

    return Response(queryResults, mimetype="text/json"), 200


@app.route('/ontologies', methods=["GET"])
def getOntologies():
    records, summary, keys = OntologyCon.getOntologies()

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

    # print(response["data"][2])

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
        endNode=Verse(verseID=record["ENDLABELID"], englishText=record["ENDLABELNAME"], arabicText="something Arabic"),
        uid=record['SCHOLAR_ID'],
        relId=record['REL_ID']
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
        startNode=Hadith(hadithID=record["STARTLABELID"], englishText=record["STARTLABELNAME"],
                         arabicText="something Arabic"),
        uid=record['SCHOLAR_ID'],
        relId=record['REL_ID']
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


@app.route('/ontologies/<id>', methods=["DELETE"])
def deleteOntology(id):
    if request.method == "DELETE":
        params = request.json
        records, summary, keys = OntologyCon.deleteOntology(id, params['scholarID'])
        print(records)
        print(summary)
        print(keys)

    return jsonify({'message': 'deleted Ontology'}), 200


@app.route('/hadith-sources', methods=["GET"])
def hadithSources():
    hadithSource = request.args.get('source')
    if hadithSource:
        jsonData = HadithCon.getHadithSourceChapters(source=hadithSource)
        return Response(jsonData, mimetype="text/json", ), 200
    jsonData = HadithCon.getHadithSources()
    return Response(jsonData, mimetype="text/json", ), 200


@app.route('/hadith-relations', methods=["GET"])
def hadithRelatedContent():
    hadithID = request.args.get('hadithID')
    if hadithID:
        jsonData = HadithCon.getHadithRelatedContent(hadithID=hadithID)
        return Response(jsonData, mimetype="text/json", ), 200

    return jsonify({"message": "hadithID not found"}), 500


@app.route('/admin')
@role_required('A')
def admin_route():
    return jsonify({'message': 'Welcome Admin!'})


@app.route('/scholar', methods=['GET'])
@role_required('S')
def scholar_route():
    print("Scholar")
    return jsonify({'message': 'Welcome Scholar!'})


@app.route('/user')
@role_required('U')
def user_route():
    return jsonify({'message': 'Welcome User!'})


# Login route to authenticate users and generate JWT token
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')
    token = data.get('idToken')

    if email and password:
        user = authenticate(email, password)
        if user:
            user = getUserRecord(user["localId"])
            token = generateJWTToken(user)
            return jsonify({'token': token})
        else:
            return jsonify({'error': 'Invalid username or password'}), 401
    elif token:
        user = authenticateById(token)
        if user:
            user = getUserRecord(user.uid)
            token = generateJWTToken(user)
            return jsonify({'token': token})
        else:
            return jsonify({'error': 'Invalid user id'}), 401


def extractNeo4jResults(records, summary, embeddingsFlag=False, embeddings=None):
    verses = []
    surahs = []
    hadiths = []

    dummy_verses = []
    dummy_hadiths = []

    for record in records:
        if 'surahNumber' in record.keys():
            surah = Surah(record['surahName'], record['surahNumber'], record['revealedIn'])
            surahs.append(surah)

        if 'VerseID' in record.keys():
            print('here')
            verses.append(
                Verse(
                    verseID=record['VerseID'],
                    englishText=record['VerseEnglishText'],
                    arabicText=record['VerseArabicText'],
                    embeddings=record['VerseEmbeddings'],
                    surah="surah name",
                    surahNumber=0)
            )
            dummy_verses.append(record['VerseID'])

        if 'HadithID' in record.keys():
            dummy_hadiths.append(record['HadithID'])
            hadiths.append(
                Hadith(
                    hadithID=record['HadithID'],
                    hadithNo=record['HadithNo'],
                    englishText=record['HadithEnglishText'],
                    arabicText=record['HadithArabicText'],
                    source=record['HadithSource'],
                    narratedBy=record['HadithNarratedBy'],
                    embeddings=record['HadithEmbeddings']
                )
            )

    surahs = getUniqueSurahs(surahs)
    verses = getUniqueVerses(verses)
    hadiths = getUniqueHadiths(hadiths)
    groupedVerses = groupVerses(verses)
    surahs = setSurahAndVerseJson(surahs, groupedVerses)

    return createDataJSON(summary.query, summary.result_available_after, verses, hadiths, embeddingsFlag, embeddings)


@app.route("/dummy-path", methods=["GET"])
def dummyPath():
    print(request.args.get("value"))
    return jsonify({"message": "dummy-path"}), 200


@app.route("/dummy-path", methods=["POST"])
def dummyPathPOST():
    print(request.json)
    print(request.args.get("value"))
    return jsonify({"message": "dummy-path"}), 200


def concatenate_strings(strings):
    """
    Concatenate the strings in the list with commas in between.

    Args:
    strings (list of str): List of strings to concatenate.

    Returns:
    str: Concatenated string.
    """
    concatenated_string = ", ".join(strings)
    return concatenated_string

    # Example usage:
    # string_list = ["apple", "banana", "orange", "grape"]
    # result = concatenate_strings(string_list)
    # print(result)


def generate_relationship_strings(relationships):
    result = ""
    for rel in relationships:
        result += f"The relationship {rel['relationship']} starts from {rel['startLabel']} to {rel['endLabel']}.\n"
    return result


if __name__ == '__main__':
    """
        Below Commented Code is for Graph Schema Generation
        Make it into an endpoint
    """
    # query = """
    # MATCH (n)-[r]->(m)
    # WHERE NOT any(label IN labels(n) WHERE label IN ['Database', 'Message'])
    # WITH [label IN labels(n) WHERE label <> 'EXTERNAL'] AS labelList,
    #      size(keys(n)) AS num_properties,
    #      count(*) AS node_count,
    #      keys(n) AS properties,
    #      labels(n) AS startLabel,
    #      labels(m) AS endLabel,
    #      type(r) AS relationship
    # WITH apoc.coll.toSet(labelList) AS label,
    #      sum(num_properties) AS total_num_properties,
    #      sum(node_count) AS total_node_count,
    #      collect(properties) AS all_properties,
    #      apoc.coll.toSet(COLLECT({startLabel: startLabel[0], relationship: relationship, endLabel: endLabel[0]})) AS relationships
    # WITH apoc.coll.toSet([prop IN apoc.coll.flatten(all_properties) | prop]) AS unique_properties,
    #      reduce(s = "", x IN label | s + x) AS label_string,
    #      total_num_properties,
    #      total_node_count,
    #      relationships
    # WITH SIZE(unique_properties) AS TOTAL_PROPERTIES,
    #      label_string AS LABEL,
    #      total_node_count AS TOTAL_NODES,
    #      unique_properties AS PROPERTIES,
    #      relationships AS RELATIONSHIPS,
    #      size(relationships) AS TOTAL_RELATIONSHIPS
    # RETURN LABEL, TOTAL_PROPERTIES, TOTAL_NODES, PROPERTIES, RELATIONSHIPS,TOTAL_RELATIONSHIPS
    # ORDER BY TOTAL_NODES DESC
    # """
    # records, summary, keys = Neo4jConn.executeNeo4jQuery(query)
    # labels = []
    # properties = []
    # relationships = []
    #
    # for record in records:
    #     labels.append(record['LABEL'])
    #     properties.append({
    #         "label": record['LABEL'],
    #         "properties": record['PROPERTIES'],
    #         "formattedProperties": concatenate_strings(record['PROPERTIES'])
    #     })
    #     print(generate_relationship_strings(record['RELATIONSHIPS']))
    #
    # result = concatenate_strings(labels)
    # print(result)
    #
    # for v in properties:
    #     print(f'The {v.get("label")} Node has the following properties {v.get("formattedProperties")} ')
    # # prop = concatenate_strings(properties)
    # # print(relationships)

    # OntologyCon.getResults("What are the punishments of not paying Zakah")
    app.run(debug=True, port=48275, host="192.168.56.1")
