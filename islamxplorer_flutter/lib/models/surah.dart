import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';

class Surah implements SearchResultItem{
  int id;
  int totalVerses;

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

  Surah({
    required this.id,
    required this.totalVerses,
  }) {
    id = id;
    totalVerses=totalVerses;
  }

  @override
  void updateBookmarkStatus(bool isBookmarked) {
    return;
  }

  @override
  void updateReportStatus(bool isReported) {
    return;
  }

}