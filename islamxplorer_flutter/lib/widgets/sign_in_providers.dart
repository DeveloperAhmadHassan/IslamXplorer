import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/sign_in_provider_button.dart';

class SignInProviders extends StatelessWidget{

  void signInWithGoogle(BuildContext context) async {
    try{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    print("$googleUser!");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if(userCredential.user!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyPage()));
        }
      }on FirebaseAuthException catch(e){
        print(e.code.toString());
      }
    } on FirebaseAuthException catch(e){
      print(e.toString());
      rethrow;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText("Or Continue With", 20, bold:true, alignment: Alignment.center,),
        Container(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInProviderButton("assets/google.png", onTap: signInWithGoogle,context: context,),
            SignInProviderButton("assets/facebook.png", context: context,),
            SignInProviderButton("assets/github.png", context: context,),
          ],
        )
      ],
    );
  }

}