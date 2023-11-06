import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';

class DuaCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var dua_num=0;
    var new_dua=false;
    return Card(
      elevation: 12,
      shadowColor: Colors.black,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 190,
        height: 260,
        color: Color.fromRGBO(246, 237, 151, 1.0),
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     stops: [
        //       0.3,
        //
        //     ],
        //     colors: [
        //       Color.fromRGBO(246, 237, 151, 1.0),
        //
        //     ],
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new_dua ? const NewTag() : Container(),
                        Icon(Icons.favorite_border, color: Colors.red,)
                      ],
                    ),
                    SizedBox(
                      height: 140,
                      width: 180,
                      child: Image.asset("assets/sleep.png"),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Supplication Title",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexMono'
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$dua_num Duas",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IBMPlexMono'
                        ),
                      ),
                    ),
                    Icon(Icons.share_outlined, color: Colors.indigo,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}