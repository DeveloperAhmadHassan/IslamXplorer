import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        child: TextField (
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(255, 249, 197, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(255, 249, 197, 1),
                    width: 10
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(255, 249, 197, 1)
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(255, 249, 197, 1)
                ),
              ),
              suffixIcon: IconButton(
                //TODO: Get Search Icon from Google Material
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: (){
                  //TODO: Get Text(Search Query and send it over API)
                },
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/icon.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
              ),
              //TODO: See how to put "Text Hint" in Text field
              prefixText: "Search"
          ),
        ),
    );
  }

}