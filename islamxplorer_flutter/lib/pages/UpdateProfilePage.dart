import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/profile_photo.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget{
  const UpdateProfilePage({super.key});


  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  UserDataController userDataController = UserDataController();

  AppUser user = AppUser();
  late File? pickedImage;

  @override
  void initState() {
    super.initState();
    print("initState");
    fetchUserData();
  }


  @override
  Widget build(BuildContext context) {
    // user = userDataController.getUserData() as AppUser;
    // String? photoUrl = user?.profilePic as String?;
    // String? email = user?.email;
    //
    // String userEmail = email != null
    //     ? email.toString()
    //     : "john123@gmail.com";
    // emailTextEditingController.text = userEmail;
    //
    // String? name = user?.userName;
    // String userName = name != null
    //     ? name.toString()
    //     : "John Doe";
    // userNameTextEditingController.text = userName;
    //
    // String? phone = user?.phone;
    // String userPhone = phone != null
    //     ? phone.toString()
    //     : "0331 4477744";
    // phoneTextEditingController.text = userPhone;

    String userEmail = "";
    String userName = "";
    String userPhone = "";

    String? photoUrl;

    Widget profileImage = photoUrl != null
        ? Image.network(photoUrl, fit: BoxFit.fill,)
        : const Image(image: AssetImage('assets/profile.png'),);

    return Scaffold(
      appBar: AppBar(

        title: const Text("Edit Profile"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // color: const Color.fromRGBO(255, 200, 62, 1.0),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  ProfilePhoto(profileImage: profileImage, size: 140),
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
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Colors.black,
                          size: 20,
                        ),
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
                        userNameTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Email", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.envelope_1),
                          userEmail,
                          false,
                          emailTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Phone No", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.phone),
                          userPhone,
                          false,
                          phoneTextEditingController
                      ),
                      SizedBox(height: 25,),
                      CustomText("Birth Date", 20, bold: true,),
                      CustomTextfield(
                          Icon(LineAwesomeIcons.calendar_1),
                          "Enter Date",
                          false,
                          dateInput,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now()
                            );

                            if(pickedDate != null ){
                              print(pickedDate);
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);

                              setState(() {
                                dateInput.text = formattedDate;
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
              CustomButton("Update Profile", updateProfile),

            ],
          ),
        ),
      )
    );
  }

  void updateProfile(){
    String userName = userNameTextEditingController.text;
    String phone = phoneTextEditingController.text;
    String email = emailTextEditingController.text;
    String birthdate = dateInput.text;
    String? uid = user?.uid;

    AppUser appUser = AppUser(uid: uid, email: email, phone: phone, userName: userName, birthdate: birthdate);
    userDataController.addUserToFirestore(appUser);
    Navigator.pop(context);
  }

  Future<void> fetchUserData() async {
    AppUser? userData = await userDataController.getUserData();
    if (userData != null) {
      setState(() {
        user = userData;
        populateTextFields();
      });
    } else {
      // Handle the case when user data is not available
    }
  }
  void populateTextFields() {
    emailTextEditingController.text = user.email!;
    userNameTextEditingController.text = user.userName!;
    phoneTextEditingController.text = user.phone!;
    dateInput.text = user.birthdate!;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
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