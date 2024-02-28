import os
from datetime import datetime, timedelta
from functools import wraps

import jwt
from flask import app, request, jsonify

users = {
    'admin': {'username': 'admin', 'password': 'admin', 'role': 'admin'},
    'scholar': {'username': 'scholar', 'password': 'scholar', 'role': 'scholar'},
    'user1': {'username': 'user1', 'password': 'user1', 'role': 'user'},
    'user2': {'username': 'user2', 'password': 'user2', 'role': 'user'}
}


def authenticate(username, password):
    if username in users and users[username]['password'] == password:
        return users[username]
    return None


def generate_jwt_token(user):
    payload = {
        'username': user['username'],
        'role': user['role'],
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
