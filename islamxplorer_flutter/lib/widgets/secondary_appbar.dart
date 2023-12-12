import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/profile_photo.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget{
  String title;

  @override
  final Size preferredSize;

  SecondaryAppBar(this.title, {super.key}) : preferredSize = Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color.fromRGBO(255, 200, 62, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: (){}, icon: Icon(LineAwesomeIcons.bars,size: 35),),
          SizedBox(width: MediaQuery.of(context).size.width/12,),
          SecondaryLogo(),
        ],
      )


      // actions: [
      //   IconButton(onPressed: ()=>Get.to(MyPage(state: 2)), icon: ProfilePhoto(profileImage: profileImage, size: 40,))
      // ],

    );
  }
}