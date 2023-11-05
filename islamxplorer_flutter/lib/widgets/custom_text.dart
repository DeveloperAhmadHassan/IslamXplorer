import 'package:flutter/material.dart';

class CustomText extends StatelessWidget{
  String? text;
  double fontSize;
  bool bold;
  bool underline;
  Color color;

  CustomText(String this.text, this.fontSize, {this.bold=false, this.underline=false, this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.topLeft,
      child: Text("$text", style: TextStyle(
        fontSize: fontSize,
        fontFamily: "IBMPlexMono",
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color,
        decoration: underline ? TextDecoration.underline : TextDecoration.none
      ),),
    );
  }
}