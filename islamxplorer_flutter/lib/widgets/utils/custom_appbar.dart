import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  String title;

  @override
  final Size preferredSize;

  CustomAppBar(this.title, {super.key}) : preferredSize = const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CustomText("Duas", 35, alignment: Alignment.topLeft,),
      ),
      backgroundColor: const Color.fromRGBO(255, 200, 62, 1.0),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.bars,size: 35,)),
      )


    );
  }
}