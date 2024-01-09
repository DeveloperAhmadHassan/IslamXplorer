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
  bool isBookmarked = false;
  // String? explanation;

  @override
  late String s_id;

  @override
  late String s_title;

  @override
  late String s_subtitle;

  Dua({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.englishText,
    this.transliteration,
    required this.surah,
    this.explanation,
    this.verses,
    this.types
  }) {
    s_id = id; // Set title based on source
    s_title = title;
    s_subtitle = englishText;// Set subtitle based on englishText
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
}