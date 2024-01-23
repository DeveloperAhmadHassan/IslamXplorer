import 'dart:convert';

import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/searchResults.dart';
import 'package:http/http.dart' as http;

class ResultsDataController{
  Future<List<SearchResultItem>> fetchAllResults() async {
    const url = "http://192.168.56.1:48275/results";
    print("Hello1");
    // try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print("Hello2");
        final SearchResults searchResults = SearchResults.fromJson(jsonData);
        print("Hello3");
        final List<SearchResultItem> results = searchResults.l1;
        print("Hello4");
        return results;
      } else {
        throw Exception('Failed to load results');
      }
    // } catch (e) {
    //   throw Exception('Error: $e');
    // }
  }

// Future<AppUser> getUserData() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   String? userId = user?.uid;
  //   AppUser appUser = AppUser();
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     CollectionReference users = firestore.collection('Users');
  //
  //     // Get user document by ID
  //     DocumentSnapshot userDoc = await users.doc(userId).get();
  //
  //     if (userDoc.exists) {
  //       // Access user data
  //       Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
  //
  //       // Print or use user data
  //       print('User ID: $userId');
  //       print('Email: ${userData['email']}');
  //       print('Username: ${userData['userName']}');
  //
  //       appUser = AppUser(uid: userId,
  //           userName: userData['userName'],
  //           email: userData['email'],
  //           birthdate: userData['birthdate'],
  //           phone: userData['phone'],
  //           gender: userData['gender']);
  //
  //       return appUser;
  //
  //       // Access other fields as needed
  //     } else {
  //       print('User with ID $userId does not exist in Firestore.');
  //       return appUser;
  //     }
  //   } catch (e) {
  //     print('Error fetching user data from Firestore: $e');
  //     return appUser;
  //   }
  // }
}