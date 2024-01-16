import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamxplorer_flutter/models/user.dart';

class UserDataController{
  Future<void> addUserToFirestore(AppUser user) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference users = firestore.collection('Users');

      await users.doc(user.uid).set({
        'email': user.email,
        'userName': user.userName,
        'phone': user.phone,
        'gender': user.gender,
        'birthdate': user.birthdate
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

      DocumentSnapshot userDoc = await users.doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        print('User ID: $userId');
        print('Email: ${userData['email']}');
        print('Username: ${userData['userName']}');
        print('Type: ${userData['type']}');

        appUser = AppUser(uid: userId,
            userName: userData['userName'],
            email: userData['email'],
            birthdate: userData['birthdate'],
            phone: userData['phone'],
            type: userData['type']??"U",
            gender: userData['gender']);

        return appUser;

      } else {
        print('User with ID $userId does not exist in Firestore.');
        return appUser;
      }
    } catch (e) {
      print('Error fetching user data from Firestore: $e');
      return appUser;
    }
  }

  Future<bool> addBookmark(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
      List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];

      currentBookmarks.add(id);

      await userDoc.update({
        'bookmarks': currentBookmarks,
      });

      print('Dua added to Bookmarks!');
      return true;
    } catch (e) {
      print('Error adding bookmark to Firestore: $e');
      return false;
    }
  }

  Future<bool> removeBookmark(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
      List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];

      currentBookmarks.remove(id);

      await userDoc.update({
        'bookmarks': currentBookmarks,
      });

      print('Dua removed from Bookmarks!');
      return true;
    } catch (e) {
      print('Error removing bookmark from Firestore: $e');
      return false;
    }
  }

  Future<bool> isBookmarked(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
      List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];

      return currentBookmarks.contains(id);
    } catch (e) {
      print('Error checking if bookmark exists in Firestore: $e');
      return false;
    }
  }

  Future<bool> addReport(String id, String message) async {
    try {
      // Get the current authenticated user
      var user = FirebaseAuth.instance.currentUser;

      // Check if the user is signed in
      if (user != null) {
        // Get a reference to the Firestore collection named "ReportedItems"
        var reportsCollection = FirebaseFirestore.instance.collection('Reports');

        // Create a timestamp for the current date and time
        var timestamp = DateTime.now().toUtc();

        // Create a new document in the "ReportedItems" collection without specifying an ID
        var newReportDocumentRef = reportsCollection.doc();

        print('Randomly generated document ID: ${newReportDocumentRef.id}');

        // Set the fields for the document
        await newReportDocumentRef.set({
          'userId': user.uid,
          'reportedItemId': id,
          'message': message,
          'timestamp': timestamp,
        });

        // Return true to indicate the report was successfully added
        return true;
      } else {
        // Return false if the user is not signed in
        return false;
      }
    } catch (e) {
      // Return false if an error occurs during the process
      return false;
    }
  }


}