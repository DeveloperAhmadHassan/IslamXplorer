import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/Controllers/authController.dart';
import 'package:islamxplorer_flutter/Controllers/redirectionController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/authPages/EmailVerificationPage.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/authWidgets/sign_in_providers.dart';

import '../../widgets/utils/custom_button.dart';
import '../../widgets/utils/custom_text.dart';
import '../../widgets/utils/custom_textfield.dart';
import '../../widgets/logoWidgets/primary_logo.dart';

class SignUpPage extends StatefulWidget{

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _usernameEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthController authController = AuthController();


  void openSignIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const PrimaryLogo(),
                      Container(
                        height: 20,
                      ),
                      // CustomText("Assalamualaikum", 30, color: HexColor.fromHexStr(AppColor.primaryThemeSwatch3)),
                      // SizedBox(height: 20,),
                      CustomText("Email or Phone",20, bold: true,),
                      CustomTextfield(const Icon(Icons.email_outlined, color: Colors.black,), "john@gmail.com", false, isEmail: true,_emailEditingController),
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
                      CustomButton(AppString.signUpButton, () async {
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          try {
                            var signUpResult = await authController.createAccount(
                              _emailEditingController.text.trim(),
                              _usernameEditingController.text.trim(),
                              _passwordEditingController.text.trim(),
                            );

                            if (signUpResult) {
                              print("Sign Up Done ${signUpResult.runtimeType}");

                              List<String> params = [_emailEditingController.text.trim()];

                              await RedirectionController.redirectToPage(10, (route) async {
                                await Navigator.push(context, route);
                              }, params);

                            } else {
                              print("Sign Up failed");
                            }
                          } catch (e) {
                            print("Error: ${e.toString()}");
                            setState(() {
                              // _errorText = e.toString();
                            });
                          }
                        }
                      }),
                      SignInProviders(),
                      SizedBox(height: 10,),
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
              ),
            )
        )
    );
  }
}