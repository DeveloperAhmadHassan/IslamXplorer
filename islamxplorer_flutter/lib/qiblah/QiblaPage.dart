import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/qiblah/qiblah_widget.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class QiblahPage extends StatelessWidget {
  const QiblahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
          title: const Text('Qiblah Direction'),
          elevation: 7,
        ),
        body:QiblahWidget()
      );
    }
}