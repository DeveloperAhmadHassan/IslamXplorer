import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:islamxplorer_flutter/Controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/extensions/string.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
// import 'package:islamxplorer_flutter/controllers/duaDataController.dart';

class DuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      appBar: AppBar(
        title: Text("Duas"),
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DuaGrid(),
      ),
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
          color: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Colors.amberAccent,
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    duaType.name.capitalizeFirstLetter,
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
