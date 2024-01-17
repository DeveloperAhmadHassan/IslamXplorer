abstract class SearchResultItem{
  late String sID;
  late String sTitle;
  late String sSubtitle;

  late bool sIsBookmarked;
  late bool sIsReported;

  late String sType;

  void updateBookmarkStatus(bool isBookmarked);
  void updateReportStatus(bool isReported);
}