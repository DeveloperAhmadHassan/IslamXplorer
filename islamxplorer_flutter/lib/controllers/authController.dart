import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class AuthController{

  Future<AppUser> login(String email, String password) async {
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

          return appUser;
        } catch (e) {
          throw ("Error fetching user data: $e");
        }

      } else{
        throw ("Error");
      }
    } on FirebaseAuthException catch (e) {
      throw ("Firebase Authentication Error: ${e.code}");
    } catch (e) {
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
}