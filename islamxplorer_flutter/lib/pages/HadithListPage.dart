import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/Controllers/hadithDataController.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateHadithPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'SearchItemPage.dart';


class HadithListPage extends StatelessWidget {
  final HadithDataController hadithDataController = HadithDataController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        title: Text("Hadiths"),
      ),
      body: FutureBuilder<List<Hadith>>(
        future: hadithDataController.fetchAllHadiths(),
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
            final List<Hadith> hadiths = snapshot.data ?? []; // Use empty list if data is null
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomButton("Add Hadith", ()=>Navigator.push(context, MaterialPageRoute(builder: (cntext)=>AddUpdateHadithPage()))),
                    Cards(hadiths: hadiths),
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
  final List<Hadith> hadiths;

  const Cards({Key? key, required this.hadiths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var hadith in hadiths)
          HadithCard(hadith: hadith),
      ],
    );
  }
}

class HadithCard extends StatelessWidget {
  final Hadith hadith;

  const HadithCard({Key? key, required this.hadith}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the 'hadith' object to populate your card
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchItemPage(searchResultItem: hadith), // Replace SearchItemPage with your actual page class
            ),
          ),
          child: Card(
            elevation: 7,
            child: ListTile(
              leading: Text(hadith.id),
              title: Text(hadith.source),
              subtitle: Text(hadith.englishText, overflow: TextOverflow.ellipsis),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateHadithPage(hadith: hadith, isUpdate: true,))),
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
                    onTap: ()=>{deleteHadith(hadith.id)},
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

  void deleteHadith(String id){
    HadithDataController hadithDataController = HadithDataController();
    hadithDataController.deleteHadith(id);
  }
}