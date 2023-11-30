import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/dua_card.dart';

class DuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: CustomAppBar("Duas"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Cards(),
          ],
        ),
      )
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.height / 2.65),
        children: [
          for (var i = 0; i < 7; i++)
            DuaCard(),
        ],
      ),
    );
  }
}
