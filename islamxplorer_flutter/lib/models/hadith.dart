import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class Hadith implements SearchResultItem{
  String id;
  String arabicText;
  String englishText;
  String? narratedBy;
  String source;
  int hadithNo;

  @override
  late String s_id;

  @override
  late String s_title;

  @override
  late String s_subtitle;

  Hadith({
    required this.id,
    required this.arabicText,
    required this.englishText,
    required this.source,
    this.narratedBy,
    required this.hadithNo
  }) {
    s_id = id;
    s_title = source;
    s_subtitle = englishText;
  }

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['hadithID'] as String,
      englishText: json['englishText'] as String,
      arabicText: json['arabicText'] as String,
      source: json['source'] as String,
      narratedBy: json['narratedBy'] ?? "",
      hadithNo: json['hadithNo']
    );
  }

}