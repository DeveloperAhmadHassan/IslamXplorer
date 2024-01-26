import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:islamxplorer_flutter/controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/extensions/string.dart';
import 'package:islamxplorer_flutter/models/duaType.dart';
import 'package:islamxplorer_flutter/pages/DuaListPage.dart';
import 'package:islamxplorer_flutter/utils/dataLoaders.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';


class DuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Started!");
    DataLoader.loadTermsAndConditions();
    print("Finished!");
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      appBar: AppBar(
        backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        ),
        toolbarHeight: 65,
        title: Row(
          children: [
            const SizedBox(width: 70,),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: const Text("Duas", style: TextStyle(
                fontSize: 35,
              )),
            )
          ],
        ),
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
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitWave(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30,),
                  Text("Loading Item. Please Wait", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ))
                ],
              ),
            ),
          );
        }
        else if (snapshot.hasError) {
          return CustomErrorWidget(errorMessage: "Error!!!!!",);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return CustomErrorWidget(errorMessage: "Error!!!!!",);
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
