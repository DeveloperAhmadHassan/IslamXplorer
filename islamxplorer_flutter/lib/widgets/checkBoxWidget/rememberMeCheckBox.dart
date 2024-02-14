import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';

class RememberMe extends StatefulWidget{
  AuthController authController;
  RememberMe({required this.authController, super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.selected
      };

      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }

      return HexColor.fromHexStr(AppColor.primaryThemeSwatch1);
    }
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.authController.rememberMe,
          onChanged: (bool? value) {
            setState(() {
              toggleCheckBox();
            });
          },
        ),
        CustomText(
          "Remember Me",
          16,
          alignment: Alignment.center,
          onTap: (){},
        ),
      ],
    );
  }

  void toggleCheckBox(){
    setState(() {
      widget.authController.rememberMe = !widget.authController.rememberMe;
    });
  }
}