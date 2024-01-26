import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islamxplorer_flutter/controllers/duaDataController.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/dua.dart';
import 'package:islamxplorer_flutter/pages/AddUpdateDuaPage.dart';
import 'package:islamxplorer_flutter/pages/DuaItemPage.dart';
import 'package:islamxplorer_flutter/utils/alertDialogs.dart';
import 'package:islamxplorer_flutter/utils/snackBars.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DuaListPage extends StatefulWidget {
  String title;
  String type;

  DuaListPage({this.title = "worship", this.type = "U"});

  @override
  State<DuaListPage> createState() => _DuaListPageState();
}

class _DuaListPageState extends State<DuaListPage> {
  bool isDeleting = false;

  final DuaDataController duaDataController = DuaDataController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);


    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black.withOpacity(0.0002)
        ),
          title: Text("Duas"),
          backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Dua>>(
            future: widget.type == "A" ? duaDataController.fetchAllDuas() : duaDataController.fetchDuasFromTypes(widget.title),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
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
                  );
              }
              else if (snapshot.hasError) {
                return CustomErrorWidget(errorMessage: "Error!!!!!",);
              } else {
                final List<Dua> duas = snapshot.data ?? [];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        widget.type == "A" ? CustomButton("Add Dua", ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateDuaPage()))) : Container(),
                        Cards(duas: duas, type: widget.type=="A"? "A":"U",),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final List<Dua> duas;
  String type = "U";

  Cards({Key? key, required this.duas, this.type = "U"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var dua in duas)
          DuaCard(dua: dua, type: type),
      ],
    );
  }
}

class DuaCard extends StatefulWidget {
  final Dua dua;
  String type;

  DuaCard({Key? key, required this.dua, required this.type}) : super(key: key);

  @override
  State<DuaCard> createState() => _DuaCardState();
}

class _DuaCardState extends State<DuaCard> {

  @override
  void initState() {
    super.initState();
    setBookmark(widget.dua.id);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DuaItemPage(dua: widget.dua),
            ),
          ),
          child: Card(
            elevation: 7,
            color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
            child: ListTile(
              leading: Icon(Icons.mosque_outlined),
              title: Text(widget.dua.title, style: TextStyle(
                fontWeight: FontWeight.w600
              )),
              subtitle: Text(widget.dua.englishText, overflow: TextOverflow.ellipsis, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17
              )),
              trailing: widget.type == "A"
                ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateDuaPage(dua: widget.dua, isUpdate: true,))),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Icon(Icons.update),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: ()=>{deleteDua(widget.dua.id, context)},
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Icon(Icons.delete),
                    ),
                  )
                ],
              )
                : const Icon(LineAwesomeIcons.vertical_ellipsis),
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  void deleteDua(String id, BuildContext context) async {
    DuaDataController duaDataController = DuaDataController();

    bool confirmDelete = await AlertDialogs.showDeleteItemAlertDialog(context);

    if (confirmDelete == true) {
      SnackBars.showWaitingSnackBar(context, "Deleting Item.....");
      var result = await duaDataController.deleteDua(id);

      if (result) {
        SnackBars.showSuccessSnackBar(context,"Sucessfully Deleted Item!");
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DuaListPage(type: "A")),
        );
      } else {
        SnackBars.showFailureSnackBar(context, "Failed To Delete Item!");
      }
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      setState(() {

      });
    }
  }

  void setBookmark(String id) async{
    UserDataController userDataController = UserDataController();
    if(await userDataController.isBookmarked(id)){
      widget.dua.updateBookmarkStatus(true);
      print("S: ${widget.dua.sIsBookmarked}");
      print("Dua: ${widget.dua.isBookmarked}");

    } else {
      widget.dua.updateBookmarkStatus(false);
    }
  }
}
