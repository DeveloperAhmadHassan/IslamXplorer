import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';


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

    final List<FlSpot> dummyData1 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });

    // This will be used to draw the orange line
    final List<FlSpot> dummyData2 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });

    // This will be used to draw the blue line
    final List<FlSpot> dummyData3 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });

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
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: CustomText("Total Reports",24, alignment: Alignment.center,bold: true,),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 250,
                      width: 350,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          lineTouchData: LineTouchData(enabled: true),
                          lineBarsData: [
                            // The red line
                            LineChartBarData(
                              spots: dummyData1,
                              isCurved: true,
                              barWidth: 3,
                              color: Colors.indigo,
                            ),
                            // The orange line
                            LineChartBarData(
                              spots: dummyData2,
                              isCurved: true,
                              barWidth: 3,
                              color: Colors.red,
                            ),
                            // The blue line
                            LineChartBarData(
                              spots: dummyData3,
                              isCurved: false,
                              barWidth: 3,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
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
              const SizedBox(
                height: 40,
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
