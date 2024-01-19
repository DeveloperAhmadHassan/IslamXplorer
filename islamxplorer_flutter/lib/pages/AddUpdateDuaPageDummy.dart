import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';

class AddUpdateDuaPageDummy extends StatefulWidget {
  const AddUpdateDuaPageDummy({Key? key}) : super(key: key);

  @override
  State<AddUpdateDuaPageDummy> createState() => _AddUpdateDuaPageDummyState();
}

class _AddUpdateDuaPageDummyState extends State<AddUpdateDuaPageDummy> {
  TextEditingController duaTitleTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      appBar: AppBar(
        title: Text("Add Dua"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomText("Dua Title", 20, bold: true),
              CustomTextfield(
                const Icon(Icons.mosque_outlined, color: Colors.black),
                "some",
                false,
                duaTitleTextEditingController,
                validationCallback: (value) {
                  print("Entered value: $value");
                  if (value == null || value.isEmpty) {
                    print("Validation failed");
                    return 'Please enter some text';
                  }
                  print("Validation passed");
                  return null;
                },
              ),
              CustomButton(
                "Add Dua",
                    () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    addDua();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void addDua() {
    // Your addDua logic here
  }
}

