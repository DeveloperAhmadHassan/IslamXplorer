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
import 'package:islamxplorer_flutter/widgets/secondary_loader.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DuaListPage extends StatefulWidget {
  String title;
  String type;

  DuaListPage({super.key, this.title = "worship", this.type = "U"});

  @override
  State<DuaListPage> createState() => _DuaListPageState();
}

class _DuaListPageState extends State<DuaListPage> {
  bool isDeleting = false;

  final DuaDataController duaDataController = DuaDataController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    print(widget.title);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black.withOpacity(0.0002)
        ),
          title: Text("Duas", style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
          )),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Dua>>(
            future: widget.type == "A" ? duaDataController.fetchAllDuas() : duaDataController.fetchDuasFromTypes(widget.title),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SecondaryLoader(loadingText: "Loading Items\nPlease Wait");
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
            color: Theme.of(context).brightness == Brightness.dark
                ? HexColor.fromHexStr(AppColor.secondaryThemeSwatch4)
                : HexColor.fromHexStr(AppColor.secondaryThemeSwatch2),
            child: ListTile(
              leading: Icon(
                  Icons.mosque_outlined,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
              ),
              title: Text(widget.dua.title, style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
              )),
              subtitle: Text(widget.dua.englishText, overflow: TextOverflow.ellipsis, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
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
