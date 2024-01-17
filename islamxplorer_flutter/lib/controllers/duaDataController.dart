import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/Controllers/userDataController.dart';
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

  Future<Dua> getDuaByID(String id) async {
    var url = "http://192.168.56.1:48275/duas?id=$id";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Dua> duas = jsonData.map((data) => Dua.fromJson(data)).toList();
        print("Hello3");

        duas.first.isBookmarked  = await setBookmark(duas.first.id);
        duas.first.isReported = await setReport(duas.first.id);

        return duas.first;
      }  else {
        throw Exception('Failed to load Dua');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> updateDua(Dua dua, String oldID) async {
    String url = "http://192.168.56.1:48275/duas?id=$oldID";

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          "duaID": dua.id,
          "englishText": dua.englishText,
          "arabicText": dua.arabicText,
          "title": dua.title,
          "explanation": dua.explanation,
          "transliteration": dua.transliteration,
          "surah": dua.surah,
          "verses": dua.verses,
          "types": dua.types,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Dua updated successfully");
        return true;
      } else {
        throw Exception("Failed to update Dua");
        return true;
      }
    } catch (e) {
      print("Error updating Dua: $e");
      throw Exception("Error updating Dua: $e");
      return true;
    }
  }

  Future<bool> deleteDua(String duaID) async {
    String url = "http://192.168.56.1:48275/duas?id=$duaID";

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Dua deleted successfully");
        return true;
      } else {
        throw Exception("Failed to delete Dua");
        return true;
      }
    } catch (e) {
      print("Error deleting Dua: $e");
      throw Exception("Error deleting Dua: $e");
      return true;
    }
  }

  Future<bool> setBookmark(String id) async{
    UserDataController userDataController = UserDataController();
    if(await userDataController.isBookmarked(id)){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setReport(String id) async{
    UserDataController userDataController = UserDataController();
    if(await userDataController.isReported(id)){
      return true;
    } else {
      return false;
    }
  }
}