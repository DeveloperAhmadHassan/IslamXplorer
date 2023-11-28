import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';

class Verse implements SearchResultItem{
  int id;

  Verse(this.id);

  @override
  String toString() {
    return 'Verse{id: $id}';
  }
}


void main() {
  print("Something");

  var s1 = SearchResults();
  s1.addItems();
  s1.printItems();
}