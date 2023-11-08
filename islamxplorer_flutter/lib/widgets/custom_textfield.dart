import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget{

  Icon? icon;
  String? hintText;
  bool isPassword=false;
  bool isEmail = false;
  bool isEmailField = true;
  bool isPhone = false;
  Icon? tempIcon;
  String? tempHintText;


  final TextEditingController? _textEditingController;

  CustomTextfield(Icon this.icon, String this.hintText, this.isPassword,this._textEditingController, {this.isEmail=false, super.key}){
    tempIcon = icon;
    tempHintText = hintText;
  }

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  // bool isEmail(String input) {
  //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   return emailRegex.hasMatch(input);
  // }

  bool isPhoneNumber(String input) {
    final phoneRegex = RegExp(r'^[0-9-+()\s]+$');
    return phoneRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {


    return TextField (
      controller: widget._textEditingController,
      obscureText: widget.isPassword,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      cursorColor: Colors.white,
      keyboardType: widget.isEmailField ? TextInputType.emailAddress : TextInputType.phone,
      style: const TextStyle(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
      decoration: InputDecoration(
          focusColor: Color.fromRGBO(255, 249, 197, 1),
          isDense: true,
          hintText: "${widget.hintText}",
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
          prefixIcon: GestureDetector(
          onTap: () {
            setState(() {

              if(widget.isEmail){
                widget.isEmailField = !widget.isEmailField; // Toggle between email and phone
                // Change the icon based on the current state
                widget.icon = widget.isEmailField ? widget.tempIcon : Icon(Icons.phone);
                widget.hintText = widget.isEmailField ? widget.tempHintText : "+92 7055570";
                widget.isPhone = !widget.isPhone;

              }
            });
          },
          child: widget.icon,
        ),
      )
    );
  }
}