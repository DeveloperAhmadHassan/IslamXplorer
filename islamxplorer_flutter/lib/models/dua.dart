import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class Dua implements SearchResultItem{
  String id;
  String title;
  String? arabicText;
  String englishText;
  String? transliteration;
  String? explanation;
  String? verses;
  int? surah;
  List<String>? types;
  bool isBookmarked;
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

  Dua({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.englishText,
    this.transliteration,
    required this.surah,
    this.explanation,
    this.verses,
    this.types,
    this.isBookmarked = false
  }) {
    sID = id;
    sTitle = title;
    sSubtitle = englishText;
    sIsBookmarked = isBookmarked;
    sIsReported = isReported;
    sType = runtimeType.toString();
  }

  factory Dua.fromJson(Map<String, dynamic> json) {
    return Dua(
      id: json['_id'] as String,
      title: json['title'] as String,
      englishText: json['englishText'] as String,
      arabicText: json['arabicText'] as String ?? "",
      transliteration: json['transliteration'] as String ?? "",
      verses: json['verses'],
      surah: json['surah'] as int ?? 0,
      explanation: json['explanation']
    );
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