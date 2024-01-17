import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/models/dua.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class HadithDataController{
  Future<List<Hadith>> fetchAllHadiths() async {
    const url = "http://192.168.56.1:48275/hadiths";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Hadith> hadiths = jsonData.map((data) => Hadith.fromJson(data)).toList();
        print("Hello3");
        return hadiths;
      }  else {
        throw Exception('Failed to load Hadiths');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> addHadith(Hadith hadith) async {
    const url = "http://192.168.56.1:48275/hadiths";
    print("Hello1");

    final Map<String, dynamic> requestBody = {
      "hadithID": hadith.id,
      "hadithNo": hadith.hadithNo,
      "englishText": hadith.englishText,
      "arabicText": hadith.arabicText,
      "source": hadith.source,
      "narratedBy": hadith.narratedBy,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Hadith added successfully");
        return true;
      } else {
        print("Failed to add Hadith. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<Hadith> getHadithByID(String id) async {
    var url = "http://192.168.56.1:48275/hadiths?id=$id";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Hadith> hadiths = jsonData.map((data) => Hadith.fromJson(data)).toList();
        print("Hello3");
        return hadiths.first;
      }  else {
        throw Exception('Failed to load Hadith');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> updateHadith(Hadith hadith, String oldID) async {
    String url = "http://192.168.56.1:48275/hadiths?id=$oldID";

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          "hadithID": hadith.id,
          "hadithNo": hadith.hadithNo,
          "englishText": hadith.englishText,
          "arabicText": hadith.arabicText,
          "source": hadith.source,
          "narratedBy": hadith.narratedBy,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Hadith updated successfully");
        return true;
      } else {
        throw Exception("Failed to update Hadith");
        return true;
      }
    } catch (e) {
      print("Error updating Hadith: $e");
      throw Exception("Error updating Hadith: $e");
      return true;
    }
  }

  Future<bool> deleteHadith(String hadithID) async {
    String url = "http://192.168.56.1:48275/hadiths?id=$hadithID";

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Hadith deleted successfully");
        return true;
      } else {
        throw Exception("Failed to delete Hadith");
        return true;
      }
    } catch (e) {
      print("Error deleting Hadith: $e");
      throw Exception("Error deleting Hadith: $e");
      return true;
    }
  }
}