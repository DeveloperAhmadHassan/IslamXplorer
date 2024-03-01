import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:quran/quran.dart' as quran;

class QuranHomePage extends StatefulWidget {
  const QuranHomePage({super.key});

  @override
  State<QuranHomePage> createState() => _QuranHomePageState();
}

class _QuranHomePageState extends State<QuranHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(20),
                  elevation: 15,
                  color: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  child: Container(
                    height: 160,
                    // clipBehavior: Clip.hardEdge,
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
                                    Icon(FlutterIslamicIcons.quran2),
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
                                        style: TextStyle(color: Colors.grey))
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
                Column(
                  children: List.generate(
                    114,
                    (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
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
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue,
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
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue,
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
              ],
            ),
          ),
        ));
  }
}


