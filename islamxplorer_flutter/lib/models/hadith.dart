import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class Hadith implements SearchResultItem{
  String id;
  String arabicText;
  String englishText;
  String? narratedBy;
  String source;
  int hadithNo;
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

  Hadith({
    required this.id,
    required this.arabicText,
    required this.englishText,
    required this.source,
    this.narratedBy,
    required this.hadithNo
  }) {
    sID = id;
    sTitle = source;
    sSubtitle = englishText;
    sIsBookmarked = isBookmarked;
    sIsReported = isReported;
    sType = runtimeType.toString();
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