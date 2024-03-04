import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamxplorer_flutter/models/surah.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:quran/quran.dart' as quran;

class SurahHomePage extends StatefulWidget {
  final Surah surah;

  const SurahHomePage({super.key, required this.surah});

  @override
  State<SurahHomePage> createState() => _SurahHomePageState();
}

class _SurahHomePageState extends State<SurahHomePage> {
  final player = AudioPlayer();

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
                margin: const EdgeInsets.all(20),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: Theme.of(context).brightness == Brightness.light ? AppColor.secondaryLinearGradientSwatch2 : AppColor.secondaryLinearGradientSwatch1,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        right: -60,
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Opacity(
                              opacity: 0.3,
                              child: Image.asset('assets/quran_v1_nobg.png')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(quran.getSurahName(widget.surah.id),
                                style: const TextStyle(fontSize: 24)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(quran.getSurahNameEnglish(widget.surah.id),
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 70, right: 70),
                              child: Divider(height: 3, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "${(quran.getPlaceOfRevelation(widget.surah.id) == 'Makkah') ? "MECCAN" : "MEDINIAN"} - ${quran.getVerseCount(widget.surah.id).toString()} VERSES"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(quran.basmala,
                                style: TextStyle(
                                    fontSize: 34,
                                    fontFamily: "AlQuran",
                                    color: Colors.white))
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
                      widget.surah.totalVerses,
                      (index) => Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 15),
                                      margin: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.purple.shade200
                                                .withOpacity(0.2)
                                            : Colors.blue.shade200
                                                .withOpacity(0.2),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            // padding: EdgeInsets.all(10),
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.purple
                                                    : Colors.blue),
                                            child: Center(
                                                child: Text("${index + 1}",
                                                    style: const TextStyle(
                                                        fontSize: 20))),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Icon(
                                              Icons.share_outlined,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.purple
                                                  : Colors.blue,
                                              grade: 25,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await player.stop();
                                              await player.play(UrlSource(
                                                  quran.getAudioURLByVerse(
                                                      widget.surah.id,
                                                      index + 1)));
                                            },
                                            child: SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: Icon(CupertinoIcons.play,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.purple
                                                      : Colors.blue),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Icon(CupertinoIcons.bookmark,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.purple
                                                    : Colors.blue),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // padding: EdgeInsets.all(18),
                                      margin: const EdgeInsets.only(
                                          left: 18, right: 18),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            quran.getVerse(
                                                widget.surah.id, index + 1),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontFamily:
                                                    "UthmaniScriptSemiBold"),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                              quran.getVerseTranslation(
                                                  widget.surah.id, index + 1),
                                              style:
                                                  const TextStyle(fontSize: 18))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Divider(
                                  height: 2,
                                  color: Colors.grey.withOpacity(0.5),
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ))),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
