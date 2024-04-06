import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/onBoardingController.dart';

import '../../../extensions/color.dart';
import '../../../values/colors.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: kToolbarHeight,
        right: 12,
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7),
          decoration: const BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.all(Radius.elliptical(35, 35))
          ),
          child: TextButton(onPressed: ()=>OnBoardingController.instance.skipPage(),
              child: Text("Skip", style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light ? HexColor.fromHexStr(AppColor.primaryThemeSwatch4) : Colors.blueGrey,
                  fontSize: 20
              ))
          ),
        )
    );
  }
}