import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  CustomErrorWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(AppString.duaBGUrl, fit: BoxFit.cover),
          ),
        ),
        CustomText("Error Occurred!!!",22, bold: true, alignment: Alignment.center,),
        CustomText("Please Try Again!!!!", 20, bold: true, alignment: Alignment.center,)
      ],
    );
  }
}
