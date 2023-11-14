import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(255, 200, 62, 1.0),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 7, color: Colors.amberAccent)
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),child: const Image(image: AssetImage('assets/image.png')))
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.amberAccent
                      ),
                      child: Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              CustomText("John Doe", 25, alignment: Alignment.center,bold: true,),
              CustomText("john123@gmail.com", 20, alignment: Alignment.center, color: Colors.black54,),
              CustomButton("Edit Profile", (){}),
              const SizedBox(height: 30,),
              const Divider(),
              const SizedBox(height: 10,),
              ProfileMenuWidget(icon:LineAwesomeIcons.cog, text: "Settings", onTap: (){}),
              ProfileMenuWidget(icon:LineAwesomeIcons.bookmark, text: "Bookmarks", onTap: (){}),
              ProfileMenuWidget(icon: LineAwesomeIcons.history, text: "Search History", onTap: (){}),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              ProfileMenuWidget(icon:LineAwesomeIcons.file, text: "Documentation", onTap: (){}),
              ProfileMenuWidget(icon:LineAwesomeIcons.alternate_sign_out, text: "Logout", onTap: (){}, textColor: Colors.red,endIcon: false,),
              SizedBox(height: 100,)
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
      title: CustomText(text, 20, color: textColor,),
      trailing: endIcon ? Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black54.withOpacity(0.1)
        ),
        child: Icon(LineAwesomeIcons.angle_right, color: Colors.grey),
      ): null,
    );
  }
}