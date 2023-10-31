import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/dua_card.dart';

class DuaPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var dua_num = 0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        title: Text("Duas"),
        backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      ),
      // body: GridView.count(crossAxisCount: 3,
      //   children: <Widget>[
      //     for(var i=0;i<colors.length;i++)
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Container(color: colors[i],),
      //       ),
      //   ],
      // )
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (190 / 260),
          children: [
            for(var i=0;i<7;i++)
              DuaCard(),
          ],
        ),
      )
    );
  }
  
}