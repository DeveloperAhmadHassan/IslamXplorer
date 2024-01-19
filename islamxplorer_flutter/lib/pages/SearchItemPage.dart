import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/searchBarWidgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/dua.dart';
import '../models/verse.dart';

class SearchItemPage extends StatefulWidget{
  SearchItemPage({required this.searchResultItem, super.key});
  SearchResultItem searchResultItem;

  @override
  State<SearchItemPage> createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<SearchItemPage> {
  @override
  late Verse verse;
  late Hadith hadith;
  late Dua dua;
  late String imageUrl;

  Widget build(BuildContext context) {
    if(widget.searchResultItem is Hadith){
      hadith = widget.searchResultItem as Hadith;
      imageUrl = AppString.hadithBGUrl;
    } else if(widget.searchResultItem is Verse){
      verse = widget.searchResultItem as Verse;
      imageUrl = AppString.verseBGUrl;
    }
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              imageUrl
                          ),
                          fit: BoxFit.cover
                      )
                  ),
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
                          color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                          elevation: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(
                                  widget.searchResultItem is Hadith ?
                                  "${hadith.source}" :
                                  "${verse.surah}:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700
                                  ),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                        Card(
                          color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
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
                              child: Text(widget.searchResultItem is Hadith ?
                              "${hadith.arabicText}" :
                              "${verse.arabicText}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                              ),textDirection: TextDirection.rtl),
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
                          color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                          elevation: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(widget.searchResultItem is Hadith ?
                              "${hadith.englishText}" :
                              "${verse.englishText}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Further Reading: ", style: TextStyle(fontSize: 28),),
                        SizedBox(height: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RelatedItem(title: "Something", subtitle: "Subtitle of Something", icon: Icons.ac_unit_outlined),
                            RelatedItem(title: "Something", subtitle: "Subtitle of Something", icon: Icons.ac_unit_outlined),
                            RelatedItem(title: "Something", subtitle: "Subtitle of Something", icon: Icons.ac_unit_outlined),
                          ],
                        ),
                        SizedBox(height: 30,)
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