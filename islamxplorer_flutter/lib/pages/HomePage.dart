import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.green,
      
      body: Center(
        child: Column(
          children: [
            const PrimaryLogo(),
            CustomSearchBar()
          ],
        ),
      )
      
    );
  }
  
}