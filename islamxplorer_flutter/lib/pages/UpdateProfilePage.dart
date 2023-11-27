import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/custom_textfield.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget{

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String? photoUrl = user?.photoURL;
    String? email = user?.email;

    String userEmail = email != null
        ? email.toString()
        : "john123@gmail.com";

    String? name = user?.displayName;

    String userName = name != null
        ? name.toString()
        : "John Doe";

    String? phone = user?.phoneNumber;

    String userPhone = phone != null
        ? phone.toString()
        : "0331 4477744";

    Widget profileImage = photoUrl != null
        ? Image.network(photoUrl, fit: BoxFit.fill,)
        : const Image(image: AssetImage('assets/profile.png'),);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
        title: const Text("Edit Profile"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(255, 200, 62, 1.0),
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
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: profileImage
                    )
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
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              Form(
                  child: Column(
                    children: [
                      CustomText("User Name", 20, bold: true,),
                      CustomTextfield(
                        Icon(LineAwesomeIcons.user),
                        userName,
                        false,
                        nameTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Email", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.envelope_1),
                          userEmail,
                          false,
                          nameTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Phone No", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.phone),
                          userPhone,
                          false,
                          nameTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Birth Date", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.calendar_1),
                          "Enter Date",
                          false,
                          dateinput,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now()
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);

                              setState(() {
                                dateinput.text = formattedDate;//set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                      ),
                      SizedBox(height: 25,),
                    ],
                  )
              ),
              CustomButton("Update Profile", (){}),

            ],
          ),
        ),
      )
    );
  }

  // Future _selectDate() async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: new DateTime.now(),
  //     firstDate: new DateTime(2016),
  //     lastDate: new DateTime(2019),
  //   );
  //   if(picked != null) setState(() => _value = picked.toString());
  // }
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
        child: const Icon(LineAwesomeIcons.angle_right, color: Colors.grey),
      ): null,
    );
  }
}