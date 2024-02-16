import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/pages/HadithListPage.dart';
import 'package:islamxplorer_flutter/pages/VerseListPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:badges/badges.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            children: [
              const SizedBox(width: 70,),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: const Text("Home", style: TextStyle(
                  fontSize: 35,
                )),
              )
            ],
          ),
        ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: StaggeredGrid.count(
              crossAxisCount: 4,
              children: [
                DynamicBadgeExample(),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DuaListPage(type:"A") )),
                    child: Card(
                      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                      elevation: 7,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 80,
                              right: -70,
                              child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset('assets/dua_v1.png')
                              )
                          ),
                          Positioned(
                              bottom: 90,
                              left: -100,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              )
                          ),
                          Center(child: CustomText("Duas", 40, alignment: Alignment.center, color: Colors.black,)),
                        ],
                      ),
                    ),
                  )
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VerseListPage() )),
                    child: Card(
                      color: Colors.red.shade50,
                      elevation: 7,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 120,
                              left: -70,
                              child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset('assets/prayer_mat_v2.png')
                              )
                          ),
                          Positioned(
                              bottom: 130,
                              right: -140,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              )
                          ),
                          Center(child: CustomText("Verses", 40, alignment: Alignment.center, color: Colors.black,)),
                        ],
                      ),
                    ),
                  )
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: Colors.green.shade100,
                    elevation: 7,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 60,
                            left: -70,
                            child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.asset('assets/masjid_v1.png')
                            )
                        ),
                        Positioned(
                            bottom: 90,
                            right: -100,
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            )
                        ),
                        Center(child: CustomText("DuaType", 30, alignment: Alignment.center,bold: true, color: Colors.black,)),
                      ],
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HadithListPage() )),
                    child: Card(
                      color: Colors.yellow.shade100,
                      elevation: 7,
                      child: SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 120,
                                right: -40,
                                child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset('assets/man_praying_v1.png')
                                )
                            ),
                            Positioned(
                                bottom: 130,
                                left: -100,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade50,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                )
                            ),
                            Center(child: CustomText("Hadiths", 40, alignment: Alignment.center, color: Colors.black,)),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: Colors.orange.shade100,
                    elevation: 7,
                    child: Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 40,
                              left: -60,
                              child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset('assets/man_praying_v2.png')
                              )
                          ),
                          Positioned(
                              bottom: 130,
                              right: -100,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade50,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              )
                          ),
                          Center(child: CustomText("Surahs", 40, alignment: Alignment.center, color: Colors.black,)),
                        ],
                      ),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                    elevation: 7,
                    child: Container(
                      height: 200,
                      child: Center(child: CustomText("Ontology", 30, alignment: Alignment.center, color: Colors.black,)),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3.5,
                  child: Container(),
                ),
                // StaggeredGridTile.count(
                //   crossAxisCellCount: 1,
                //   mainAxisCellCount: 1,
                //   child: Tile(index: 2),
                // ),
                // StaggeredGridTile.count(
                //   crossAxisCellCount: 1,
                //   mainAxisCellCount: 1,
                //   child: Tile(index: 3),
                // ),
                // StaggeredGridTile.count(
                //   crossAxisCellCount: 4,
                //   mainAxisCellCount: 2,
                //   // child: Tile(index: 4),
                // ),
              ],
            )
        ),
      )
    );
  }
}

class DynamicBadgeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Reports').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitWave(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                ),
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final int? documentCount = snapshot.data?.docs.length;
        return StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: Card(
            color: Colors.red.shade300,
            elevation: 7,
            child: Badge(
              badgeContent: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  documentCount.toString(),
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                  ),
                ),
              ),
              position: BadgePosition.topStart(top: -30),
              badgeAnimation: const BadgeAnimation.scale(),
              child: Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: -60,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/quran_v1.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    right: -100,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomText(
                      "Reports",
                      40,
                      alignment: Alignment.center,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}