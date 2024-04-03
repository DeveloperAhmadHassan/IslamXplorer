import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:quran/quran.dart' as quran;

import '../models/surah.dart';
import 'SurahHomePage.dart';

class QuranHomePage extends StatefulWidget {
  const QuranHomePage({Key? key}) : super(key: key);

  @override
  State<QuranHomePage> createState() => _QuranHomePageState();
}

class _QuranHomePageState extends State<QuranHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black.withOpacity(0.0002)),
          title: Text("Quran Home",
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white)),
          centerTitle: true,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(20),
              elevation: 15,
              color: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  gradient: Theme.of(context).brightness == Brightness.light ? AppColor.secondaryLinearGradientSwatch1 : AppColor.secondaryLinearGradientSwatch1,
                  borderRadius: BorderRadius.circular(35)
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: -40,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/quran_v1_nobg.png'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.book),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Last Read")
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Al-Fatiah"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Ayah No: 1",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blueGrey
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                  indicatorWeight: 0.9,
                  automaticIndicatorColorAdjustment: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                  labelColor: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Surah",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Para",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Page",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Hijb",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [

                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        114,
                            (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Surah surah = Surah(id: index+1, totalVerses: quran.getVerseCount(index+1));
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SurahHomePage(surah: surah)));
                                print('Tapped on Surah ${index + 1}');
                              },
                    
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 80,
                                width: 350,
                                child: Row(
                                  children: [
                                    Text(
                                      quran.getVerseEndSymbol(index + 1),
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          quran.getSurahName(index + 1),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            "${(quran.getPlaceOfRevelation(index + 1) == 'Makkah')?"MECCAN":"MEDINIAN"} - ${quran.getVerseCount(index + 1).toString()} Verses",
                                            style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w500
                                            )),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      quran.getSurahNameArabic(index + 1),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Divider(height: 1, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // second tab bar view widget
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        30,
                            (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Surah surah = Surah(id: index+1, totalVerses: quran.getVerseCount(index+1));
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SurahHomePage(surah: surah)));
                                print('Tapped on Para ${index + 1}');
                              },

                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 80,
                                width: 350,
                                child: Row(
                                  children: [
                                    Text(
                                      quran.getVerseEndSymbol(index + 1),
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          quran.getSurahName(index + 1),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            "${(quran.getPlaceOfRevelation(index + 1) == 'Makkah')?"MECCAN":"MEDINIAN"} - ${quran.getVerseCount(index + 1).toString()} Verses",
                                            style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w500
                                            )),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      quran.getSurahNameArabic(index + 1),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).brightness == Brightness.light ? Colors.blue : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Divider(height: 1, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // second tab bar view widget
                  Container(
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Car',
                      ),
                    ),
                  ),

                  // second tab bar view widget
                  Container(
                    color: Colors.yellow,
                    child: Center(
                      child: Text(
                        'Car',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
