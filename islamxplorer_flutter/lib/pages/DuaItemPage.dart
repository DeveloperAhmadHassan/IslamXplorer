import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islamxplorer_flutter/controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/utils/alertDialogs.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/strings.dart';
import 'package:islamxplorer_flutter/widgets/bookmarkWidget/bookmarkItem.dart';
import 'package:islamxplorer_flutter/widgets/curved_edges.dart';
import 'package:islamxplorer_flutter/widgets/secondary_loader.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/reportWidget/reportItem.dart';
import 'package:islamxplorer_flutter/widgets/shareWidget/shareItem.dart';

import '../models/dua.dart';

class DuaItemPage extends StatefulWidget{
  DuaItemPage({required this.dua, super.key});
  DuaDataController duaDataController = DuaDataController();
  Dua dua;

  @override
  State<DuaItemPage> createState() => _DuaItemPageState();
}

class _DuaItemPageState extends State<DuaItemPage> {
  late String imageUrl;

  Widget build(BuildContext context) {

    return FutureBuilder<Dua>(
      future: widget.duaDataController.getDuaByID(widget.dua.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: SecondaryLoader(loadingText: "Loading Item\nPlease Wait"),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot}'),
          );
        } else {
          final Dua dua = snapshot.data?? widget.dua;
          return Scaffold(
            // backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: -200,
                    right: -250,
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Theme.of(context).colorScheme.primaryContainer
                      ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    left: -300,
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Theme.of(context).colorScheme.primaryContainer
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -130,
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Theme.of(context).colorScheme.primaryContainer
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: -290,
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Theme.of(context).colorScheme.primaryContainer
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -250,
                    right: -230,
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Theme.of(context).colorScheme.primaryContainer
                      ),
                    ),
                  ),
                  Container(
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    AppString.duaBGUrl
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                        // color: Colors.green,
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
                                    child: BookmarkItem(item: dua),
                                  ),
                                  SizedBox(width: 15,),
                                  Container(
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                        color: Colors.white.withOpacity(0.7)
                                    ),
                                    // color: Colors.white,
                                    child: ShareItem(),
                                  ),
                                  SizedBox(width: 15,),
                                  Container(
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                        color: Colors.white.withOpacity(0.7)
                                    ),
                                    // color: Colors.white,
                                    child: ReportItem(item: dua,),
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
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              elevation: 7,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text("${dua.title}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700
                                      ), textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 7,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch4)
                                  : HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text("${dua.arabicText}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700
                                      ), textDirection: TextDirection.rtl),
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
                              elevation: 7,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch4)
                                  : HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text("${dua.englishText}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700
                                      )),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 7,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch4)
                                  : HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text("${dua.transliteration}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                CustomText('Explanation', 24, color: Colors.blueAccent, bold: true,underline: true,onTap: ()=>seeExp(context, dua.explanation),)
                              ],
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                ],
              ),
            ),

          );
        }
      },
    );
  }

  void seeExp(BuildContext context, String? exp) {
    AlertDialogs.showDuaExplanationDialog(exp ?? "No Explanation Found!");
  }

  void toggleBookmarks(String id, BuildContext context) async{
    UserDataController userDataController = UserDataController();
    if(widget.dua.isBookmarked){
      var result = userDataController.removeBookmark(id);
      if(await result){
        widget.dua.isBookmarked = false;
        setState(() {

        });
      }
    } else {
      var result = userDataController.addBookmark(id);
      if(await result){
        widget.dua.isBookmarked = true;
        setState(() {

        });
      }
    }
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
