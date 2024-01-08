import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/models/user.dart';

class UserDataController{
  Future<void> addUserToFirestore(AppUser user) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the "users" collection
      CollectionReference users = firestore.collection('Users');

      // Add a new document with a unique ID
      await users.doc(user.uid).set({
        'email': user.email,
        'userName': user.userName,
        'phone': user.phone,
        'gender': user.gender,
        'birthdate': user.birthdate
        // Add more fields as needed
      });

      print('User updated!');
    } catch (e) {
      print('Error updating user to Firestore: $e');
    }
  }
  Future<AppUser> getUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;
    AppUser appUser = AppUser();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection('Users');

      // Get user document by ID
      DocumentSnapshot userDoc = await users.doc(userId).get();

      if (userDoc.exists) {
        // Access user data
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Print or use user data
        print('User ID: $userId');
        print('Email: ${userData['email']}');
        print('Username: ${userData['userName']}');
        print('Type: ${userData['type']}');

        appUser = AppUser(uid: userId,
            userName: userData['userName'],
            email: userData['email'],
            birthdate: userData['birthdate'],
            phone: userData['phone'],
            type: userData['type'],
            gender: userData['gender']);

        return appUser;

        // Access other fields as needed
      } else {
        print('User with ID $userId does not exist in Firestore.');
        return appUser;
      }
    } catch (e) {
      print('Error fetching user data from Firestore: $e');
      return appUser;
    }
  }
}