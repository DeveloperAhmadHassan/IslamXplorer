import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'error.dart';
import 'loading.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final locationStreamController =
  StreamController<LocationStatus>.broadcast();

  get stream => locationStreamController.stream;

  @override
  void initState() {
    checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      color: Colors.amber,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: checkLocationStatus,
                );
            // case GeolocationStatus.unknown:
            //   return LocationErrorWidget(
            //     error: "Unknown Location service error",
            //     callback: _checkLocationStatus,
            //   );
              default:
                return const SizedBox();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      locationStreamController.sink.add(s);
    } else {
      locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final compassSVG = SvgPicture.asset('assets/compass.svg');
  final needleSVG = SvgPicture.asset(
    'assets/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }
        final qiblahDirection = snapshot.data!;

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: (qiblahDirection.direction * (pi / 180) * -1),
              child: compassSVG,
            ),
            Transform.rotate(
              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
              alignment: Alignment.center,
              child: needleSVG,
            ),
            Positioned(
              bottom: 8,
              child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°", style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey
              ),),
            )
          ],
        );
      },
    );
  }
}