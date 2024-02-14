import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/themes/text_field_theme.dart';
import 'package:islamxplorer_flutter/values/themes/text_theme.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
    scaffoldBackgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
    textTheme: AppTextTheme.lightTextTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecoration,
    appBarTheme: AppBarTheme(
        color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1)
    ),
    cardTheme: CardTheme(
      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.red,
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      primaryContainer: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3),
      secondaryContainer: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
      error: Colors.red,
      onError: Colors.white,
      background: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      onBackground: Colors.white,
      surface: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3),
      onSurface: Colors.white,
    ),
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      primaryColor: HexColor.fromHexStr(AppColor.secondaryThemeSwatch4),
      scaffoldBackgroundColor: HexColor.fromHexStr(AppColor.secondaryThemeSwatch4),
      canvasColor: Colors.black,
      cardColor: Colors.white,
      textTheme: AppTextTheme.darkTextTheme,
      appBarTheme: AppBarTheme(
        color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch4)
      ),
      cardTheme: CardTheme(
        color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3)
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.blue,
        onPrimary: Colors.white,
        secondary: Colors.green,
        onSecondary: Colors.white,
        primaryContainer: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3).withOpacity(0.3),
        secondaryContainer: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3),
        error: Colors.red,
        onError: Colors.white,
        background: HexColor.fromHexStr(AppColor.secondaryThemeSwatch4),
        onBackground: Colors.white,
        surface: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3),
        onSurface: Colors.white,
      ),
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecoration,
      bottomAppBarTheme: BottomAppBarTheme(color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch4))
  );
}