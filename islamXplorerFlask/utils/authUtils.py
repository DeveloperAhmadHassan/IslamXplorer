import json
import os
from datetime import datetime, timedelta
from functools import wraps

import jwt
from flask import request, jsonify
from pyrebase import pyrebase

import firebase_admin
from firebase_admin import credentials, firestore, auth

cred = credentials.Certificate("ServiceAccountKey.json")
firebase_admin.initialize_app(cred)

with open("firebaseConfig.json", "r") as json_file:
    data = json.load(json_file)
    firebaseConfig = data

firebase = pyrebase.initialize_app(firebaseConfig)
firebaseAuth = firebase.auth()


def authenticate(email, password):
    try:
        user = firebaseAuth.sign_in_with_email_and_password(email, password)
        return user
    except firebase_admin.auth.UserNotFoundError as e:
        return None
    except firebase_admin.auth.EmailNotFoundError as e:
        return None


def authenticateById(access_token):
    try:
        decoded_token = auth.verify_id_token(access_token)
        user = auth.get_user(decoded_token['uid'])
        return user
    except auth.InvalidIdTokenError:
        return None


def getUserRecord(userID):
    try:
        db = firestore.client()
        userRef = db.collection('Users').document(userID)
        userData = userRef.get().to_dict()
        return userData
    except firebase_admin.auth.UserNotFoundError as e:
        return None


def generateJWTToken(user):
    payload = {
        'email': user['email'],
        'role': user['type'],
        'exp': datetime.utcnow() + timedelta(minutes=2)
    }
    token = jwt.encode(payload, os.getenv("AUTH_SECRET_KEY"), algorithm='HS256')
    return token


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
                payload = jwt.decode(token, os.getenv("AUTH_SECRET_KEY"), algorithms=['HS256'])
                print(payload)
            except jwt.ExpiredSignatureError:
                return jsonify({'error': 'Token has expired'}), 401
            except jwt.InvalidTokenError:
                return jsonify({'error': 'Invalid token'}), 401

            userRole = payload.get('role')

            if userRole == 'A':
                return func(*args, **kwargs)
            elif userRole == 'S':
                if role in ['U', 'S']:
                    return func(*args, **kwargs)
            elif userRole == 'U':
                if role == 'U':
                    return func(*args, **kwargs)

            return jsonify({'error': 'Unauthorized access'}), 403

        return wrapper

    return decorator
