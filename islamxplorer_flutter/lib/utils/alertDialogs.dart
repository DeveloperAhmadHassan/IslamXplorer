import 'package:flutter/material.dart';

class AlertDialogs{
  static Future<bool> reportAlertDialog (BuildContext context, TextEditingController reportMessageTextEditingController, String itemType) async{
    return await showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // backgroundColor: Colors.red,
          surfaceTintColor: Colors.green,
          title: Text('Report $itemType'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to report this $itemType?'),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Enter your message'),
                controller: reportMessageTextEditingController,
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(
                'Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> removeReportAlertDialog (BuildContext context) async{
    return await showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // surfaceTintColor: Colors.red,
          title: Text('Remove Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to remove your report?'),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text('No', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              )),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text('Yes', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              )),
            ),
          ],
        );
      },
    );
  }
}