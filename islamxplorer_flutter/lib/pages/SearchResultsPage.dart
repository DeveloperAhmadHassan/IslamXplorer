import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/controllers/resultsDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/hadith.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';
import 'package:islamxplorer_flutter/models/verse.dart';
import 'package:islamxplorer_flutter/pages/SearchItemPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/searchBarWidgets/dummy_search_bar.dart';
import 'package:islamxplorer_flutter/widgets/utils/secondary_appbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class SearchResultsPage extends StatefulWidget {
  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  int filterSelectedIndex = 0;
  final filterItems = ["All", "Verses", "Hadiths"];

  List<SearchResultItem> searchResults = [];

  @override
  void initState() {
    super.initState();
    print("Init");
    fetchResults();
  }

  Future<void> fetchResults() async {
    ResultsDataController resultsDataController = ResultsDataController();
    // try {
      final results = await resultsDataController.fetchAllResults();
      setState(() {
        searchResults = results;
      });
    // } catch (e) {
    //   // Handle errors if necessary
    //   print('Error fetching results: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    List<SearchResultItem> filteredResults;

    switch (filterSelectedIndex) {
      case 1: // Verses
        filteredResults = searchResults.where((result) => result is Verse).toList();
        break;
      case 2: // Hadiths
        filteredResults = searchResults.where((result) => result is Hadith).toList();
        break;
      default: // All
        filteredResults = List.from(searchResults);
        break;
    }

    return Scaffold(
      backgroundColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch1),
      appBar: SecondaryAppBar(""),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: [
            DummySearchBar(),
            SizedBox(height: 20),
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
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        filterSelectedIndex = index;
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            for (var result in filteredResults)
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: Card(
                  color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                  elevation: 7,
                  child: ListTile(
                    title: Text("${result.sTitle}", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    )),
                    subtitle: Text("${result.sSubtitle}", overflow: TextOverflow.ellipsis, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                    leading: Text("${result.sID}", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    )),
                    trailing: Icon(LineAwesomeIcons.vertical_ellipsis),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchItemPage(searchResultItem: result),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}
