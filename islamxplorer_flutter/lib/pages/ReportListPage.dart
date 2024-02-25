import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islamxplorer_flutter/controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/controllers/reportDataController.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/dua.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateDuaPage.dart';
import 'package:islamxplorer_flutter/pages/DuaItemPage.dart';
import 'package:islamxplorer_flutter/utils/alertDialogs.dart';
import 'package:islamxplorer_flutter/utils/snackBars.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/secondary_loader.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/report.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({super.key});

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    ReportDataController reportDataController = ReportDataController();
    // Future<List<Report>> reports = reportDataController.getAllReports();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black.withOpacity(0.0002)
        ),
          title: Text("Reports", style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
          )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 120,
                  width: 350,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      height: 160,
                      width: 160,
                    ),
                  ),
                  Card(
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      height: 160,
                      width: 160,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<Report>>(
                future: reportDataController.fetchAllReports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot}'),
                    );
                  }
                  else {
                    final List<Report> reports = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // CustomButton("Add Verse", ()=>Navigator.push(context, MaterialPageRoute(builder: (cntext)=>AddUpdateVersePage()))),
                          Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 80,
                            width: 350,
                            child: Text(reports[0].rid, style: TextStyle(
                              color: Colors.red
                            )),
                          ),
                        ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 350,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 350,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 350,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 350,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
//
// class Cards extends StatelessWidget {
//   final List<Report> reports;
//
//   const Cards({Key? key, required this.reports}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (var report in reports)
//           ReportCard(report: report),
//       ],
//     );
//   }
// }
//
// class ReportCard extends StatelessWidget {
//   final Report report;
//
//   const ReportCard({Key? key, required this.report}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           // onTap: () => Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => SearchItemPage(searchResultItem: verse),
//           //   ),
//           // ),
//           child: Card(
//             elevation: 7,
//             color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
//             child: ListTile(
//               leading: Text(report.rid, style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600
//               )),
//               title: Text(report.surah, style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600
//               )),
//               subtitle: Text(verse.englishText, overflow: TextOverflow.ellipsis, style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600
//               )),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   GestureDetector(
//                     onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateVersePage(verse: verse, isUpdate: true,))),
//                     child: Container(
//                       padding: EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(100))
//                       ),
//                       child: Icon(Icons.update),
//                     ),
//                   ),
//                   SizedBox(width: 10,),
//                   GestureDetector(
//                     onTap: ()=>{deleteVerse(verse.id)},
//                     child: Container(
//                       padding: EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: Colors.red.withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(100))
//                       ),
//                       child: Icon(Icons.delete),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 20,)
//       ],
//     );
//   }
//
//   void deleteVerse(String id){
//     VerseDataController verseDataController = VerseDataController();
//     verseDataController.deleteVerse(id);
//   }
// }
