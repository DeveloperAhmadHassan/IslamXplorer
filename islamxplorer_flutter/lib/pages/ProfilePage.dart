import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var user = FirebaseAuth.instance.currentUser;
    AuthController authController = AuthController();

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
      // backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      appBar: AppBar(
        // backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black.withOpacity(0.002)
        ),
        toolbarHeight: 70,
        title: Row(
          children: [
            const SizedBox(width: 70,),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: const Text("Profile", style: TextStyle(
                fontSize: 35,
              )),
            )
          ],
        ),
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
              CustomText(userEmail, 20, alignment: Alignment.center,),
              const SizedBox(height: 20,),
              CustomButton("Edit Profile", () => Get.to(const UpdateProfilePage())),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              ProfileMenuWidget(icon:LineAwesomeIcons.cog, text: "Settings", onTap: (){}, textColor: Colors.blue,),
              ProfileMenuWidget(icon:LineAwesomeIcons.bookmark, text: "Bookmarks", onTap: (){}, textColor: Colors.blue,),
              ProfileMenuWidget(icon: LineAwesomeIcons.history, text: "Search History", onTap: (){}, textColor: Colors.blue,),
              const SizedBox(height: 20,),
              const Divider(),
              const SizedBox(height: 20,),
              ProfileMenuWidget(icon:LineAwesomeIcons.file, text: "Documentation", onTap: (){}, textColor: Colors.blue,),
              ProfileMenuWidget(icon:LineAwesomeIcons.alternate_sign_out, text: "Logout", onTap: () => authController.signOut(context), textColor: Colors.red,endIcon: false,),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      )
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool endIcon;
  Color? textColor;

  ProfileMenuWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.endIcon = true,
    this.textColor
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