import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:islamxplorer_flutter/widgets/fullscreen_loader.dart';

class AuthController{
  var rememberMe = false;
  var localStorage = GetStorage();
  late String email;
  late String password;

  Future<AppUser> login(String email, String password) async {
    FullScreenLoader.openLoadingDialog("Loading", "Loading");

    if(rememberMe){
      localStorage.write("REMEMBER_ME_EMAIL_OR_CONTACT", email);
      localStorage.write("REMEMBER_ME_PASSWORD", password);
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        UserDataController userDataController = UserDataController();
        try {
          AppUser appUser = await userDataController.getUserData();

          print("User Type: ${appUser.type}");

          FullScreenLoader.stopLoading();

          return appUser;
        } catch (e) {
          FullScreenLoader.stopLoading();
          throw ("Error fetching user data: $e");
        }

      } else{
        FullScreenLoader.stopLoading();
        throw ("Error");
      }
    } on FirebaseAuthException catch (e) {
      FullScreenLoader.stopLoading();
      throw ("Firebase Authentication Error: ${e.code}");
    } catch (e) {
      FullScreenLoader.stopLoading();
      throw ("Unexpected Error: $e");
    }
  }

  Future<bool> createAccount(String email, String username, String password) async {
    print("Email: $email\nPassword: $password");

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await addInitialUserDetails(email, username, user.uid);

        for (final providerProfile in user.providerData) {
          final provider = providerProfile.providerId;
          print("Provider: $provider");

          final uid = providerProfile.uid;
          print("UID: $uid");

          final name = providerProfile.displayName;
          print("Name: $name");
          final emailAddress = providerProfile.email;
          print("email: $emailAddress");
          final profilePhoto = providerProfile.photoURL;
          print("pp: $profilePhoto");
        }
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> addInitialUserDetails(String email, String username, String? uid) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection('Users').doc(uid).set({
        // "id":uid,
        "email": email,
        "username": username,
        "type": "U",
        "bookmarks":[]
      });
      print('User details added to Firestore');
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  Future resetPassword(String email) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e){
      print(e);
    }
  }

  (String, String) getRememberMeDetails(){
    email = localStorage.read("REMEMBER_ME_EMAIL_OR_CONTACT") ?? "";
    password = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    return (email, password);
  }

}