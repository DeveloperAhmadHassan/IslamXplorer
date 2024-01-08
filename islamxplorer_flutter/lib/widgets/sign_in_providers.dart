import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/sign_in_provider_button.dart';

class SignInProviders extends StatelessWidget{

  Future<void> addInitialUserDetails(String email, String? uid, String? profileImage, String? displayName) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection('Users').doc(uid).set({
        "id":uid,
        "email": email,
        "profileImage": profileImage,
        "displayName": displayName
      });
      print('User details added to Firestore');
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  void signInWithGoogle(BuildContext context) async {
    try{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    print("Google User: $googleUser!");
    // User userInfo = User();

    addInitialUserDetails(googleUser!.email, googleUser.id, googleUser.photoUrl, googleUser.displayName);

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if(userCredential.user!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserPage()));
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