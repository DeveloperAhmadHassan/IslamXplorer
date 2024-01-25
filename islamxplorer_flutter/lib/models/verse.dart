import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';

class Verse implements SearchResultItem{
  String id;
  String arabicText;
  String englishText;
  String surah;
  int? surahNumber;
  bool isBookmarked = false;
  bool isReported = false;

  @override
  late String sID;

  @override
  late String sTitle;

  @override
  late String sSubtitle;

  @override
  late bool sIsBookmarked;

  @override
  late bool sIsReported;

  @override
  late String sType;

  Verse({
    required this.id,
    required this.arabicText,
    required this.englishText,
    required this.surah,
    this.surahNumber
  }) {
    sID = id;
    sTitle = surah;
    sSubtitle = englishText;
    sIsBookmarked = isBookmarked;
    sIsReported = isReported;
    sType = runtimeType.toString();
  }


  factory Verse.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Verse(
      id: json['id'] as String,
      englishText: json['englishText'] as String,
      arabicText: json['arabicText'] as String,
      surah: json['source'] as String,
    );
  }

  (int, int) splitID() {
    List<String> parts = id.split(':');
    if (parts.length == 2) {
      int firstNumber = int.tryParse(parts[0]) ?? 0;
      int secondNumber = int.tryParse(parts[1]) ?? 0;

      return (firstNumber, secondNumber);
    } else {
      return (0, 0);
    }
  }

  @override
  void updateBookmarkStatus(bool isBookmarked) {
    this.isBookmarked = isBookmarked;
    sIsBookmarked = isBookmarked;
    print("Type: ${sType}");
  }

  @override
  void updateReportStatus(bool isReported) {
    this.isReported = isReported;
    sIsReported = isReported;
    print("Type: ${sType}");
  }
}


void main() {
  // print("Something");
  //
  // var s1 = SearchResults();
  // s1.addItems();
  // s1.printItems();
}