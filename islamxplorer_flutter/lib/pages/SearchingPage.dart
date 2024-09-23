import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/SearchResultsPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
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
      body: Column(
        children: [
          SizedBox(height: 50,),
          CustomSearchBar(
            focus: focus,
            onTap: (String q){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchResultsPage(q: q,)));}),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: ListView(
                  shrinkWrap: true,
                  children: List.generate(
                    20, // Increase the number of items to 100
                        (index) => ListTile(
                      leading: Icon(LineAwesomeIcons.history, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                      title: Text(
                        "This is the Search History Item ${index+1}. This is very long",
                        style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                        ),
                        overflow: TextOverflow.ellipsis,),
                      trailing: Icon(LineAwesomeIcons.arrow_right,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
