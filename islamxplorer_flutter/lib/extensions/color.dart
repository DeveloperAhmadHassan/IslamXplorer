import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(int hexValue) {
    return Color(hexValue);
  }

  static Color fromHexStr(String hexString) {
    String hex = hexString.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    int hexValue = int.parse(hex, radix: 16);
    return Color(hexValue);
  }
}