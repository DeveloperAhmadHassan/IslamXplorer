import 'package:flutter/cupertino.dart';
import 'package:islamxplorer_flutter/values/assets.dart';

class DefaultLogo extends StatelessWidget{
  const DefaultLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Image.asset(AppAsset.defaultLogo),
    );
  }

}