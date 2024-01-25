import 'dart:convert';

import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:http/http.dart' as http;

class HadithDataController{
  Future<List<Hadith>> fetchAllHadiths() async {
    const url = "http://192.168.56.1:48275/hadiths";
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        final List<Hadith> hadiths = jsonData.map((data) => Hadith.fromJson(data)).toList();
        return hadiths;
      }  else {
        throw Exception('Failed to load Hadith');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> addHadith(Hadith hadith) async {
    const url = "http://192.168.56.1:48275/hadiths";
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
        return true;
      } else {
        // print("Failed to add Hadith. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // print("Error: $e");
      return false;
    }
  }

  Future<Hadith> getHadithByID(String id) async {
    var url = "http://192.168.56.1:48275/hadiths?id=$id";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];

        final List<Hadith> hadiths = jsonData.map((data) => Hadith.fromJson(data)).toList();

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
        // print("Hadith updated successfully");
        return true;
      } else {
        throw Exception("Failed to update Hadith");
      }
    } catch (e) {
      // print("Error updating Hadith: $e");
      throw Exception("Error updating Hadith: $e");
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
        // print("Hadith deleted successfully");
        return true;
      } else {
        throw Exception("Failed to delete Hadith");
      }
    } catch (e) {
      // print("Error deleting Hadith: $e");
      throw Exception("Error deleting Hadith: $e");
    }
  }
}