import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/EmailVerificationPage.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/SignInPage.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_logo.dart';

class SignUpPage extends StatefulWidget{

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _usernameEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();
  TextEditingController _confirmPasswordEditingController = new TextEditingController();

  Future<void> createAccount() async {
    String email = _emailEditingController.text.trim();
    String username = _usernameEditingController.text.trim();
    String password = _passwordEditingController.text.trim();
    String confirmPassword = _confirmPasswordEditingController.text.trim();

    print("Email: $email\nPassword: $password");

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await addInitialUserDetails(email, username, user.uid);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailVerificationScreen()));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addInitialUserDetails(String email, String username, String? uid) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection('Users').doc(uid).set({
        "id":uid,
        "email": email,
        "username": username,
      });
      print('User details added to Firestore');
    } catch (e) {
      print('Error adding user details: $e');
    }
  }


  void openSignIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
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
                    CustomText("Welcome", 48, color: Colors.deepOrange,),
                    CustomText("Email or Phone",20, bold: true,),
                    CustomTextfield(const Icon(Icons.email_outlined, color: Colors.black,), "john@gmail.com", false, _emailEditingController),
                    Container(
                      height: 20,
                    ),
                    CustomText("Username",20, bold: true,),
                    CustomTextfield(const Icon(Icons.person_outline, color: Colors.black,), "john123", false, _usernameEditingController),
                    Container(
                      height: 20,
                    ),
                    CustomText("Password",20, bold: true,),
                    CustomTextfield(const Icon(Icons.lock_outline, color: Colors.black,), "**********", true, _passwordEditingController),
                    Container(
                      height: 20,
                    ),
                    CustomText("Confirm Password",20, bold: true,),
                    CustomTextfield(const Icon(Icons.lock_outline, color: Colors.black,), "**********", true, _confirmPasswordEditingController),
                    Container(
                      height: 20,
                    ),
                CustomButton("SIGN UP", createAccount),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText("Already have an account?", 18, bold: true,color: Colors.black54),
                        Container(width: 10,),
                        CustomText("Login", 18, bold: true, underline: true,onTap: openSignIn,),
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