import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:islamxplorer_flutter/controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/extensions/string.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/secondary_loader.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:quran/quran.dart' as quran;

import '../models/dua.dart';

class AddUpdateDuaPage extends StatefulWidget{
  Dua? dua;
  bool isUpdate = false;
  AddUpdateDuaPage({this.dua, this.isUpdate = false, super.key});

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
  static var _items = _types
      .map((item) => MultiSelectItem<DuaType>(item, item.name))
      .toList();
  List<Object?> _selectedTypes2 = [];
  List<DuaType> _selectedTypes5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedTypes5 = _types;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    DuaDataController duaDataController = DuaDataController();

    // print("${quran.getAudioURLByVerse(2, 5)}");
    // print("${quran.getVerse(2, 5,verseEndSymbol: true)}");
    // duaTitleTextEditingController.text = quran.getVerse(2, 5,verseEndSymbol: true);
    // print("${quran.getVerseTranslation(2, 5,verseEndSymbol: true, translation: quran.Translation.trSaheeh)}");
    // print("${quran.Translation}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.dark : Brightness.light,

          ),
          title: Text("Add Dua"),
        ),
        body: widget.isUpdate ?
        FutureBuilder<Dua>(
          future: duaDataController.getDuaByID(widget.dua!.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SecondaryLoader();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else{
              Dua? dua = snapshot.data;
              duaTitleTextEditingController.text = dua!.title;
              oldID = dua.id;
              duaArabicTextEditingController.text = dua!.arabicText!;
              duaEnglishTextEditingController.text = dua.englishText;
              duaExplanationTextEditingController.text = dua.explanation!;
              duaTransliterationEditingController.text = dua.transliteration!;
              duaVerseNumberTextEditingController.text = dua.verses!;
              selectedSurahNumber = dua.surah!;

              // verseNumberTextEditingController.text = verse..toString();

              return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children:<Widget> [
                        CustomText("Dua Title",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaTitleTextEditingController,
                          value: duaTitleTextEditingController.text,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title cannot be empty!';
                            }
                            return null;
                          },
                        ),
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
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaVerseNumberTextEditingController,
                          textInputType: TextInputType.number,
                          value: duaVerseNumberTextEditingController.text,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Verse number cannot be empty!';
                            }
                            int verseNumber = int.parse(value);
                            if (verseNumber == null || verseNumber <= 0 || verseNumber > totalVersesOfSelectedSurah) {
                              return 'Invalid verse number';
                            }
                            return null;
                          }),
                        Container(
                          height: 20,
                        ),
                        CustomText("Arabic Text",20, bold: true,),
                        CustomTextfield(
                            const Icon(Icons.mosque_outlined, color: Colors.black,),
                            "",
                            false,
                            duaArabicTextEditingController,
                            value: duaArabicTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Arabic Text cannot be empty!';
                              }
                              if(!value.isArabic()){
                                return 'Please enter valid Arabic Text!';
                              }
                              return null;
                            }),
                        Container(
                          height: 20,
                        ),
                        CustomText("English Text",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaEnglishTextEditingController,
                          value: duaEnglishTextEditingController.text,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'English Text cannot be empty!';
                            }
                            if(!value.isEnglish()){
                              return 'Please enter valid English Text!';
                            }
                            return null;
                          },),
                        Container(
                          height: 20,
                        ),
                        CustomText("Explanation",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaExplanationTextEditingController,
                          value: duaExplanationTextEditingController.text,
                        ),
                        Container(
                          height: 20,
                        ),
                        CustomText("Transliteration",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaTransliterationEditingController,
                          value: duaTransliterationEditingController.text,
                        ),
                        Container(
                          height: 20,
                        ),
                        // DuaTypes(types: duaTypes),
                        CustomButton(
                          "Add Dua",
                              () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              addDua();
                            }
                          },
                        )
                      ],
                    ),
                  )
              );
            }
            // else {
            //
            // }
          },
        ) :
        FutureBuilder<List<DuaType>>(
          future: duaDataController.fetchAllDuaTypes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SecondaryLoader(loadingText: "Loading\nPlease Wait");
            }
            else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            else{
              List<DuaType>? duaTypes = snapshot.data;

              _items = duaTypes!
                  .map((item) => MultiSelectItem<DuaType>(item, item.name))
                  .toList();

              return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children:<Widget> [
                        CustomText("Dua Title",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaTitleTextEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title cannot be empty!';
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CustomText("Surah",20, bold: true,),
                        DropdownButtonFormField<int>(
                          value: selectedSurahNumber,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                          ),
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
                        CustomTextfield(
                            const Icon(Icons.mosque_outlined, color: Colors.black,),
                            "",
                            false,
                            duaVerseNumberTextEditingController,
                            textInputType: TextInputType.number,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Verse number cannot be empty!';
                              }
                              int verseNumber = int.parse(value);
                              if (verseNumber == null || verseNumber <= 0 || verseNumber > totalVersesOfSelectedSurah) {
                                return 'Invalid verse number';
                              }
                              return null;
                            }),
                        Container(
                          height: 20,
                        ),
                        CustomText("Arabic Text",20, bold: true,),
                        CustomTextfield(
                            const Icon(Icons.mosque_outlined, color: Colors.black,),
                            "",
                            false,
                            duaArabicTextEditingController,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Arabic Text cannot be empty!';
                              }
                              if(!value.isArabic()){
                                return 'Please enter valid Arabic Text!';
                              }
                              return null;
                            }),
                        Container(
                          height: 20,
                        ),
                        CustomText("English Text",20, bold: true,),
                        CustomTextfield(
                          const Icon(Icons.mosque_outlined, color: Colors.black,),
                          "",
                          false,
                          duaEnglishTextEditingController,
                          validationCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'English Text cannot be empty!';
                            }
                            if(!value.isEnglish()){
                              return 'Please enter valid English Text!';
                            }
                            return null;
                          },),
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
                        DuaTypes(types: duaTypes),
                        CustomButton(
                          "Add Dua",
                              () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              addDua();
                            }
                          },
                        )
                      ],
                    ),
                  )
              );
            }
          },
        )
        ,
      ),
    );
  }
  void addDua(){
    DuaDataController duaDataController = DuaDataController();

    List<String> duaTypes = _selectedTypes2
        .whereType<String>()
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

  void updateDua(){
    DuaDataController duaDataController = DuaDataController();

    List<String> duaTypes = _selectedTypes2
        .whereType<String>()
        .toList();

    print(duaTypes);

    Dua dua = Dua(
        id: oldID,
        arabicText: duaArabicTextEditingController.text,
        englishText: duaEnglishTextEditingController.text,
        surah: surahs[selectedSurahNumber-1]["surahNumber"],
        title: duaTitleTextEditingController.text,
        explanation: duaExplanationTextEditingController.text,
        verses: duaVerseNumberTextEditingController.text,
        transliteration: duaTransliterationEditingController.text,
        types: duaTypes
    );

    duaDataController.updateDua(dua, oldID);
  }
}

