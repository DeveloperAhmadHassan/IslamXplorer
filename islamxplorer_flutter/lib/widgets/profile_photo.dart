import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.profileImage,
    required this.size,
  });

  final Widget profileImage;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 4, color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3))
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: profileImage
        )
    );
  }
}