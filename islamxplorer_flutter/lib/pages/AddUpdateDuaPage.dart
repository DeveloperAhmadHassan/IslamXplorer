import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/Controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/Controllers/hadithDataController.dart';
import 'package:islamxplorer_flutter/Controllers/verseDataController.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/widgets/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/custom_textfield.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../models/dua.dart';
import '../models/verse.dart';

class AddUpdateDuaPage extends StatefulWidget{
  Verse? verse;
  bool isUpdate = false;
  AddUpdateDuaPage({this.verse, this.isUpdate = false, super.key});

  @override
  State<AddUpdateDuaPage> createState() => _AddUpdateDuaPageState();
}

class _AddUpdateDuaPageState extends State<AddUpdateDuaPage> {
  late String imageUrl;
  late String oldID;

  TextEditingController duaArabicTextEditingController = TextEditingController();
  TextEditingController duaEnglishTextEditingController = TextEditingController();
  TextEditingController duaIDTextEditingController = TextEditingController();
  TextEditingController duaVerseNumberTextEditingController = TextEditingController();
  TextEditingController duaExplanationTextEditingController = TextEditingController();
  TextEditingController duaTransliterationEditingController = TextEditingController();
  TextEditingController duaTitleTextEditingController = TextEditingController();
  // TextEditingController duaNumberTextEditingController = TextEditingController();

  static List<Map<String, dynamic>> surahs = [
    {"surahNumber": 1, "surahName": "Al-Fatiha", "totalVerses": 7},
    {"surahNumber": 2, "surahName": "Al-Baqarah", "totalVerses": 286},
  ];

  int selectedSurahNumber = surahs[0]["surahNumber"];
  int totalVersesOfSelectedSurah = surahs[0]["totalVerses"];

