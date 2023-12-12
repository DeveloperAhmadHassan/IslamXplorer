import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';

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
        FocusScope.of(context).unfocus(); // Unfocus to dismiss the keyboard
        onTap(); // Navigate to SearchingPage
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 15,
        height: 60,
        child: TextField(
          focusNode: focus ? focusNode : null,
          decoration: InputDecoration(
            hintText: "Search",
            filled: true,
            fillColor: const Color.fromRGBO(255, 249, 197, 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color.fromRGBO(255, 249, 197, 1),
                width: 10,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color.fromRGBO(255, 249, 197, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color.fromRGBO(255, 249, 197, 1),
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                onTap(); // Call the onTap callback provided by the parent widget
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