import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/qiblah/QiblaPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/dummy_search_bar.dart';
import 'package:islamxplorer_flutter/widgets/home_appbar.dart';
import 'package:islamxplorer_flutter/widgets/primary_logo.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
            DummySearchBar(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                scrollDirection:Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FeatureItem(),
                    const SizedBox(width: 20,),
                    FeatureItem(),
                    const SizedBox(width: 20,),
                    FeatureItem(),
                    const SizedBox(width: 20,),
                    FeatureItem(),
                    const SizedBox(width: 20,),
                    FeatureItem(),
                    const SizedBox(width: 20,),
                    FeatureItem(),
                    const SizedBox(width: 20,),
                  ],
                ),
              ),
            )
            // CustomText("$name",24),
          ],
        ),
      )
    );
  }

}

class FeatureItem extends StatelessWidget{
  Icon icon;
  Color color;
  FeatureItem({
    super.key,
    this.icon = const Icon(LineAwesomeIcons.compass, size: 40),
    this.color = Colors.white60
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 70,
        height:70,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: icon,
      ),
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const QiblahPage())),
    );
  }

}