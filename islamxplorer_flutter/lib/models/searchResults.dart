import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/verse.dart';

class SearchResults{
  List<SearchResultItem> l1 = [];

  SearchResults();

  void addItems(){

    l1.add(Verse(1));
    l1.add(Hadith(2));
    print("Items Added!");
  }

  void printItems(){
    for (var element in l1) {
      print(element);
    }
  }
}