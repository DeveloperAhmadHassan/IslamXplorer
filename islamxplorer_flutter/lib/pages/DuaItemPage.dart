import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/dua.dart';
import '../models/verse.dart';

class DuaItemPage extends StatefulWidget{
  DuaItemPage({required this.dua, super.key});
  Dua dua;

  @override
  State<DuaItemPage> createState() => _DuaItemPageState();
}

class _DuaItemPageState extends State<DuaItemPage> {
  late String imageUrl;

  Widget build(BuildContext context) {
    // if(widget.searchResultItem is Hadith){
    //   hadith = widget.searchResultItem as Hadith;
    // } else if(widget.searchResultItem is Verse){
    //   verse = widget.searchResultItem as Verse;
    // }
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.tealAccent,
          child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Colors.white.withOpacity(0.7)
                          ),
                          // color: Colors.white,
                          child: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded), onPressed: ()=>Navigator.pop(context),),
                        ),
                        Row(
                          children: [
                            Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white.withOpacity(0.7)
                              ),
                              // color: Colors.white,
                              child: IconButton(icon: Icon(Icons.bookmark_border_rounded), onPressed: () {  },),
                            ),
                            SizedBox(width: 15,),
                            Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white.withOpacity(0.7)
                              ),
                              // color: Colors.white,
                              child: IconButton(icon: Icon(Icons.share_outlined), onPressed: () {  },),
                            ),
                            SizedBox(width: 15,),
                            Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white.withOpacity(0.7)
                              ),
                              // color: Colors.white,
                              child: IconButton(icon: Icon(Icons.report_gmailerrorred_outlined), onPressed: () {  },),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  padding: EdgeInsets.only(top:250),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text("${widget.dua.title}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  )),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Colors.blue, Colors.lightBlueAccent.shade100],
                            //   ),
                            //   border: Border.all(
                            //     width: 7,
                            //     color: Colors.white
                            //   ),
                            //   borderRadius: BorderRadius.circular(25),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text("${widget.dua.arabicText}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                              )),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   // color: Colors.deepOrange,
                        //   padding: EdgeInsets.all(15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Surah Name", style: TextStyle(fontSize: 18),),
                        //       Text("Verse ID", style: TextStyle(fontSize: 18),),
                        //     ],
                        //   ),
                        // ),
                        Card(
                          elevation: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text("${widget.dua.englishText}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                ),
              ],
            ),
        ),
      ),

    );
  }
}

class RelatedItem extends StatelessWidget{
  final String title;
  final String subtitle;
  final IconData icon;

  const RelatedItem({super.key, required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
    );
  }
}