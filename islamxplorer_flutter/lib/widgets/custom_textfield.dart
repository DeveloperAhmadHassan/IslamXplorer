import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class CustomTextfield extends StatefulWidget {
  Icon? icon;
   String? hintText;
   bool isPassword;
   bool isEmail;
   bool isEmailField;
   bool isPhone;
   Icon? tempIcon;
   String? tempHintText;
   Function()? onTap;
   TextEditingController? _textEditingController;
  Function(String)? validationCallback;

  CustomTextfield(
      Icon this.icon,
      String this.hintText,
      this.isPassword,
      this._textEditingController, {
        this.isEmail = false,
        this.onTap,
        this.isEmailField = true,
        this.isPhone = false,
        this.validationCallback,
        super.key,
      })  : tempIcon = icon,
        tempHintText = hintText,
        super();

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isPhoneNumber(String input) {
    final phoneRegex = RegExp(r'^[0-9-+()\s]+$');
    return phoneRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onTap: widget.onTap != null ? () => widget.onTap!() : null,
      controller: widget._textEditingController,
      obscureText: widget.isPassword,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      cursorColor: Colors.white,
      keyboardType:
      widget.isEmailField ? TextInputType.emailAddress : TextInputType.phone,
      style: const TextStyle(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        focusColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        isDense: true,
        hintText: "${widget.hintText}",
        filled: true,
        fillColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: const BorderSide(
        //     color: Colors.amberAccent,
        //   ),
        // ),
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
        prefixIcon: GestureDetector(
          onTap: () {
            setState(() {
              if (widget.isEmail) {
                widget.isEmailField = !widget.isEmailField;
                widget.icon = widget.isEmailField ? widget.tempIcon : Icon(Icons.phone);
                widget.hintText =
                widget.isEmailField ? widget.tempHintText : "+92 7055570";
                widget.isPhone = !widget.isPhone;
              }
            });
          },
          child: widget.icon,
        ),

      ),
      onChanged: (input) {
        // Call validation callback with the current input value
        if (widget.validationCallback != null) {
          widget.validationCallback!(input);
        }
      },
    );
  }
}
