import 'package:flutter/material.dart';

import '../widgets/dummy_search_bar.dart';

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
      body: Center(
        child: DummySearchBar(),
      ),
    );
  }
  
}