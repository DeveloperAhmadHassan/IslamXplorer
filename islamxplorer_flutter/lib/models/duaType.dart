import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class DuaType{
  String id;
  String name;
  String url;
  int height;


  DuaType({
    required this.id,
    required this.name,
    required this.url,
    required this.height,
  });

  DuaType.withName({required String name})
      : id = '',
        name = name,
        url = '',
        height = 0;

  factory DuaType.fromJson(Map<String, dynamic> json) {
    return DuaType(
      id: json['_id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      height: json['height'] as int,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.name;
  }
}