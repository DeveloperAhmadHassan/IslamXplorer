import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? name;
    var user = FirebaseAuth.instance.currentUser;
    name = user!.displayName;

    void onTap(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchingPage()));
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      
      body: Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PrimaryLogo(),
        CustomSearchBar(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchingPage()));
          },
        ),
            CustomText("$name",24),
          ],
        ),
      )
    );
  }

}