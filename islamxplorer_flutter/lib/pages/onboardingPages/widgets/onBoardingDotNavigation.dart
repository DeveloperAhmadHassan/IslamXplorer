import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/onBoardingController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Positioned(
        bottom: kBottomNavigationBarHeight + 10,
        left: 24,
        child: SmoothPageIndicator(
            effect: ExpandingDotsEffect(activeDotColor: dark ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch2): HexColor.fromHexStr(AppColor.primaryThemeSwatch3), dotHeight: 6),
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3
        )
    );
  }
}

