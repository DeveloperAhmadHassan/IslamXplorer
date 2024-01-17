import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islamxplorer_flutter/Controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/Controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/utils/alertDialogs.dart';
import 'package:islamxplorer_flutter/utils/snackBars.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/dua.dart';
import '../models/verse.dart';

class DuaItemPage extends StatefulWidget{
  DuaItemPage({required this.dua, super.key});
  DuaDataController duaDataController = DuaDataController();
  Dua dua;

  @override
  State<DuaItemPage> createState() => _DuaItemPageState();
}

class _DuaItemPageState extends State<DuaItemPage> {
  late String imageUrl;

  Widget build(BuildContext context) {

    return FutureBuilder<Dua>(
      future: widget.duaDataController.getDuaByID(widget.dua.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitWave(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30,),
                  Text("Loading Item. Please Wait", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ))
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot}'),
          );
        } else {
          final Dua dua = snapshot.data?? widget.dua;
          return Scaffold(
            backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
            body: SingleChildScrollView(
              child: Container(
                // color: Colors.tealAccent,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  AppString.duaBGUrl
                              ),
                              fit: BoxFit.cover
                          )
                      ),
                      // color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white.withOpacity(0.7)
                              ),
                              // color: Colors.white,
                              child: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded), onPressed: ()=>Navigator.pop(context),),
                            ),
                            Row(
                              children: [
                                Container(
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                      color: Colors.white.withOpacity(0.7)
                                  ),
                                  // color: Colors.white,
                                  child: Bookmark(dua: dua,),
                                ),
                                SizedBox(width: 15,),
                                Container(
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                      color: Colors.white.withOpacity(0.7)
                                  ),
                                  // color: Colors.white,
                                  child: IconButton(icon: Icon(Icons.share_outlined), onPressed: () {  },),
                                ),
                                SizedBox(width: 15,),
                                Container(
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                      color: Colors.white.withOpacity(0.7)
                                  ),
                                  // color: Colors.white,
                                  child: Report(dua: dua,),
                                ),
                                SizedBox(width: 10,),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: EdgeInsets.only(top:250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Text("${dua.title}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    ), textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Text("${dua.arabicText}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700
                                    ), textDirection: TextDirection.rtl),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width,
                          //   // color: Colors.deepOrange,
                          //   padding: EdgeInsets.all(15),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text("Surah Name", style: TextStyle(fontSize: 18),),
                          //       Text("Verse ID", style: TextStyle(fontSize: 18),),
                          //     ],
                          //   ),
                          // ),
                          Card(
                            elevation: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Text("${dua.englishText}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    )),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Text("${dua.transliteration}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            children: [
                              CustomText('Explanation', 24, color: Colors.blueAccent, bold: true,underline: true,onTap: ()=>seeExp(context, dua.explanation),)
                            ],
                          ),
                          SizedBox(height: 30,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          );
        }
      },
    );
  }

  void seeExp(BuildContext context, String? exp) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Explanation'),
          content: exp != null && exp.isNotEmpty
              ? Text(exp, style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600
          ))
              : Text('No explanation for this Dua.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void toggleBookmarks(String id, BuildContext context) async{
    UserDataController userDataController = UserDataController();
    if(widget.dua.isBookmarked){
      var result = userDataController.removeBookmark(id);
      if(await result){
        widget.dua.isBookmarked = false;
        setState(() {

        });
      }
    } else {
      var result = userDataController.addBookmark(id);
      if(await result){
        widget.dua.isBookmarked = true;
        setState(() {

        });
      }
    }
  }
}

class RelatedItem extends StatelessWidget{
  final String title;
  final String subtitle;
  final IconData icon;

  const RelatedItem({super.key, required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
    );
  }
}

class Bookmark extends StatefulWidget{
  late IconData icon;
  Dua dua;

  Bookmark({super.key, required this.dua}){
    if(dua.isBookmarked){
      icon = Icons.bookmark;
    } else {
      icon = Icons.bookmark_border_rounded;
    }
  }

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    print(widget.dua.isBookmarked);
    return Container(
      child: IconButton(icon: Icon(widget.icon), onPressed: () {
        if(widget.dua.isBookmarked){
          toggleBookmarks(widget.dua.id, context);
        } else {
          toggleBookmarks(widget.dua.id, context);
        }
      }),
    );
  }

  void toggleBookmarks(String id, BuildContext context) async{
    UserDataController userDataController = UserDataController();
    if(widget.dua.isBookmarked){
      var result = userDataController.removeBookmark(id);
      if(await result){
        widget.dua.isBookmarked = false;
        widget.icon = Icons.bookmark_border_rounded;
        setState(() {

        });
      }
    } else {
      var result = userDataController.addBookmark(id);
      if(await result){
        widget.dua.isBookmarked = true;
        widget.icon = Icons.bookmark;
        setState(() {

        });
      }
    }
  }
}

class Report extends StatefulWidget{
  late IconData icon;
  late bool isReported;
  Dua dua;
  late Color color;

  Report({super.key, required this.dua}){
    if(dua.isReported){
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
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController reportMessageTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(icon: Icon(widget.icon, color: widget.color), onPressed: () {
        if(widget.isReported){
          reportDua(widget.dua.id, context);
        } else {
          reportDua(widget.dua.id, context);
        }
      }),
    );
  }

  void reportDua(String id, BuildContext context) async {
    UserDataController userDataController = UserDataController();

    if (widget.dua.isReported) {
      bool confirmDeleteReport = await AlertDialogs.removeReportAlertDialog(context);
      if (confirmDeleteReport == true) {
        SnackBars.showWaitingSnackBar(context, "Deleting Report.....");
        var result = await userDataController.removeReport(widget.dua.id);

        if (result) {
          setState(() {
            widget.dua.isReported = false;
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
      bool confirmReport = await AlertDialogs.reportAlertDialog(context, reportMessageTextEditingController, "Dua");

      if (confirmReport == true) {
        SnackBars.showWaitingSnackBar(context, "Reporting Item.....");
        String message = reportMessageTextEditingController.text ?? "";
        var result = await userDataController.addReport(widget.dua.id, message);

        if (result) {
          setState(() {
            widget.dua.isReported = true;
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