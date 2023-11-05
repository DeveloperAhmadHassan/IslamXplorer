import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String? text;
  Function? onTap;

  CustomButton(this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
      ),
      child: ElevatedButton(
        onPressed: (){
          onTap!(text);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states)
            {
              if(states.contains(MaterialState.pressed)){
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
        child: Text("$text", style: const TextStyle(
          fontSize: 18,
          fontFamily: "IBMPlexMono",
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }

}