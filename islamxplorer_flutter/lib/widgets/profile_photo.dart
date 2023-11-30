import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            border: Border.all(width: 2, color: Colors.amberAccent)
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: profileImage
        )
    );
  }
}