import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/assets.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/default_logo.dart';

class CustomSearchBar extends StatefulWidget {
  final bool focus;
  final Function(String) onTap;

  const CustomSearchBar({Key? key, this.focus = false, required this.onTap})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        widget.onTap(_textEditingController.text);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 15,
        height: 60,
        child: TextField(
          focusNode: widget.focus ? focusNode : null,
          controller: _textEditingController,
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
                widget.onTap(_textEditingController.text);
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