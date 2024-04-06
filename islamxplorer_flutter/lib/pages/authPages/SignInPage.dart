import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/pages/authPages/ForgetPasswordPage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignUpPage.dart';
import 'package:islamxplorer_flutter/pages/homePages/adminPage.dart';
import 'package:islamxplorer_flutter/pages/homePages/userPage.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/checkBoxWidget/rememberMeCheckBox.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/authWidgets/sign_in_providers.dart';

import '../../models/user.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin{
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstWidthAnimation;
  late Animation<double> _firstHeightAnimation;
  late Animation<double> _secondWidthAnimation;
  late Animation<double> _secondHeightAnimation;

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final AuthController _authController = AuthController();
  late String _errorText = "";

  final _formKey = GlobalKey<FormState>();

  late String _email, _password;
  void openSignUp(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
  void anonymousSignIn() async{
    AuthController authController = AuthController();
    AppUser appUser = await authController.signInAnon();

    if(appUser != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserPage(appUser: appUser,)));
    }
  }

  @override
  void initState() {
    super.initState();
    _firstController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _secondController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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

    var (email, password) = _authController.getRememberMeDetails();
    _email = email;
    _password = password;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var (email, password) = _authController.getRememberMeDetails();
    _email = email;
    _password = password;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,

            systemNavigationBarColor: Colors.black.withOpacity(0.00002),
          ),
          toolbarHeight: 50,
          title: Row(
            children: [
              const SizedBox(width: 30,),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: const Text("Log In", style: TextStyle(
                  fontSize: 25,
                )),
              )
            ],
          ),
        ),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            left: -250,
            child: AnimatedBuilder(
              animation: _firstController,
              builder: (context, child) {
                return Container(
                  width: _firstWidthAnimation.value,
                  height: _firstHeightAnimation.value,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: Theme.of(context).colorScheme.primaryContainer
                      // color: HexColor.fromHexStr(AppColor.primaryThemeSwatch3).withOpacity(0.3)
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 100,
            left: -300,
            child: AnimatedBuilder(
                animation: _secondController,
                builder: (context, child){
                  return Container(
                    width: _secondWidthAnimation.value,
                    height: _secondHeightAnimation.value,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: Theme.of(context).colorScheme.primaryContainer
                    ),
                  );
                }
            ),
          ),
          Positioned(
            top: 500,
            right: -230,
            child: AnimatedBuilder(
                animation: _firstController,
                builder: (context, child){
                  return Container(
                    width: _firstWidthAnimation.value,
                    height: _firstHeightAnimation.value,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: Theme.of(context).colorScheme.primaryContainer
                    ),
                  );
                }
            ),
          ),
          Positioned(
            top: 700,
            right: -100,
            child: AnimatedBuilder(
                animation: _secondController,
                builder: (context, child){
                  return Container(
                    width: _secondWidthAnimation.value,
                    height: _secondHeightAnimation.value,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: Theme.of(context).colorScheme.primaryContainer
                    ),
                  );
                }

            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              // color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 100,),
                      const PrimaryLogo(),
                      // CustomText(_errorText, 20, color: Colors.red, bold: true,),
                      // SizedBox(height: 20,),
                      CustomText(AppString.usernameOrEmailLabel,20, bold: true,),
                      CustomTextfield(
                        const Icon(Icons.email_outlined, color: Colors.black,),
                        AppString.emailHint,
                        value: _email,
                        false,
                        _emailEditingController,
                        validationCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email!';
                          }
                          if(!value.isEmail){
                            return 'Please enter a valid email!';
                          }
                          return null;
                        },
                        key: const Key("emailTextField"),
                      ),
                      Container(
                        height: 20,
                      ),
                      CustomText(AppString.passwordLabel,20, bold: true,),
                      CustomTextfield(
                        const Icon(Icons.lock_outline, color: Colors.black,),
                        AppString.passwordHint,
                        true,
                        _passwordEditingController,
                        value: _password,
                        validationCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password!';
                          }
                          return null;
                        },
                        key: const Key("passwordTextField"),
                      ),
                      Row(
                        children: [
                          RememberMe(authController: _authController),
                          Spacer(),
                          CustomText(
                            "Forget Password",
                            16,
                            bold: true,
                            underline: true,
                            color: Colors.blue,
                            alignment: Alignment.center,
                            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordPage()));},
                          ),
                        ],
                      ),
                      CustomButton(AppString.loginButton, () async {
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          print("Password: ${_passwordEditingController.text.trim()}");
                          try {
                            var loginResult = await _authController.login(
                              _emailEditingController.text.trim(),
                              _passwordEditingController.text.trim(),
                            );

                            if (loginResult != null) {
                              print("Login successful ${loginResult.runtimeType}");

                              if (loginResult.type == "U") {
                                print("User");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserPage()));
                              } else {
                                print("Admin");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));
                              }
                            } else {
                              print("Login failed");
                            }
                          } catch (e) {
                            print("Error: ${e.toString()}");
                            setState(() {
                              _errorText = e.toString();
                            });
                          }
                        }
                      }),
                      SignInProviders(),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(AppString.signUpLabel, 18, bold: true),
                          Container(width: 10,),
                          CustomText(
                            AppString.signUpHint,
                            18,
                            bold: true,
                            underline: true,
                            color: Colors.blue,
                            onTap: openSignUp,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      CustomText("OR", 24, alignment: Alignment.center, bold: true,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(AppString.guestHintLabel, 18, bold: true),
                          Container(width: 10,),
                          CustomText(
                            AppString.guestLabel,
                            18,
                            bold: true,
                            underline: true,
                            color: Colors.blue,
                            onTap: anonymousSignIn,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40,),
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
