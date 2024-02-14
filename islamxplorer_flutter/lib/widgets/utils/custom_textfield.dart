import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
   bool hidePassword = false;
   IconData passwordIcon = LineAwesomeIcons.eye;
   TextInputType textInputType;
   String? value = "";

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
        this.textInputType = TextInputType.text,
        this.value,
        super.key,
      })  : tempIcon = icon,
        tempHintText = hintText,
        hidePassword = isPassword,
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
  void initState() {
    super.initState();
    widget._textEditingController?.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._textEditingController,
      obscureText: widget.hidePassword,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      cursorColor: Colors.white,
      keyboardType: widget.textInputType,
      // style: const TextStyle(
      //   fontFamily: "IBMPlexMono",
      //   fontSize: 16,
      //   fontWeight: FontWeight.bold,
      //   color: Colors.black54,
      // ),
      decoration: InputDecoration(
        hintText: "${widget.hintText}",
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
        suffixIcon: widget.hidePassword || widget.isPassword
            ? GestureDetector(
                onTap: (){
                  setState(() {
                    if(widget.hidePassword){
                      widget.hidePassword = false;
                      widget.passwordIcon = LineAwesomeIcons.eye_slash;
                    }else{
                      widget.hidePassword = true;
                      widget.passwordIcon = LineAwesomeIcons.eye;
                    }
                  });
                },
                child: Icon(widget.passwordIcon)
              )
            : null,
      ),
      validator: (value) {
        if (widget.validationCallback != null) {
          return widget.validationCallback!(value ?? '');
        }
        return null;
      },
    );
  }
}
