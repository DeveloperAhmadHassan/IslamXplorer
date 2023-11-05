import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{

  Icon? icon;
  String? hintText;
  bool isPassword=false;

  CustomTextfield(Icon this.icon, String this.hintText, this.isPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField (
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      cursorColor: Colors.white,
      keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
      style: const TextStyle(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
      decoration: InputDecoration(
          focusColor: Color.fromRGBO(255, 249, 197, 1),
          isDense: true,
          hintText: "$hintText",
          filled: true,
          fillColor: Colors.amberAccent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.amberAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Colors.amberAccent
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.amberAccent,
              width: 3,
            ),
          ),
          prefixIcon: icon
      ),
    );
  }

}