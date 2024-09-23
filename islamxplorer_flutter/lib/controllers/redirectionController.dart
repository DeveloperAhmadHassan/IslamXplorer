import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/authPages/EmailVerificationPage.dart';

class RedirectionController {
  static Future<void> redirectToPage(int code, Future<void> Function(Route) navigate, [List<dynamic>? params]) async {
    switch (code) {
      case 10:
        await navigate(MaterialPageRoute(builder: (context) => EmailVerificationPage(email: params![0].toString())));
        break;

      default:
        await navigate(MaterialPageRoute(builder: (context) => Container())); // Default case
        break;
    }
  }
}