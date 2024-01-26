import 'dart:io';

import 'package:flutter/services.dart';

class DataLoader{
  static Future<String> loadTermsAndConditions() async {
    try {
      return await rootBundle.loadString('assets/res/terms_and_conditions.md');
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}

main(){
  print("Started!");
  // DataLoader.loadTermsAndConditions();
  print("Finished!");
}