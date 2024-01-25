import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/hadithDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/extensions/string.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/secondary_loader.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_textfield.dart';

class AddUpdateHadithPage extends StatefulWidget {
  Hadith? hadith;
  bool isUpdate = false;

  AddUpdateHadithPage({this.hadith, this.isUpdate = false, super.key});

  @override
  State<AddUpdateHadithPage> createState() => _AddUpdateHadithPageState();
}

class _AddUpdateHadithPageState extends State<AddUpdateHadithPage> {
  late String imageUrl;
  late String oldID;

  TextEditingController hadithSourceTextEditingController =
      TextEditingController();
  TextEditingController hadithArabicTextEditingController =
      TextEditingController();
  TextEditingController hadithEnglishTextEditingController =
      TextEditingController();
  TextEditingController hadithIDTextEditingController = TextEditingController();
  TextEditingController hadithNumberTextEditingController =
      TextEditingController();
  TextEditingController hadithNarratedByTextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    HadithDataController hadithDataController = HadithDataController();

    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      appBar: AppBar(
        title: widget.isUpdate ? Text("Update Hadith") : Text("Add Hadith"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      ),
      body: widget.isUpdate
          ? FutureBuilder<Hadith>(
              future: hadithDataController.getHadithByID(widget.hadith!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SecondaryLoader(
                    loadingText: "Loading Hadith!\nPlease Wait!",
                  );
                } else if (snapshot.hasError) {
                  return CustomErrorWidget(
                    errorMessage: "Error!!!!!",
                  );
                } else {
                  Hadith hadith = snapshot.data!;
                  hadithIDTextEditingController.text = hadith.id;
                  oldID = hadith.id;
                  hadithSourceTextEditingController.text = hadith.source;
                  hadithArabicTextEditingController.text = hadith.arabicText;
                  hadithEnglishTextEditingController.text = hadith.englishText;
                  hadithNumberTextEditingController.text =
                      hadith.hadithNo.toString();
                  hadithNarratedByTextEditingController.text =
                      hadith.narratedBy!;

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomText(
                            "ID",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "SB 24:22",
                            false,
                            hadithIDTextEditingController,
                            value: hadithIDTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ID cannot be empty!';
                              }
                              if (!value.isHadithID()) {
                                return 'Invalid ID!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomText(
                            "Source",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "Sahih Bukhari",
                            false,
                            hadithSourceTextEditingController,
                            value: hadithSourceTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Source cannot be empty!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomText(
                            "Arabic Text",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "",
                            false,
                            hadithArabicTextEditingController,
                            value: hadithArabicTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Arabic Text be empty!';
                              }
                              if (!value.isArabic()) {
                                return 'Invalid Arabic Text!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomText(
                            "English Text",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "",
                            false,
                            hadithEnglishTextEditingController,
                            value: hadithEnglishTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'English Text cannot be empty!';
                              }
                              if (!value.isEnglish()) {
                                return 'Invalid English Text!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomText(
                            "Hadith Reference Number",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "",
                            false,
                            hadithNumberTextEditingController,
                            value: hadithNumberTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Reference Number cannot be empty!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomText(
                            "Narrated By",
                            20,
                            bold: true,
                          ),
                          CustomTextfield(
                            const Icon(
                              Icons.mosque_outlined,
                              color: Colors.black,
                            ),
                            "",
                            false,
                            hadithNarratedByTextEditingController,
                            value: hadithNarratedByTextEditingController.text,
                            validationCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Narration Reference cannot be empty!';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          CustomButton(
                            "Update Hadith",
                            () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                updateHadith(oldID);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomText(
                      "ID",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "SB 24:22",
                      false,
                      hadithIDTextEditingController,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ID cannot be empty!';
                        }
                        if (!value.isHadithID()) {
                          return 'Invalid ID!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomText(
                      "Source",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "Sahih Bukhari",
                      false,
                      hadithSourceTextEditingController,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Source cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomText(
                      "Arabic Text",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "",
                      false,
                      hadithArabicTextEditingController,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Arabic Text be empty!';
                        }
                        if (!value.isArabic()) {
                          return 'Invalid Arabic Text!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomText(
                      "English Text",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "",
                      false,
                      hadithEnglishTextEditingController,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'English Text cannot be empty!';
                        }
                        if (!value.isEnglish()) {
                          return 'Invalid English Text!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomText(
                      "Hadith Reference Number",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "",
                      false,
                      hadithNumberTextEditingController,
                      textInputType: TextInputType.number,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Reference Number cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomText(
                      "Narrated By",
                      20,
                      bold: true,
                    ),
                    CustomTextfield(
                      const Icon(
                        Icons.mosque_outlined,
                        color: Colors.black,
                      ),
                      "",
                      false,
                      hadithNarratedByTextEditingController,
                      validationCallback: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Narration Reference cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    CustomButton(
                      "Add Hadith",
                      () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          addHadith();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void addHadith() {
    HadithDataController hadithDataController = HadithDataController();
    Hadith hadith = Hadith(
        id: hadithIDTextEditingController.text,
        arabicText: hadithArabicTextEditingController.text,
        englishText: hadithEnglishTextEditingController.text,
        source: hadithSourceTextEditingController.text,
        hadithNo: int.parse(hadithNumberTextEditingController.text),
        narratedBy: hadithNarratedByTextEditingController.text);

    hadithDataController.addHadith(hadith);
  }

  void updateHadith(String oldID) {
    HadithDataController hadithDataController = HadithDataController();
    Hadith hadith = Hadith(
        id: hadithIDTextEditingController.text,
        arabicText: hadithArabicTextEditingController.text,
        englishText: hadithEnglishTextEditingController.text,
        source: hadithSourceTextEditingController.text,
        hadithNo: int.parse(hadithNumberTextEditingController.text),
        narratedBy: hadithNarratedByTextEditingController.text);

    hadithDataController.updateHadith(hadith, oldID);
  }
}

class RelatedItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const RelatedItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
    );
  }
}
