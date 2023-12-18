import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import 'qiblah_compass_widget.dart';
import 'loading.dart';


class QiblahWidget extends StatefulWidget {
  const QiblahWidget({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QiblahWidget> {
  final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            }

            if (snapshot.data!) {
              return const QiblahCompass();
            } else {
              return const Center(child: Text("Nothingg to show"));
            }
          },


    );
  }
}