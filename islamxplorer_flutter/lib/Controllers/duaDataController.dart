import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/models/dua.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class DuaDataController{
  Future<List<Dua>> fetchAllDuas() async {
    const url = "http://192.168.56.1:48275/duas";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Dua> duas = jsonData.map((data) => Dua.fromJson(data)).toList();
        print("Hello3");
        return duas;
      }  else {
        throw Exception('Failed to load Duas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<DuaType>> fetchAllDuaTypes() async {
    const url = "http://192.168.56.1:48275/getAllDuaTypes";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<DuaType> duaTypes = jsonData.map((data) => DuaType.fromJson(data)).toList();
        print("Hello3");
        return duaTypes;
      }  else {
        throw Exception('Failed to load Duas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Dua>> fetchDuasFromTypes(String type) async {
    var url = "http://192.168.56.1:48275/duas?type=$type";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Dua> duas = jsonData.map((data) => Dua.fromJson(data)).toList();
        print("Hello3");
        return duas;
      }  else {
        throw Exception('Failed to load Duas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> addDua(Dua dua) async {
    const url = "http://192.168.56.1:48275/duas";
    print("Hello1");

    final Map<String, dynamic> requestBody = {
      "duaID": dua.id,
      "englishText": dua.englishText,
      "arabicText": dua.arabicText,
      "title": dua.title,
      "explanation": dua.explanation,
      "transliteration": dua.transliteration,
      "surah": dua.surah,
      "verses": dua.verses,
      "types": dua.types,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        print("Dua added successfully");
        return true;
      } else {
        print("Failed to add Dua. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // Future<AppUser> getUserData() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   String? userId = user?.uid;
  //   AppUser appUser = AppUser();
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     CollectionReference users = firestore.collection('Users');
  //
  //     // Get user document by ID
  //     DocumentSnapshot userDoc = await users.doc(userId).get();
  //
  //     if (userDoc.exists) {
  //       // Access user data
  //       Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
  //
  //       // Print or use user data
  //       print('User ID: $userId');
  //       print('Email: ${userData['email']}');
  //       print('Username: ${userData['userName']}');
  //
  //       appUser = AppUser(uid: userId,
  //           userName: userData['userName'],
  //           email: userData['email'],
  //           birthdate: userData['birthdate'],
  //           phone: userData['phone'],
  //           gender: userData['gender']);
  //
  //       return appUser;
  //
  //       // Access other fields as needed
  //     } else {
  //       print('User with ID $userId does not exist in Firestore.');
  //       return appUser;
  //     }
  //   } catch (e) {
  //     print('Error fetching user data from Firestore: $e');
  //     return appUser;
  //   }
  // }
}