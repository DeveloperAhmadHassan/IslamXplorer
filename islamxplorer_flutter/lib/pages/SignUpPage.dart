import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 200, 62, 1.0),
        ),
      )
    );
  }

}