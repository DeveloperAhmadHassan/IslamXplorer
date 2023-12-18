import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';

class DuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: CustomAppBar("Duas"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Cards(),
          ],
        ),
      )
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.height / 2.7),
        children: [
          for (var i = 0; i < 7; i++)
            DuaItemCard(),
        ],
      ),
    );
  }
}

class DuaItemCard extends StatelessWidget{
  const DuaItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    var duaNum = 0;
    var newDua = false;
    return InkWell(
      onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=>DuaListPage()))},
      child: Card(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.amberAccent,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          newDua ? const NewTag() : Container(),
                        ],
                      ),
                      Container(
                        // height: 140,
                        // width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/image.png",fit: BoxFit.cover),
                        )
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
                          "$duaNum Duas",
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
      ),
    );
  }
}
