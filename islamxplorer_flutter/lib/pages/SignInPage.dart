// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/SignUpPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/custom_textfield.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/sign_in_provider_button.dart';
import 'package:islamxplorer_flutter/widgets/sign_in_providers.dart';

class SignInPage extends StatefulWidget{
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailEditingController = TextEditingController();

  TextEditingController _passwordEditingController = TextEditingController();

  // const SignInPage({super.key});

  void login() async{
    String email = _emailEditingController.text.trim();
    String password = _passwordEditingController.text.trim();

    try{
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email, password: password);

      if(userCredential.user!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyPage()));
      }
    }on FirebaseAuthException catch(e){
      print(e.code.toString());
    }
  }

  void openSignUp(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
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
                CustomTextfield(const Icon(Icons.email_outlined, color: Colors.black,), "john@gmail.com", false, _emailEditingController),
                Container(
                  height: 20,
                ),
                CustomText("Password",20, bold: true,),
                CustomTextfield(const Icon(Icons.lock_outline, color: Colors.black,), "**********", true, _passwordEditingController),
                Container(
                  height: 20,
                ),
                CustomButton("LOG IN", login),
                SignInProviders(),
                Container(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText("Don't have an account?", 18, bold: true,color: Colors.black54),
                    Container(width: 10,),
                    CustomText("Sign Up", 18, bold: true, underline: true,onTap: openSignUp,),
                  ],
                ),

              ],
            ),
          ),
        )
      )
    );
  }
}