import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islamxplorer_flutter/models/verse.dart';

class VerseDataController{
  Future<List<Verse>> fetchAllVerses() async {
    const url = "http://192.168.56.1:48275/verses";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Verse> verses = jsonData.map((data) => Verse.fromJson(data)).toList();
        print("Hello3");
        return verses;
      }  else {
        throw Exception('Failed to load Hadiths');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> addVerse(Verse verse) async {
    const url = "http://192.168.56.1:48275/verses";
    print("Hello1");

    final Map<String, dynamic> requestBody = {
      "verseID": verse.id,
      "englishText": verse.englishText,
      "arabicText": verse.arabicText,
      "surah":verse.surah,
      "surahNumber":verse.surahNumber
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Verse added successfully");
        return true;
      } else {
        print("Failed to add Verse. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<Verse> getVerseByID(String id) async {
    var url = "http://192.168.56.1:48275/verses?id=$id";
    print("Hello1");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final List<Verse> verses = jsonData.map((data) => Verse.fromJson(data)).toList();
        print("Hello3");
        return verses.first;
      }  else {
        throw Exception('Failed to load Verse');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> updateVerse(Verse verse, String oldID) async {
    String url = "http://192.168.56.1:48275/verses?id=$oldID";

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          "verseID": verse.id,
          "englishText": verse.englishText,
          "arabicText": verse.arabicText,
          "surah": verse.surah,
          "surahNumber": verse.surahNumber,
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

  Future<bool> deleteVerse(String verseID) async {
    String url = "http://192.168.56.1:48275/verses?id=$verseID";

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Verse deleted successfully");
        return true;
      } else {
        throw Exception("Failed to delete Verse");
        return true;
      }
    } catch (e) {
      print("Error deleting Verse: $e");
      throw Exception("Error deleting Verse: $e");
      return true;
    }
  }
}