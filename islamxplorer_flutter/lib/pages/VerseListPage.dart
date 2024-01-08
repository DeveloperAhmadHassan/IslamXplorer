import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/Controllers/hadithDataController.dart';
import 'package:islamxplorer_flutter/Controllers/verseDataController.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/verse.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateHadithPage.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateVersePage.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'SearchItemPage.dart';


class VerseListPage extends StatelessWidget {
  final VerseDataController verseDataController = VerseDataController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: AppBar(
        title: Text("Verses"),
      ),
      body: FutureBuilder<List<Verse>>(
        future: verseDataController.fetchAllVerses(),
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
            final List<Verse> verses = snapshot.data ?? []; // Use empty list if data is null
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomButton("Add Verse", ()=>Navigator.push(context, MaterialPageRoute(builder: (cntext)=>AddUpdateVersePage()))),
                    Cards(verses: verses),
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
  final List<Verse> verses;

  const Cards({Key? key, required this.verses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var verse in verses)
          VerseCard(verse: verse),
      ],
    );
  }
}

class VerseCard extends StatelessWidget {
  final Verse verse;

  const VerseCard({Key? key, required this.verse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchItemPage(searchResultItem: verse),
            ),
          ),
          child: Card(
            elevation: 7,
            child: ListTile(
              leading: Text(verse.id),
              title: Text(verse.surah),
              subtitle: Text(verse.englishText, overflow: TextOverflow.ellipsis),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateVersePage(verse: verse, isUpdate: true,))),
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
                    onTap: ()=>{deleteVerse(verse.id)},
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

  void deleteVerse(String id){
    VerseDataController verseDataController = VerseDataController();
    verseDataController.deleteVerse(id);
  }
}