  static List<DuaType> _types = [
    DuaType.withName(name: "worship"),
    DuaType.withName(name: "forgiveness"),
    DuaType.withName(name: "confidence"),
    DuaType.withName(name: "hope")
  ];
  final _items = _types
      .map((item) => MultiSelectItem<DuaType>(item, item.name))
      .toList();
  List<Object?> _selectedTypes2 = [];
  List<DuaType> _selectedTypes5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedTypes5 = _types;
    super.initState();
  }

  Widget build(BuildContext context) {
    VerseDataController verseDataController = VerseDataController();

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Add Dua"),
      ),
      body:
      // widget.isUpdate ?
      // FutureBuilder<Verse>(
      //   future: verseDataController.getVerseByID(widget.verse!.id),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text("Error: ${snapshot.error}");
      //     } else {
      //       // Populate the TextEditingController with fetched data
      //       Verse verse = snapshot.data!;
      //       verseIDTextEditingController.text = verse.id;
      //       oldID = verse.id;
      //       verseArabicTextEditingController.text = verse.arabicText;
      //       verseEnglishTextEditingController.text = verse.englishText;
      //       // verseNumberTextEditingController.text = verse..toString();
      //
      //       return SingleChildScrollView(
      //         padding: EdgeInsets.all(10),
      //         child: Column(
      //           children: [
      //             CustomText("Surah",20, bold: true,),
      //             DropdownButtonFormField<int>(
      //               value: selectedSurahNumber,
      //               onChanged: (int? newSurahNumber) {
      //                 setState(() {
      //                   selectedSurahNumber = newSurahNumber!;
      //                   totalVersesOfSelectedSurah = surahs[selectedSurahNumber]["totalVerses"];
      //                 });
      //               },
      //               items: surahs.map((Map<String, dynamic> surah) {
      //                 return DropdownMenuItem<int>(
      //                   value: surah["surahNumber"],
      //                   child: Text("${surah["surahNumber"]}. ${surah["surahName"]}"),
      //                 );
      //               }).toList(),
      //             ),
      //             Container(
      //               height: 20,
      //             ),
      //             CustomText("Verse Number",20, bold: true,),
      //             TextFormField(
      //               controller: verseNumberTextEditingController,
      //               keyboardType: TextInputType.number,
      //               decoration: InputDecoration(
      //                 prefixIcon: const Icon(Icons.mosque_outlined, color: Colors.black),
      //                 hintText: "Enter Verse Number",
      //                 filled: true,
      //                 fillColor: Colors.amberAccent,
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(20),
      //                   borderSide: const BorderSide(color: Colors.amberAccent),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(20),
      //                   borderSide: const BorderSide(color: Colors.amberAccent),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(20),
      //                   borderSide: const BorderSide(color: Colors.amberAccent, width: 3),
      //                 ),
      //               ),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'Verse number cannot be empty';
      //                 }
      //                 int verseNumber = int.parse(value);
      //                 if (verseNumber == null || verseNumber <= 0 || verseNumber > totalVersesOfSelectedSurah) {
      //                   return 'Invalid verse number';
      //                 }
      //                 return null;
      //               },
      //             ),
      //             // CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,hadithArabicTextEditingController),
      //             Container(
      //               height: 20,
      //             ),
      //             CustomText("Arabic Text",20, bold: true,),
      //             CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseArabicTextEditingController),
      //             Container(
      //               height: 20,
      //             ),
      //             CustomText("English Text",20, bold: true,),
      //             CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,verseEnglishTextEditingController),
      //             Container(
      //               height: 20,
      //             ),
      //             CustomButton("Update Verse", ()=>updateVerse(oldID))
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ) :
      SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children:<Widget> [
            CustomText("Dua Title",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,duaTitleTextEditingController),
            Container(
              height: 20,
            ),
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
              controller: duaVerseNumberTextEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mosque_outlined, color: Colors.black),
                hintText: "Enter Verse Number",
                filled: true,
                fillColor: Colors.amberAccent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.amberAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.amberAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.amberAccent, width: 3),
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
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,duaArabicTextEditingController),
            Container(
              height: 20,
            ),
            CustomText("English Text",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,duaEnglishTextEditingController),
            Container(
              height: 20,
            ),
            CustomText("Explanation",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,duaExplanationTextEditingController),
            Container(
              height: 20,
            ),
            CustomText("Transliteration",20, bold: true,),
            CustomTextfield(const Icon(Icons.mosque_outlined, color: Colors.black,), "", false,duaTransliterationEditingController),
            Container(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: Text("Dua Types"),
                    title: Text("Types"),
                    items: _items,
                    onConfirm: (values) {
                      _selectedTypes2 = values;
                      print("${values}");
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _selectedTypes2.remove(value);
                        });
                      },
                    ),
                  ),
                  _selectedTypes2 == null || _selectedTypes2.isEmpty
                      ? Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "None selected",
                        style: TextStyle(color: Colors.black54),
                      ))
                      : Container(),
                ],
              ),
            ),
            CustomButton("Add Dua", addDua)
          ],
        ),
      ),

    );
  }
  void addDua(){
    DuaDataController duaDataController = DuaDataController();

    List<String> duaTypes = _selectedTypes2
        .whereType<String>() // Filter out non-null values of type String
        .toList();

    print(duaTypes);

    Dua dua = Dua(
        id: "0",
        arabicText: duaArabicTextEditingController.text,
        englishText: duaEnglishTextEditingController.text,
        surah: surahs[selectedSurahNumber]["surahNumber"],
        title: duaTitleTextEditingController.text,
        explanation: duaExplanationTextEditingController.text,
        transliteration: duaTransliterationEditingController.text,
        verses: duaVerseNumberTextEditingController.text,
        types: duaTypes
    );
    duaDataController.addDua(dua);
    // print(_selectedTypes2);
  }

  void updateVerse(String oldID){
    VerseDataController verseDataController = VerseDataController();
    Verse verse = Verse(
        id: oldID,
        arabicText: duaArabicTextEditingController.text,
        englishText: duaEnglishTextEditingController.text,
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

