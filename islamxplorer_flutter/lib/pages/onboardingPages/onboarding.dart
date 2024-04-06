import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:islamxplorer_flutter/controllers/onBoardingController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/onboardingPages/widgets/onBoardingDotNavigation.dart';
import 'package:islamxplorer_flutter/pages/onboardingPages/widgets/onBoardingNextButton.dart';
import 'package:islamxplorer_flutter/pages/onboardingPages/widgets/onBoardingPage.dart';
import 'package:islamxplorer_flutter/pages/onboardingPages/widgets/onBoardingSkipButton.dart';
import 'package:islamxplorer_flutter/values/assets.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget{
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppAsset.onBoardingImage1,
                title: AppString.onBoardingTitle1,
                subtitle: AppString.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AppAsset.onBoardingImage2,
                title: AppString.onBoardingTitle1,
                subtitle: AppString.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AppAsset.onBoardingImage3,
                title: AppString.onBoardingTitle1,
                subtitle: AppString.onBoardingSubTitle1,
              )
            ],
          ),
          const SkipButton(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }

}

