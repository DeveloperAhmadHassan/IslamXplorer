import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class Hadith implements SearchResultItem{
  int id;

  Hadith(this.id);

  @override
  String toString() {
    return 'Hadith{id: $id}';
  }
}