import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/assets.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/default_logo.dart';

class CustomSearchBar extends StatelessWidget {
  final bool focus;
  final FocusNode focusNode = FocusNode();
  final VoidCallback onTap;

  CustomSearchBar({this.focus = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 15,
        height: 60,
        child: TextField(
          focusNode: focus ? focusNode : null,
          decoration: InputDecoration(
            hintText: "Search",
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                onTap();
              },
            ),
            prefixIcon: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 7),
              child: DefaultLogo(),
            ),
          ),
        ),
      ),
    );
  }
}