import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/qiblah/qiblah.dart';

class Qiblah extends StatelessWidget {
  const Qiblah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyQiblah();
    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     centerTitle: true,
    //     title: Text("تلاوت",style: TextStyle(
    //       fontFamily: 'qalam',
    //       fontSize: 30,
    //     ),),
    //
    //   ),
    //   body: Center(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Card(
    //         color: Colors.green,
    //         elevation: 15,
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //             color: Colors.white, //<-- SEE HERE
    //           ),
    //           borderRadius: BorderRadius.circular(20.0),
    //         ),
    //         child: Container(
    //
    //           padding: EdgeInsets.all(20),
    //
    //           child: Text(
    //             'Work in Progress',
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 20
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}