import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/profile_photo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  String title;

  @override
  final Size preferredSize;

  HomeAppBar(this.title, {super.key}) : preferredSize = const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    String? photoUrl = user?.photoURL;

    Widget profileImage = photoUrl != null
        ? const Image(image: AssetImage('assets/profile.png'),)
        : const Image(image: AssetImage('assets/profile.png'),);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CustomText(title, 35, alignment: Alignment.topLeft,),
      ),
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(onPressed: (){}, icon: Icon(LineAwesomeIcons.bars)),
      ),

      actions: [
        IconButton(onPressed: ()=>Get.to(MyPage(state: 2)), icon: ProfilePhoto(profileImage: profileImage, size: 40,))
      ],

    );
  }
}