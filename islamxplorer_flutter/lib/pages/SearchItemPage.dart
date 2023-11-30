import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/custom_text.dart';
import 'package:islamxplorer_flutter/widgets/search_bar.dart';
import 'package:islamxplorer_flutter/widgets/secondary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchItemPage extends StatefulWidget{
  @override
  State<SearchItemPage> createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<SearchItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Item!!!!"),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                height: 600,
                color: Colors.amberAccent,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.green,
                          child: Column(
                            children: [
                              Container(height: 30,color: Colors.amber,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 200,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 170,
                        width: 170,
                        color: Colors.red,
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                height: 300,
                color: Colors.blueGrey,
              )
            ],
          ),
      ),
    );
  }
}