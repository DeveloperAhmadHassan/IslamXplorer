import 'package:flutter/material.dart';

class NewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("New Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Hello from New Page")
          ],
        ),
      ),
    );
  }
  
}