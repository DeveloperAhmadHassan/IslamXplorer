import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';

import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/values/assets.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class DummySearchBar extends StatefulWidget {
  @override
  _DummySearchBarState createState() => _DummySearchBarState();
}

class _DummySearchBarState extends State<DummySearchBar> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // isClicked = !isClicked;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchingPage()));
      },
      onHover: (val){
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width-30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isClicked ? Colors.grey : HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                AppAsset.defaultLogo,
                width: 20,
                height: 20,
                fit: BoxFit.fill,
              ),
            ),
            const Text("Search", style: TextStyle()),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: ColorChangeContainer(),
//     ),
//   ));
// }
