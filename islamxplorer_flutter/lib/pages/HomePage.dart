import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/dummy_search_bar.dart';
import 'package:islamxplorer_flutter/widgets/home_appbar.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? name;
    var user = FirebaseAuth.instance.currentUser;
    name = user!.email;

    void onTap(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchingPage()));
    }

    return Scaffold(
      appBar: HomeAppBar(""),
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      
      body: Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PrimaryLogo(),
            DummySearchBar()
            // CustomText("$name",24),
          ],
        ),
      )
    );
  }

}