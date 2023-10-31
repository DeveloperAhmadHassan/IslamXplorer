import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      
      body: Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PrimaryLogo(),
            CustomSearchBar(),
          ],
        ),
      )
    );
  }
  
}