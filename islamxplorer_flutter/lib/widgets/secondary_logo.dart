import 'package:flutter/cupertino.dart';

class SecondaryLogo extends StatelessWidget{
  const SecondaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      child:Image.asset('assets/secondary_logo.png'),
    );
  }

}