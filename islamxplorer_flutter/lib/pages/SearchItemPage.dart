import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchItemPage extends StatefulWidget{
  const SearchItemPage({super.key});

  @override
  State<SearchItemPage> createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<SearchItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.tealAccent,
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
                  padding: EdgeInsets.only(top:180),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.lightBlueAccent.shade100],
                            ),
                            border: Border.all(
                              width: 7,
                              color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Text("وَإِذْ أَخَذْنَا مِيثَـٰقَكُمْ وَرَفَعْنَا فَوْقَكُمُ ٱلطُّورَ خُذُوا۟ مَآ ءَاتَيْنَـٰكُم بِقُوَّةٍۢ وَٱسْمَعُوا۟ ۖ قَالُوا۟ سَمِعْنَا وَعَصَيْنَا وَأُشْرِبُوا۟ فِى قُلُوبِهِمُ ٱلْعِجْلَ بِكُفْرِهِمْ ۚ قُلْ بِئْسَمَا يَأْمُرُكُم بِهِۦٓ إِيمَـٰنُكُمْ إِن كُنتُم مُّؤْمِنِينََ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                            )),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.deepOrange,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Surah Name", style: TextStyle(fontSize: 18),),
                              Text("Verse ID", style: TextStyle(fontSize: 18),),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.amberAccent, Colors.amberAccent.shade100],
                            ),
                            border: Border.all(
                                width: 7,
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Text("And when We took your covenant and raised the mountain above you ˹saying˺, “Hold firmly to that ˹Scripture˺ which We have given you and obey,” they answered, “We hear and disobey.” The love of the calf was rooted in their hearts because of their disbelief. Say, ˹O Prophet,˺ “How evil is what your ˹so-called˺ belief prompts you to do, if you ˹actually˺ believe ˹in the Torah˺!”",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                )),
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