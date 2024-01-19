import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/SearchResultsPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/searchBarWidgets/search_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchingPage extends StatefulWidget {
  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  FocusNode focusNode = FocusNode();
  bool focus = true;

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      focus = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      body: Column(
        children: [
          SizedBox(height: 50,),
          CustomSearchBar(focus: focus,onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchResultsPage()));},),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HexColor.fromHexStr(AppColor.primaryThemeSwatch4),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: ListView(
                  shrinkWrap: true,
                  children: List.generate(
                    20, // Increase the number of items to 100
                        (index) => ListTile(
                      leading: Icon(LineAwesomeIcons.history),
                      title: Text("This is the Search History Item ${index+1}. This is very long", overflow: TextOverflow.ellipsis,),
                      trailing: Icon(LineAwesomeIcons.arrow_right),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
