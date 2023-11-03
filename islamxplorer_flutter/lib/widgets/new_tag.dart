
import 'package:flutter/material.dart';

class NewTag extends StatelessWidget {
  const NewTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "New",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

