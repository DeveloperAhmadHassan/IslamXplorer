import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_appbar.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/new_tag.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DuaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 62, 1.0),
      appBar: CustomAppBar("Duas"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Cards(),
            ],
          ),
        ),
      )
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          for (var i = 0; i < 7; i++)
            DuaCard(),
        ],
    );
  }
}

class DuaCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var dua_num=0;
    var new_dua = false;
    // return InkWell(
    //   onTap: ()=>{},
    //   child: Card(
    //     elevation: 12,
    //     shadowColor: Colors.black,
    //     clipBehavior: Clip.hardEdge,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     child: Container(
    //       width: MediaQuery.of(context).size.width,
    //       color: Color.fromRGBO(246, 237, 151, 1.0),
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.all(8.0),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15),
    //                 color: Colors.amberAccent,
    //               ),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       new_dua ? const NewTag() : Container(),
    //                       Icon(Icons.favorite_border_outlined, color: Colors.red,)
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 140,
    //                     width: 180,
    //                     child: Image.asset("assets/sleep.png"),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 "Supplication Title",
    //                 style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.deepPurple,
    //                     fontWeight: FontWeight.bold,
    //                     fontFamily: 'IBMPlexMono'
    //                 ),
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 12),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       "$dua_num Duas",
    //                       style: TextStyle(
    //                           fontSize: 17,
    //                           color: Colors.indigo,
    //                           fontWeight: FontWeight.bold,
    //                           fontFamily: 'IBMPlexMono'
    //                       ),
    //                     ),
    //                   ),
    //                   Icon(Icons.share_outlined, color: Colors.indigo,)
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: ListTile(
            leading: Icon(LineAwesomeIcons.mosque),
            title: Text('Dua Title'),
            subtitle: Text('English Text of Dua'),
            trailing: Icon(Icons.favorite_border_outlined),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

}
