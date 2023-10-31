import 'package:flutter/material.dart';

class DuaCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var dua_num=0;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "New",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.favorite_border, color: Colors.red,)
                ],
              ),
              Container(
                height: 140,
                width: 180,
                child: Image.asset("assets/sleep.png"),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Supplication Title",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold
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
                        "Duas: $dua_num",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
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