import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/surah.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:quran/quran.dart' as quran;

class SurahHomePage extends StatefulWidget {
  final Surah surah;
  SurahHomePage({super.key, required this.surah});

  @override
  State<SurahHomePage> createState() => _SurahHomePageState();
}

class _SurahHomePageState extends State<SurahHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black.withOpacity(0.0002)),
          title: Text(quran.getSurahName(widget.surah.id),
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                elevation: 15,
                color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                child: Container(
                  height: 300,
                  // clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        right: -40,
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Opacity(
                              opacity: 0.3,
                              child: Image.asset('assets/quran_v1_nobg.png')
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Text(quran.getSurahName(widget.surah.id), style: TextStyle(
                                fontSize: 24
                            )),
                            SizedBox(height: 10,),
                            Text(quran.getSurahNameEnglish(widget.surah.id), style: TextStyle(
                                fontSize: 18
                            )),
                            SizedBox(height: 20,),
                            Padding(
                              padding: EdgeInsets.only(left: 70, right: 70),
                              child: Divider(height: 3, color: Colors.grey),
                            ),
                            SizedBox(height: 20,),
                            Text("${(quran.getPlaceOfRevelation(widget.surah.id) == 'Makkah')?"MECCAN":"MEDINIAN"} - ${quran.getVerseCount(widget.surah.id).toString()} VERSES"),
                            SizedBox(height: 30,),
                            Text(quran.basmala, style: TextStyle(
                                fontSize: 34,
                                fontFamily: "AlQuran",
                                color: Colors.white
                            ))
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
                  children: List.generate(widget.surah.totalVerses,
                          (index) => Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                                  margin: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.purple.shade200.withOpacity(0.2) : Colors.blue.shade200.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.all(10),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(1000),
                                            color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue
                                        ),
                                        child: Center(child: Text("${index+1}", style: TextStyle(
                                            fontSize: 20
                                        ))),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        child: Icon(Icons.share_outlined, color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue,grade: 25,),
                                      ),
                                      GestureDetector(
                                        onTap: ()=>playArabicVerseAudio(quran.getAudioURLByVerse(widget.surah.id, index+1)),
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: Icon(CupertinoIcons.play,color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue),
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        child: Icon(CupertinoIcons.bookmark,color: Theme.of(context).brightness == Brightness.light ? Colors.purple : Colors.blue),
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(18),
                                  margin: EdgeInsets.only(left: 18, right: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(quran.getVerse(widget.surah.id, index+1),textDirection: TextDirection.rtl,textAlign: TextAlign.end, style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: "UthmaniScriptSemiBold"
                                      ),),
                                      SizedBox(height: 15,),
                                      Text(quran.getVerseTranslation(widget.surah.id, index+1), style: TextStyle(
                                          fontSize: 18
                                        // fontFamily: "AlQuran"
                                      ))
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Divider(height: 2, color: Colors.grey.withOpacity(0.5), thickness: 2,),
                          ),
                        ],
                      ))
              ),
              SizedBox(height: 50,)
            ],
          ),
        ));
  }

  void playArabicVerseAudio(String url) async{
    final player = AudioPlayer();
    await player.play(UrlSource(url));
  }
}


