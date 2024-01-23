import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/pages/UpdateProfilePage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/profile_photo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    String? photoUrl = user?.photoURL;
    String? email = user?.email;

    String userEmail = email != null
        ? email.toString()
        : "john";

    String? name = user?.displayName;

    String userName = name != null
        ? name.toString()
        : "";

    Widget profileImage = photoUrl != null
        ? Image.network(photoUrl, fit: BoxFit.fill,)
        : const Image(image: AssetImage('assets/profile.png'),);

    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      appBar: AppBar(
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
        title: const Text("Profile"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: const Color.fromRGBO(255, 200, 62, 1.0),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  ProfilePhoto(profileImage: profileImage, size: 140,),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              CustomText(userName, 25, alignment: Alignment.center,bold: true,),
              CustomText(userEmail, 20, alignment: Alignment.center, color: Colors.black54,),
              const SizedBox(height: 20,),
              CustomButton("Edit Profile", () => Get.to(UpdateProfilePage())),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              ProfileMenuWidget(icon:LineAwesomeIcons.cog, text: "Settings", onTap: (){}),
              ProfileMenuWidget(icon:LineAwesomeIcons.bookmark, text: "Bookmarks", onTap: (){}),
              ProfileMenuWidget(icon: LineAwesomeIcons.history, text: "Search History", onTap: (){}),
              const SizedBox(height: 20,),
              const Divider(),
              const SizedBox(height: 20,),
              ProfileMenuWidget(icon:LineAwesomeIcons.file, text: "Documentation", onTap: (){}),
              ProfileMenuWidget(icon:LineAwesomeIcons.alternate_sign_out, text: "Logout", onTap: ()=>signOut(context), textColor: Colors.red,endIcon: false,),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      )
    );
  }
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool endIcon;
  final Color textColor;

  const ProfileMenuWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.endIcon = true,
    this.textColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueAccent.withOpacity(0.2)
        ),
        child: Icon(icon, color: Colors.blueAccent,),
      ),
      title: CustomText(text, 20, color: textColor,bold: true,),
      trailing: endIcon ? Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black54.withOpacity(0.1)
        ),
        child: const Icon(LineAwesomeIcons.angle_right, color: Colors.grey),
      ): null,
    );
  }
  
}