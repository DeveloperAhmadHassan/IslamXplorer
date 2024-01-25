import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String? text;
  final bool isEnabled;
  final Function? onTap;

  CustomButton(this.text, this.onTap, {this.isEnabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? () async {
          if (onTap != null) {
            final result = onTap!();

            if (result is Future) {
              await result;
            }
          }
        } : null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states)
            /// Add animations for change in button states
            {
              if(states.contains(MaterialState.pressed)){
                return Colors.black26;
              }
              if(states.contains(MaterialState.disabled)){
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
        ),
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