import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/utils/alertDialogs.dart';
import 'package:islamxplorer_flutter/utils/snackBars.dart';

class ReportItem extends StatefulWidget{
  late IconData icon;
  late bool isReported;
  SearchResultItem item;
  late Color color;

  ReportItem({super.key, required this.item}){
    if(item.sIsReported){
      icon = Icons.report;
      color = Colors.red;
      isReported = true;
    } else {
      icon = Icons.report_gmailerrorred_rounded;
      isReported = false;
      color = Colors.black;
    }
  }

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  TextEditingController reportMessageTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("Item Type: ${widget.item.runtimeType}");
    return IconButton(icon: Icon(widget.icon, color: widget.color), onPressed: () {
      reportDua(widget.item.sID, context);
    });
  }

  void reportDua(String id, BuildContext context) async {
    UserDataController userDataController = UserDataController();

    if (widget.item.sIsReported) {
      bool confirmDeleteReport = await AlertDialogs.showRemoveReportAlertDialog(context);
      if (confirmDeleteReport == true) {
        SnackBars.showWaitingSnackBar(context, "Deleting Report.....");
        var result = await userDataController.removeReport(widget.item.sID);

        if (result) {
          setState(() {
            widget.item.updateReportStatus(false);
            widget.icon = Icons.report_gmailerrorred_outlined;
            widget.color = Colors.black;
          });
          SnackBars.showSuccessSnackBar(context, "Report Deleted Sucessfully!");
        } else {
          SnackBars.showFailureSnackBar(context, "Failed to Remove Report!");
        }
      } else {
        setState(() {

        });
      }
    }
    else {
      bool confirmReport = await AlertDialogs.showReportAlertDialog(context, reportMessageTextEditingController, "Dua");

      if (confirmReport == true) {
        SnackBars.showWaitingSnackBar(context, "Reporting Item.....");
        String message = reportMessageTextEditingController.text ?? "";
        var result = await userDataController.addReport(widget.item.sID, message,type: widget.item.runtimeType.toString());

        if (result) {
          setState(() {
            widget.item.updateReportStatus(true);
            widget.icon = Icons.report;
            widget.color = Colors.red;
          });

          SnackBars.showSuccessSnackBar(context, "Item Reported Succesfully!");
        } else {
          SnackBars.showFailureSnackBar(context, "Failed To Report Item!");
        }
      } else {
        setState(() {

        });
      }
    }
  }
}