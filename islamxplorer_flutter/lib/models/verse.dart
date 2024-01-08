import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';

class Verse implements SearchResultItem{
  String id;
  String arabicText;
  String englishText;
  String surah;
  int? surahNumber;

  @override
  late String s_id;

  @override
  late String s_title;

  @override
  late String s_subtitle;

  Verse({
    required this.id,
    required this.arabicText,
    required this.englishText,
    required this.surah,
    this.surahNumber
  }) {
    s_id = id;
    s_title = surah;
    s_subtitle = englishText;
  }


  factory Verse.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Verse(
      id: json['verseID'] as String,
      englishText: json['englishText'] as String,
      arabicText: json['arabicText'] as String,
      surah: json['surahName'] as String,
    );
  }

}


void main() {
  // print("Something");
  //
  // var s1 = SearchResults();
  // s1.addItems();
  // s1.printItems();
}