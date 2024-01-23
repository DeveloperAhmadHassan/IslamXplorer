import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/verseDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';

import '../models/verse.dart';

class AddUpdateVersePage extends StatefulWidget{
  Verse? verse;
  bool isUpdate = false;
  AddUpdateVersePage({this.verse, this.isUpdate = false, super.key});

  @override
  State<AddUpdateVersePage> createState() => _AddUpdateVersePageState();
}

class _AddUpdateVersePageState extends State<AddUpdateVersePage> {
  late String imageUrl;
  late String oldID;

  TextEditingController verseArabicTextEditingController = TextEditingController();
  TextEditingController verseEnglishTextEditingController = TextEditingController();
  TextEditingController verseIDTextEditingController = TextEditingController();
  TextEditingController verseNumberTextEditingController = TextEditingController();


  static List<Map<String, dynamic>> surahs = [
    {"surahNumber": 1, "surahName": "Al-Fatiha", "totalVerses": 7},
    {"surahNumber": 2, "surahName": "Al-Baqarah", "totalVerses": 286},
  ];

  int selectedSurahNumber = surahs[0]["surahNumber"];
  int totalVersesOfSelectedSurah = surahs[0]["totalVerses"];

  Widget build(BuildContext context) {
    VerseDataController verseDataController = VerseDataController();

    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      appBar: AppBar(
        title: Text("Add Verse"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      ),
      body:  widget.isUpdate ?
      FutureBuilder<Verse>(
        future: verseDataController.getVerseByID(widget.verse!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            // Populate the TextEditingController with fetched data
            Verse verse = snapshot.data!;
            verseIDTextEditingController.text = verse.id;
            oldID = verse.id;
            verseArabicTextEditingController.text = verse.arabicText;
            verseEnglishTextEditingController.text = verse.englishText;
            // verseNumberTextEditingController.text = verse..toString();

            return SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomText("Surah",20, bold: true,),
                  DropdownButtonFormField<int>(
                    value: selectedSurahNumber,
                    onChanged: (int? newSurahNumber) {
                      setState(() {
                        selectedSurahNumber = newSurahNumber!;
                        totalVersesOfSelectedSurah = surahs[selectedSurahNumber]["totalVerses"];
                      });
                    },
                    items: surahs.map((Map<String, dynamic> surah) {
                      return DropdownMenuItem<int>(
                        value: surah["surahNumber"],
                        child: Text("${surah["surahNumber"]}. ${surah["surahName"]}"),
                      );
                    }).toList(),
                  ),
                  Container(
                    height: 20,
                  ),
                  CustomText("Verse Number",20, bold: true,),
                  TextFormField(
                    controller: verseNumberTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mosque_outlined, color: Colors.black),
                      hintText: "Enter Verse Number",
                      filled: true,
                      fillColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      //   borderSide: const BorderSide(color: Colors.amberAccent),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Verse number cannot be empty';
                      }
                      int verseNumber = int.parse(value);
                      if (verseNumber == null || verseNumber <= 0 || verseNumber > totalVersesOfSelectedSurah) {
                        return 'Invalid verse number';
                      }
                      return null;
                    },
                  ),
                  // CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,hadithArabicTextEditingController),
                  Container(
                    height: 20,
                  ),
                  CustomText("Arabic Text",20, bold: true,),
                  CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseArabicTextEditingController),
                  Container(
                    height: 20,
                  ),
                  CustomText("English Text",20, bold: true,),
                  CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseEnglishTextEditingController),
                  Container(
                    height: 20,
                  ),
                  CustomButton("Update Verse", ()=>updateVerse(oldID))
                ],
              ),
            );
          }
        },
      ) :
      SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText("Surah",20, bold: true,),
            DropdownButtonFormField<int>(
              value: selectedSurahNumber,
              onChanged: (int? newSurahNumber) {
                setState(() {
                  selectedSurahNumber = newSurahNumber!;
                  totalVersesOfSelectedSurah = surahs[selectedSurahNumber]["totalVerses"];
                });
              },
              items: surahs.map((Map<String, dynamic> surah) {
                return DropdownMenuItem<int>(
                  value: surah["surahNumber"],
                  child: Text("${surah["surahNumber"]}. ${surah["surahName"]}"),
                );
              }).toList(),
            ),
            Container(
              height: 20,
            ),
            CustomText("Verse Number",20, bold: true,),
            TextFormField(
              controller: verseNumberTextEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mosque_outlined, color: Colors.black),
                hintText: "Enter Verse Number",
                filled: true,
                fillColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20),
                //   borderSide: const BorderSide(color: Colors.amberAccent),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 3),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Verse number cannot be empty';
                }
                int verseNumber = int.parse(value);
                if (verseNumber == null || verseNumber <= 0 || verseNumber > totalVersesOfSelectedSurah) {
                  return 'Invalid verse number';
                }
                return null;
              },
            ),
            // CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,hadithArabicTextEditingController),
            Container(
              height: 20,
            ),
            CustomText("Arabic Text",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseArabicTextEditingController),
            Container(
              height: 20,
            ),
            CustomText("English Text",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseEnglishTextEditingController),
            Container(
              height: 20,
            ),
            CustomButton("Add Verse", addVerse)
          ],
        ),
      ),

    );
  }
  void addVerse(){
    VerseDataController verseDataController = VerseDataController();
    Verse verse = Verse(
        id: "${surahs[selectedSurahNumber]["surahNumber"]-1}:${verseNumberTextEditingController.text.toString()}",
        arabicText: verseArabicTextEditingController.text,
        englishText: verseEnglishTextEditingController.text,
        surah: surahs[selectedSurahNumber]["surahName"],
        surahNumber: surahs[selectedSurahNumber]["surahNumber"]-1
    );

    verseDataController.addVerse(verse);
  }

  void updateVerse(String oldID){
    VerseDataController verseDataController = VerseDataController();
    Verse verse = Verse(
        id: oldID,
        arabicText: verseArabicTextEditingController.text,
        englishText: verseEnglishTextEditingController.text,
        surah: surahs[selectedSurahNumber-1]["surahName"],
        surahNumber: surahs[selectedSurahNumber-1]["surahNumber"]
    );

    verseDataController.updateVerse(verse, oldID);
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

