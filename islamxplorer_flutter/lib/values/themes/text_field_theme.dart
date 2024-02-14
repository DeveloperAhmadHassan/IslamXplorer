import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class AppTextFormFieldTheme{
  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    focusColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
    isDense: true,
    filled: true,
    fillColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
    hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.3)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
  );
  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
    focusColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
    isDense: true,
    filled: true,
    fillColor: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3),
    labelStyle: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70
    ),
    hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.3)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
  );
}