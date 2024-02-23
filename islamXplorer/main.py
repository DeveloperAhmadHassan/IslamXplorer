from dotenv import load_dotenv
import os
import json

from flask import Flask, redirect, url_for, request, Response, jsonify

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
from controllers.surah_con import SurahCon
from controllers.topic_con import TopicCon

from flask_cors import CORS

from functools import wraps
import jwt
from datetime import datetime, timedelta

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes
load_dotenv()

app.config['SECRET_KEY'] = 'your_secret_key_here'  # Change this to a secure secret key

# Mock user database
users = {
    'admin': {'username': 'admin', 'password': 'admin', 'role': 'admin'},
    'scholar': {'username': 'scholar', 'password': 'scholar', 'role': 'scholar'},
    'user1': {'username': 'user1', 'password': 'user1', 'role': 'user'},
    'user2': {'username': 'user2', 'password': 'user2', 'role': 'user'}
}


# Function to authenticate and authorize the user
def authenticate(username, password):
    if username in users and users[username]['password'] == password:
        return users[username]
    return None


# Function to generate JWT token upon successful authentication
def generate_jwt_token(user):
    payload = {
        'username': user['username'],
        'role': user['role'],
        'exp': datetime.utcnow() + timedelta(minutes=2)
    }
    token = jwt.encode(payload, "your_secret_key_here", algorithm='HS256')
    return token


# Decorator to check user role
def role_required(role):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            token = request.headers.get('Authorization')
            token = str.replace(str(token), 'Bearer ', '')
            print(token)
            if not token:
                return jsonify({'error': 'Token is missing'}), 401

            try:
                payload = jwt.decode(token, "your_secret_key_here", algorithms=['HS256'])
                print(payload)
            except jwt.ExpiredSignatureError:
                return jsonify({'error': 'Token has expired'}), 401
            except jwt.InvalidTokenError:
                # print("payload: " +str(payload))
                return jsonify({'error': 'Invalid token'}), 401

            user_role = payload.get('role')

            if user_role == 'admin':
                # Allow access for admin to all routes
                return func(*args, **kwargs)
            elif user_role == 'scholar':
                # Allow access for scholar to user and scholar routes
                if role in ['user', 'scholar']:
                    return func(*args, **kwargs)
            elif user_role == 'user':
                # Allow access for user to user routes only
                if role == 'user':
                    return func(*args, **kwargs)

            return jsonify({'error': 'Unauthorized access'}), 403

        return wrapper

    return decorator


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
    # surahID = request.args.get('id')
    # duaType = request.args.get('type')

    jsonData = TopicCon.getAllTypes()
    return Response(jsonData, mimetype="text/json"), 200


@app.route('/concepts', methods=["GET"])
def getConcepts():
    # surahID = request.args.get('id')
    typeID = request.args.get('type')

    print(typeID)

    jsonData = TopicCon.getAllConceptsByType(typeID)
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
    # queryResults.headers.add('Access-Control-Allow-Origin', '*')
    # queryResults.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    # queryResults.headers.add('Access-Control-Allow-Headers', 'Content-Type')
    # queryResults.headers.add('Access-Control-Allow-Credentials', 'true')

    return Response(queryResults, mimetype="text/json"), 200


# @app.route('/login', methods=['POST', 'GET'])
# def login():
#     if request.method == 'POST':
#         user = request.form['nm']
#         return redirect(url_for('success', name=user))
#     else:
#         user = request.args.get('nm')
#         return redirect(url_for('success', name=user))


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
