import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/pages/SearchItemPage.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/dummy_search_bar.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_appbar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchResultsPage extends StatefulWidget{
  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  int filterSelectedIndex = 0;
  final filterItems=[
    "All",
    "Verses",
    "Hadiths"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: SecondaryAppBar(""),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: [
            DummySearchBar(),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.topLeft,
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(3, (index) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: CustomText(
                        filterItems[index],
                        18,
                        color: index == filterSelectedIndex ? Colors.black : Colors.black45,
                        underline: index == filterSelectedIndex,
                      ),),
                    onTap: (){
                        setState(() {
                          filterSelectedIndex=index;
                        });
                    },
                  );
                },
              ),
             ),
            ),
            SizedBox(height: 20,),
            for(var i=0;i<15;i++)
              Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: ListTile(
                title: Text("Surah Baqarah"),
                subtitle: Text("Indeed Allah hath power over everything", overflow: TextOverflow.ellipsis),
                leading: Text("2:45"),
                trailing: Icon(LineAwesomeIcons.vertical_ellipsis),
                tileColor: Colors.amber,
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchItemPage())),
              ),
            ),
          ],
        ),
      )

    );
  }
}