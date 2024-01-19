import 'package:flutter/cupertino.dart';

class PrimaryLogo extends StatelessWidget{
  const PrimaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child:Image.asset('assets/default.png'),
    );
  }

}