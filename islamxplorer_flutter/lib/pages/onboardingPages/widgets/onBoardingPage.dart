import 'package:flutter/material.dart';

import '../../../extensions/color.dart';
import '../../../values/colors.dart';
import '../../../widgets/utils/custom_text.dart';

class OnBoardingPage extends StatelessWidget {
  final String image, title, subtitle;
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Image(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              image: AssetImage(image)
          ),
          CustomText(title, 28, alignment: Alignment.center, bold: true, color: Theme.of(context).brightness == Brightness.light ? HexColor.fromHexStr(AppColor.primaryThemeSwatch3) : HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),),
          const SizedBox(height: 15,),
          CustomText(subtitle, 18, alignment: Alignment.center, bold: true, fontFamily: "UbuntuRegular", color: Theme.of(context).brightness == Brightness.light ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch3) : Colors.blueGrey,)
        ],
      ),
    );
  }
}