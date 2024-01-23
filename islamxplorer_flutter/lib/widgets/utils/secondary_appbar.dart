import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/secondary_logo.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget{
  String title;

  @override
  final Size preferredSize;

  SecondaryAppBar(this.title, {super.key}) : preferredSize = Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SecondaryLogo(),
        ],
      )
    );
  }
}