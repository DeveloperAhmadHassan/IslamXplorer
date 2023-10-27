import 'package:flutter/cupertino.dart';

class PrimaryLogo extends StatelessWidget{
  const PrimaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 300,
      child:Image.asset('assets/default.png'),
    );
  }

}