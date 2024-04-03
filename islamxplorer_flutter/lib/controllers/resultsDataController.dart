import 'dart:convert';

import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResultsDataController{
  Future<List<SearchResultItem>> fetchAllResults() async {
    var url = "http://192.168.56.1:48275/results";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];

      final SearchResults searchResults = SearchResults.fromJson(jsonData);

      final List<SearchResultItem> results = searchResults.l1;

      return results;
    } else {
      throw Exception('Failed to load results');
    }
  }
}