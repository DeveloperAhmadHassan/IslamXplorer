import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CustomText extends StatelessWidget{
  String? text;
  double fontSize;
  bool bold;
  bool underline;
  Color? color;
  Alignment alignment;

  final VoidCallback? onTap;

  CustomText(
      String this.text,
      this.fontSize,
      {
        this.bold=false,
        this.underline=false,
        this.color,
        this.alignment = Alignment.topLeft,
        this.onTap,
        super.key
      }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 35,
        ),
        alignment: alignment,
        child: Text("$text",
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: "IBMPlexMono",
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            decoration: underline ? TextDecoration.underline : TextDecoration.none
          ),
        ),
      ),
    );
  }
}