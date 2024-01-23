import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/values/assets.dart';

class PrimaryLogo extends StatelessWidget{
  const PrimaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child:Image.asset(AppAsset.primaryLogo),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

}