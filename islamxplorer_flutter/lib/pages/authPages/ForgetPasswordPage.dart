import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';

class ForgetPasswordPage extends StatefulWidget{
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Forget Password"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150,),
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/man_reciting_quran.png'),
            ),
            const SizedBox(height: 20,),
            CustomText("Don't worry, everyone forgets sometimes", 16, alignment: Alignment.center),
            CustomText("We've got you covered", 16, alignment: Alignment.center),
            const SizedBox(height: 40,),
            CustomText("Enter your Email", 20, alignment: Alignment.center, bold: true,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: CustomTextfield(
                  const Icon(Icons.email_outlined, color: Colors.black,),
                  AppString.emailHint,
                  false,
                  _emailTextEditingController,
                  validationCallback: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an Email!';
                    }
                    if (!value.isEmail) {
                      return 'Please enter a valid Email!';
                    }
                    return null;
                  },
                  key: const Key("emailTextField"),
                ),
              ),
            ),
            CustomButton("Reset Password", () async {
              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                // print("Password: ${_passwordEditingController.text.trim()}");
                _authController.resetPassword(_emailTextEditingController.text.trim());
              }
            })
          ],
        ),
      ),
    );
  }
}