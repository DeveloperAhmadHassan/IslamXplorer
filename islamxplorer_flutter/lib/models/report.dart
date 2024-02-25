class Report{
  String rid;
  ItemType reportItemType;
  String? reportMessage;
  DateTime reportTime;
  String uid;
  Report({
    required this.rid,
    required this.reportItemType,
    this.reportMessage,
    required this.reportTime,
    required this.uid
  });
}

enum ItemType{
  dua,
  verse,
  hadith,
}