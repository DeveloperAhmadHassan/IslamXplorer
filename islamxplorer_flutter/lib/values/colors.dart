import 'package:flutter/widgets.dart';
class AppColor {
  AppColor._();
  static const Color blueColor = Color(0xFF2F39C5);
  static const String primaryThemeSwatch1 = "#FDD995";
  static const String primaryThemeSwatch2 = "#FCC47F";
  static const String primaryThemeSwatch3 = "#F8853E";
  static const String primaryThemeSwatch4 = "#FEEEAB";

  static const String secondaryThemeSwatch1 = "#BDD1C5";
  static const String secondaryThemeSwatch2 = "#B8D8E3";
  static const String secondaryThemeSwatch3 = "#535878";
  static const String secondaryThemeSwatch4 = "#1a1f3b";
  static const Gradient primaryLinearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );
  static const Gradient secondaryLinearGradientSwatch1 = LinearGradient(
    begin: Alignment(0.0, 2.3),
    end: Alignment(0.3, -0.707),
    colors: [
      Color(0xffd1dff5),
      Color(0xff618dee),
    ],
  );
  static const Gradient secondaryLinearGradientSwatch2 = LinearGradient(
    begin: Alignment(0.0, 2.3),
    end: Alignment(0.3, -0.707),
    colors: [
      Color(0xfff7f3ff),
      Color(0xffc997ff),
    ],
  );
}