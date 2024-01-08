import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/verse.dart';

class SearchResults{
  List<SearchResultItem> l1 = [];

  SearchResults();

  factory SearchResults.fromJson(List<dynamic> jsonList) {
    final searchResults = SearchResults();

    for (final jsonItem in jsonList) {
      final type = jsonItem['type'] as String?;

      if (type == null) {
        // Handle missing or invalid type
        continue;
      }

      switch (type) {
        case 'hadith':
          searchResults.l1.add(Hadith.fromJson(jsonItem));
          break;
        case 'verse':
          searchResults.l1.add(Verse.fromJson(jsonItem));
          break;
        // case 'Dua':
        //   searchResults.l1.add(Dua.fromJson(jsonItem));
        //   break;
        default:
        // Handle unknown type or throw an exception
          throw Exception('Unsupported SearchResultItem type: $type');
      }
    }

    return searchResults;
  }

}