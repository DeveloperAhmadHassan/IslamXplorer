import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/onBoardingController.dart';

import '../../../extensions/color.dart';
import '../../../values/colors.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Positioned(
        right: 24,
        bottom: kBottomNavigationBarHeight,
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(context),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              backgroundColor: dark ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch2): HexColor.fromHexStr(AppColor.primaryThemeSwatch3)
          ),
          child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
        )
    );
  }
}