import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/Controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/models/dua.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateDuaPage.dart';
import 'package:islamxplorer_flutter/pages/DuaItemPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'SearchItemPage.dart';

class DuaListPage extends StatelessWidget {
  String title;
  String type;
  final DuaDataController duaDataController = DuaDataController();

  DuaListPage({this.title = "worship", this.type = "U"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        title: Text("Duas"),
      ),
      body: FutureBuilder<List<Dua>>(
        future: type == "A" ? duaDataController.fetchAllDuas() : duaDataController.fetchDuasFromTypes(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot}'),
            );
          } else {
            final List<Dua> duas = snapshot.data ?? []; // Use empty list if data is null
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    type == "A" ? CustomButton("Add Dua", ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateDuaPage()))) : Container(),
                    Cards(duas: duas),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final List<Dua> duas;

  const Cards({Key? key, required this.duas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var dua in duas)
          DuaCard(dua: dua),
      ],
    );
  }
}

class DuaCard extends StatelessWidget {
  final Dua dua;

  const DuaCard({Key? key, required this.dua}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DuaItemPage(dua: dua), // Replace SearchItemPage with your actual page class
            ),
          ),
          child: Card(
            elevation: 7,
            child: ListTile(
              leading: Icon(Icons.mosque_outlined),
              title: Text(dua.title),
              subtitle: Text(dua.englishText, overflow: TextOverflow.ellipsis),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateHadithPage(hadith: hadith, isUpdate: true,))),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Icon(Icons.update),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    // onTap: ()=>{deleteHadith(hadith.id)},
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Icon(Icons.delete),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  // void deleteHadith(String id){
  //   HadithDataController hadithDataController = HadithDataController();
  //   hadithDataController.deleteHadith(id);
  // }
}
