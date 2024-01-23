import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

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
            fillColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(100),
            //   borderSide: const BorderSide(
            //     color: Color.fromRGBO(255, 249, 197, 1),
            //     width: 10,
            //   ),
            // ),
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
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                onTap();
              },
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/icon.png',
                width: 20,
                height: 20,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}