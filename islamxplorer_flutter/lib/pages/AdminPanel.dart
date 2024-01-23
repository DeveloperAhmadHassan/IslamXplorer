import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/pages/HadithListPage.dart';
import 'package:islamxplorer_flutter/pages/VerseListPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: StaggeredGrid.count(
              crossAxisCount: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3),
                    elevation: 7,
                    child: Container(
                      child: Center(child: CustomText("Reports", 40, alignment: Alignment.center,)),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DuaListPage(type:"A") )),
                    child: Card(
                      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                      elevation: 7,
                      child: Container(
                        child: Center(child: CustomText("Duas", 40, alignment: Alignment.center,)),
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
                      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                      elevation: 7,
                      child: Container(
                        child: Center(child: CustomText("Verses", 40, alignment: Alignment.center,)),
                      ),
                    ),
                  )
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                    elevation: 7,
                    child: Container(
                      height: 200,
                      child: Center(child: CustomText("DuaType", 30, alignment: Alignment.center,bold: true,)),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HadithListPage() )),
                    child: Card(
                      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                      elevation: 7,
                      child: Container(
                        height: 200,
                        child: Center(child: CustomText("Hadiths", 40, alignment: Alignment.center,)),
                      ),
                    ),
                  )
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Card(
                    color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
                    elevation: 7,
                    child: Container(
                      height: 200,
                      child: Center(child: CustomText("Surah", 40, alignment: Alignment.center,)),
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
                      child: Center(child: CustomText("Ontology", 30, alignment: Alignment.center,)),
                    ),
                  ),
                ),
                // StaggeredGridTile.count(
                //   crossAxisCellCount: 2,
                //   mainAxisCellCount: 1,
                //   child: Tile(index: 1),
                // ),
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