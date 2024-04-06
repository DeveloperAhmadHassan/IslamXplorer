import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
        'birthdate': user.birthdate,

      });

      print('User updated!');
    } catch (e) {
      print('Error updating user to Firestore: $e');
    }
  }

  Future<AppUser> getUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    if(user!.isAnonymous){
      AppUser appUser = AppUser(uid: user.uid, isAnonymous: user.isAnonymous);
      return appUser;
    }

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
        print('Image: ${userData['profileImage']}');

        appUser = AppUser(uid: userId,
            userName: userData['userName'],
            email: userData['email'],
            birthdate: userData['birthdate'],
            phone: userData['phone'],
            type: userData['type']??"U",
            profilePicUrl: userData['profileImage'] ?? "",
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

  Future<bool> addReport(String id, String message, {String type = ""}) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        var reportsCollection = FirebaseFirestore.instance.collection('Reports');
        var timestamp = DateTime.now().toUtc();

        var newReportDocumentRef = reportsCollection.doc();
        await newReportDocumentRef.set({
          'userId': user.uid,
          'reportedItemID': id,
          'reportedItemType': type,
          'reportedTime': timestamp,
          'reportedMessage': message
        });

        var userDocumentRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);
        await userDocumentRef.update({
          'reports': FieldValue.arrayUnion([{ 'reportID': newReportDocumentRef.id, 'itemID': id }])
        });

        // print('Randomly generated document ID: ${newReportDocumentRef.id}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeReport(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
      List<dynamic> currentReports = (await userDoc.get()).get('reports') ?? [];

      var matchingReport = currentReports.firstWhere((report) => report['itemID'] == id, orElse: () => null);

      if (matchingReport != null) {
        var reportID = matchingReport['reportID'];
        currentReports.removeWhere((report) => report['itemID'] == id);
        await userDoc.update({
          'reports': currentReports,
        });

        var reportsCollection = FirebaseFirestore.instance.collection('Reports');
        await reportsCollection.doc(reportID).delete();

        print('Item removed from Reports!');
        return true;
      }
      else{
        return false;
      }
    }catch (e) {
      print('Error removing bookmark from Firestore: $e');
      return false;
    }
  }

  Future<bool> isReported(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
      List<dynamic> currentReports = (await userDoc.get()).get('reports') ?? [];

      return currentReports.any((report) => report['itemID'] == id);
    } catch (e) {
      print('Error checking if report exists in Firestore: $e');
      return false;
    }
  }

  Future<String> uploadProfileImage(String path, XFile image) async{
    try {
      Reference reference = FirebaseStorage.instance.ref(path).child(image.name);
      await reference.putFile(File(image.path));
      String url = await reference.getDownloadURL();
      return url;

    } catch (e) {
      return 'Error checking if report exists in Firestore: $e';
    }
  }

  Future<void> updateUser(Map<String, dynamic> json) async{
    try {
      UserDataController userDataController = UserDataController();
      AppUser user = await userDataController.getUserData();

      DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user.uid);
      await userDoc.update(json);
    } catch (e) {
      print('Error checking if report exists in Firestore: $e');
    }
  }
}