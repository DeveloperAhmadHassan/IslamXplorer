import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

import '../models/user.dart';

class ProfilePhoto extends StatefulWidget {
  ProfilePhoto({
    super.key,
    required this.profileImage,
    required this.size,
  });

  final Widget profileImage;
  final double size;
  UserDataController userDataController = UserDataController();

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  late AppUser appUser;
  void onTap() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (image != null) {

      final imageUrl = await widget.userDataController.uploadProfileImage(
        'Users/Images/Profile/',
        image,
      );

      // print(imageUrl.toString());

      Map<String, dynamic> json = {
        'profileImage': imageUrl
      };
      await widget.userDataController.updateUser(json);

      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser>(
      future: widget.userDataController.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return CircularProgressIndicator();
        } else if (snapshot.hasError) {

          return Text('Error: ${snapshot.error}');
        } else {
          AppUser? appUser = snapshot.data;
          return InkWell(
            onTap: onTap,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 4, color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: appUser != null && appUser.profilePicUrl != null
                    ? Image.network(appUser.profilePicUrl!)
                    : Placeholder(),
              ),
            ),
          );
        }
      },
    );
  }

  void getUser() async{
    AppUser appUser = await widget.userDataController.getUserData();
    this.appUser = appUser;
  }
}