import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';

class TermsAndConditions extends StatefulWidget{
  bool value = false;
  TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
          value: widget.value,
          onChanged: (bool? value) {
            setState(() {
              toggleCheckBox();
            });
          },
        ),
        CustomText(
          "I have read the ",
          14,
          color: Colors.black,
          alignment: Alignment.center,
          onTap: (){},
        ),
        CustomText(
          "Terms and Conditions",
          14,
          bold: true,
          underline: true,
          color: Colors.blue,
          alignment: Alignment.center,
          onTap: (){},
        ),
      ],
    );
  }

  void toggleCheckBox(){
    setState(() {
      widget.value = !widget.value;
    });
  }
}