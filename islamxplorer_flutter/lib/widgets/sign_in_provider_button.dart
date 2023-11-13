import 'package:flutter/material.dart';

class SignInProviderButton extends StatelessWidget{
  String? imgUri;
  BuildContext context;
  final Function? onTap;

  SignInProviderButton(this.imgUri, {this.onTap, required this.context, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75,
        width: 75,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          onPressed: (){
            onTap!(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return Colors.black26;
              }
              return Colors.white;
            })),
          child: Image.asset(imgUri!,),
        ),
      ),
    );
  }
}