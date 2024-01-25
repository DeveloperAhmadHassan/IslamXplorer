import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/controllers/redirectionController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/authWidgets/sign_in_providers.dart';
import 'package:islamxplorer_flutter/widgets/checkBoxWidget/termsAndConditionsCheckBox.dart';

import '../../widgets/utils/custom_button.dart';
import '../../widgets/utils/custom_text.dart';
import '../../widgets/utils/custom_textfield.dart';
import '../../widgets/logoWidgets/primary_logo.dart';

class SignUpPage extends StatefulWidget{

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin{
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstWidthAnimation;
  late Animation<double> _firstHeightAnimation;
  late Animation<double> _secondWidthAnimation;
  late Animation<double> _secondHeightAnimation;

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _usernameEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthController authController = AuthController();

  bool isTermsAccepted = false;

  void openSignIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
  }

  @override
  void initState() {
    super.initState();
    _firstController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _secondController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _firstWidthAnimation = Tween<double>(begin: 0, end: 400).animate(_firstController);
    _firstHeightAnimation = Tween<double>(begin: 0, end: 400).animate(_firstController);

    _secondWidthAnimation = Tween<double>(begin: 0, end: 400).animate(_secondController);
    _secondHeightAnimation = Tween<double>(begin: 0, end: 400).animate(_secondController);

    _firstController.forward();

    Future.delayed(const Duration(milliseconds: 100), () {
      _secondController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      // appBar: AppBar(
      //   backgroundColor: Colors.red.withOpacity(0.002),
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //     systemNavigationBarColor: Colors.black.withOpacity(0.00002),
      //   ),
      //   toolbarHeight: 50,
      //   elevation: 0.0,
      //   shadowColor: Colors.transparent,
      //   title: Row(
      //     children: [
      //       const SizedBox(width: 30,),
      //       Container(
      //         margin: EdgeInsets.only(top: 25),
      //         child: const Text("Sign Up", style: TextStyle(
      //           fontSize: 25,
      //         )),
      //       )
      //     ],
      //   ),
      // ),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: AnimatedBuilder(
              animation: _firstController,
              builder: (context, child) {
                return Container(
                  width: _firstWidthAnimation.value,
                  height: _firstHeightAnimation.value,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3)
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 730,
            left: -100,
            child: AnimatedBuilder(
                animation: _secondController,
                builder: (context, child){
                  return Container(
                    width: _secondWidthAnimation.value,
                    height: _secondHeightAnimation.value,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3)
                    ),
                  );
                }

            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              // color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30,),
                      const PrimaryLogo(),
                      Container(
                        height: 20,
                      ),
                      // CustomText("Assalamualaikum", 30, color: HexColor.fromHexStr(AppColor.primaryThemeSwatch3)),
                      // SizedBox(height: 20,),
                      CustomText("Email or Phone",20, bold: true,),
                      CustomTextfield(
                          const Icon(Icons.email_outlined, color: Colors.black,),
                          "john@gmail.com",
                          false,
                          isEmail: true,
                          _emailEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email OR Contact';
                            }
                            if(!value.isEmail){
                              return 'Please enter a valid Email!';
                            }

                            return null;
                          },
                          key: const Key("emailTextField")
                      ),
                      Container(
                        height: 20,
                      ),
                      CustomText("Username",20, bold: true,),
                      CustomTextfield(
                        const Icon(Icons.person_outline, color: Colors.black,),
                        "john123",
                        false,
                        _usernameEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Username';
                            }

                            return null;
                          },
                          key: const Key("userNameTextField")
                      ),
                      Container(
                        height: 20,
                      ),
                      CustomText("Password",20, bold: true,),
                      CustomTextfield(
                        const Icon(Icons.lock_outline, color: Colors.black,),
                        "**********",
                        true,
                        _passwordEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          key: const Key("passwordTextField")
                      ),
                      Container(
                        height: 20,
                      ),
                      CustomText("Confirm Password",20, bold: true,),
                      CustomTextfield(
                        const Icon(Icons.lock_outline, color: Colors.black,),
                        "**********",
                        true,
                        _confirmPasswordEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Confirm Password';
                            }
                            if(value.trim() != _passwordEditingController.text.trim()){
                              return 'Passwords Do Not Match';
                            }
                            return null;
                          },
                          key: const Key("confirmPasswordTextField")
                      ),
                      TermsAndConditions(
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value;
                          });
                        }
                      ),
                      Container(
                        height: 20,
                      ),
                      CustomButton(
                        AppString.signUpButton,
                        () async {
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
                        },
                        isEnabled: isTermsAccepted,
                      ),
                      SignInProviders(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText("Already have an account?", 18, bold: true,color: Colors.black54),
                          Container(width: 10,),
                          CustomText(
                            "Log In",
                            18,
                            bold: true,
                            underline: true,
                            color: Colors.blue,
                            onTap: openSignIn,
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}