import 'package:flutter/cupertino.dart';

class SecondaryLogo extends StatelessWidget{
  const SecondaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.only(top: 65),
      child:Image.asset('assets/secondary_logo.png'),
    );
  }

}