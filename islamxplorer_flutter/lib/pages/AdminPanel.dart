import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:islamxplorer_flutter/Controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/pages/HadithListPage.dart';
import 'package:islamxplorer_flutter/pages/VerseListPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
// import 'package:islamxplorer_flutter/controllers/duaDataController.dart';

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

class DuaGrid extends StatelessWidget {
  DuaDataController duaDataController = DuaDataController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DuaType>>(
      future: duaDataController.fetchAllDuaTypes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        } else {
          return Expanded(
            child: MasonryGridView.count(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return DuaItemCard(duaType: snapshot.data![index]);
              }, crossAxisCount: 2,
            ),
          );
        }
      },
    );
  }
}

class DuaItemCard extends StatelessWidget {
  final DuaType duaType;

  const DuaItemCard({Key? key, required this.duaType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var duaNum = 0;
    var newDua = false;
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => DuaListPage(title: duaType.name,)))},
      child: Card(
        elevation: 12,
        shadowColor: Colors.black,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 190,
          height: duaType.height.toDouble(),
          color: Color.fromRGBO(246, 237, 151, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.amberAccent,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          newDua ? const NewTag() : Container(),
                        ],
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(duaType.url, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    duaType.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$duaNum Duas",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IBMPlexMono',
                          ),
                        ),
                      ),
                      Icon(Icons.share_outlined, color: Colors.indigo),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