class DuaTypes extends StatefulWidget{
  List<DuaType> types;
  DuaTypes({required this.types, super.key});

  @override
  State<DuaTypes> createState() => _DuaTypesState();
}

class _DuaTypesState extends State<DuaTypes> {
  static var _items;
  List<Object?> _selectedTypes2 = [];
  Color _color = Colors.transparent;
  
  @override
  void initState() {
    super.initState();
    _items = widget.types
        .map((item) => MultiSelectItem<DuaType>(item, item.name))
        .toList();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch3)
            : HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        border: Border.all(
          color: _color,
          width: 4,
        ),
      ),
      child: Column(
        children: <Widget>[
          MultiSelectBottomSheetField(
            validator: (values) {
              if (values == null || values.isEmpty) {
                setState(() {
                  _color = Colors.red;
                });
                return "Required";
              }
              setState(() {
                _color = Colors.transparent;
              });
              return null;
            },
            backgroundColor: Colors.blue.withOpacity(0.3),
            checkColor: Colors.black,
            selectedColor: Colors.yellow.shade100,
            selectedItemsTextStyle: TextStyle(
                color: Colors.black
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch3)
                  : HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
            ),

            initialChildSize: 0.4,
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text("Dua Types"),
            title: Text("Types"),
            items: _items,
            onConfirm: (values) {
              _selectedTypes2 = values;
              print("${values}");
              setState(() {

              });
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
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // border: Border.all(color: Colors.blue)
                  ),
                  child: Text(
                    "None selected",
                    style: Theme.of(context).brightness == Brightness.dark ? TextStyle(color: Colors.white54) : TextStyle(color: Colors.black54),
                  )
                )
              : Container(),
        ],
      ),
    );
  }
}

