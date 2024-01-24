import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignUpPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/checkBoxWidget/rememberMeCheckBox.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/authWidgets/sign_in_providers.dart';

class SignInPage extends StatefulWidget{
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final AuthController _authController = AuthController();
  late String _errorText = "";

  final _formKey = GlobalKey<FormState>();

  late String _email, _password;
  void openSignUp(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
  }

  @override
  void initState() {
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
        appBar: AppBar(
          backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
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
                    height: 40,
                  ),
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
                        onTap: (){},
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
                  Container(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(AppString.signUpLabel, 18, bold: true,color: Colors.black54),
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
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}
