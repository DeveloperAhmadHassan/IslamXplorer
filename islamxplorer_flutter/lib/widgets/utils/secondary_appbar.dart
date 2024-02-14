import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/secondary_logo.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  SecondaryAppBar(this.title, {super.key}) : preferredSize = Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    // Set system overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black.withOpacity(0.0002),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Set the desired status bar icon color
      child: Container(
        // color: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SecondaryLogo(),
          ],
        ),
      ),
    );
  }
}