import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/custom_textfield.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';

class SignInPage extends StatelessWidget{
  const SignInPage({super.key});

  onTap(String text){
    print("$text PRESSED!");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 200, 62, 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const PrimaryLogo(),
                Container(
                  height: 40,
                ),
                CustomText("Username or Email",20, bold: true,),
                CustomTextfield(const Icon(Icons.email_outlined, color: Colors.black,), "john@gmail.com", false),
                Container(
                  height: 20,
                ),
                CustomText("Password",20, bold: true,),
                CustomTextfield(const Icon(Icons.lock_outline, color: Colors.black,), "**********", true),
                Container(
                  height: 20,
                ),
                CustomButton("LOG IN", onTap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText("Don't have an account?", 18, bold: true,color: Colors.black54),
                    Container(width: 10,),
                    CustomText("Sign Up", 18, bold: true, underline: true,),
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }

}