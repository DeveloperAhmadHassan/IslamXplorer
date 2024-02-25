import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamxplorer_flutter/models/report.dart';

class ReportDataController{
  Future<List<Report>> fetchAllReports() async {
    List<Report> reports = [];

    FirebaseFirestore.instance.collection('Reports').snapshots().listen((snapshot) {
      print(snapshot.docs.length.toString());

      for(var item in snapshot.docs){
        Timestamp timestamp = item['reportedTime'];
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);

        reports.add(Report(
          rid: item['reportedItemID'],
          uid: item['userId'],
          reportItemType: item['reportedItemType'] != null || item['reportedItemType'] != ""
              ? ItemType.values.firstWhere((type) => type.toString().split('.').last == item['reportedItemType'], orElse: () => ItemType.dua)
              : ItemType.dua,
          reportMessage: item['reportedMessage'] ?? "",
          reportTime: dateTime
        ));
      }

      for (var item in reports){
        print(item.rid);
      }
    });

    return reports;
  }

  // Future<bool> addBookmark(String id) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
  //     List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];
  //
  //     currentBookmarks.add(id);
  //
  //     await userDoc.update({
  //       'bookmarks': currentBookmarks,
  //     });
  //
  //     print('Dua added to Bookmarks!');
  //     return true;
  //   } catch (e) {
  //     print('Error adding bookmark to Firestore: $e');
  //     return false;
  //   }
  // }
  //
  // Future<bool> removeBookmark(String id) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
  //     List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];
  //
  //     currentBookmarks.remove(id);
  //
  //     await userDoc.update({
  //       'bookmarks': currentBookmarks,
  //     });
  //
  //     print('Dua removed from Bookmarks!');
  //     return true;
  //   } catch (e) {
  //     print('Error removing bookmark from Firestore: $e');
  //     return false;
  //   }
  // }
  //
  // Future<bool> isBookmarked(String id) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
  //     List<dynamic> currentBookmarks = (await userDoc.get()).get('bookmarks') ?? [];
  //
  //     return currentBookmarks.contains(id);
  //   } catch (e) {
  //     print('Error checking if bookmark exists in Firestore: $e');
  //     return false;
  //   }
  // }
  //
  // Future<bool> addReport(String id, String message) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     if (user != null) {
  //       var reportsCollection = FirebaseFirestore.instance.collection('Reports');
  //       var timestamp = DateTime.now().toUtc();
  //
  //       var newReportDocumentRef = reportsCollection.doc();
  //       await newReportDocumentRef.set({
  //         'userId': user.uid,
  //         'reportedItemID': id,
  //         'reportedItemType': message,
  //         'reportedTime': timestamp,
  //         'reportedMessage': message
  //       });
  //
  //       var userDocumentRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);
  //       await userDocumentRef.update({
  //         'reports': FieldValue.arrayUnion([{ 'reportID': newReportDocumentRef.id, 'itemID': id }])
  //       });
  //
  //       print('Randomly generated document ID: ${newReportDocumentRef.id}');
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // Future<bool> removeReport(String id) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
  //     List<dynamic> currentReports = (await userDoc.get()).get('reports') ?? [];
  //
  //     var matchingReport = currentReports.firstWhere((report) => report['itemID'] == id, orElse: () => null);
  //
  //     if (matchingReport != null) {
  //       var reportID = matchingReport['reportID'];
  //       currentReports.removeWhere((report) => report['itemID'] == id);
  //       await userDoc.update({
  //         'reports': currentReports,
  //       });
  //
  //       var reportsCollection = FirebaseFirestore.instance.collection('Reports');
  //       await reportsCollection.doc(reportID).delete();
  //
  //       print('Item removed from Reports!');
  //       return true;
  //     }
  //     else{
  //       return false;
  //     }
  //   }catch (e) {
  //     print('Error removing bookmark from Firestore: $e');
  //     return false;
  //   }
  // }
  //
  // Future<bool> isReported(String id) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user?.uid);
  //     List<dynamic> currentReports = (await userDoc.get()).get('reports') ?? [];
  //
  //     return currentReports.any((report) => report['itemID'] == id);
  //   } catch (e) {
  //     print('Error checking if report exists in Firestore: $e');
  //     return false;
  //   }
  // }
  //
  // Future<String> uploadProfileImage(String path, XFile image) async{
  //   try {
  //     Reference reference = FirebaseStorage.instance.ref(path).child(image.name);
  //     await reference.putFile(File(image.path));
  //     String url = await reference.getDownloadURL();
  //     return url;
  //
  //   } catch (e) {
  //     return 'Error checking if report exists in Firestore: $e';
  //   }
  // }
  //
  // Future<void> updateUser(Map<String, dynamic> json) async{
  //   try {
  //     UserDataController userDataController = UserDataController();
  //     AppUser user = await userDataController.getUserData();
  //
  //     DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(user.uid);
  //     await userDoc.update(json);
  //   } catch (e) {
  //     print('Error checking if report exists in Firestore: $e');
  //   }
  // }
}

// void main(){
//   print("Hello World");
// }