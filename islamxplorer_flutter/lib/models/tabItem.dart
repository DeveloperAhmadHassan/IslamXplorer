import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TabItem {
  TabItem({
    this.stateMachine = "",
    this.artboard = "",
    this.status,
  });

  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  late SMIBool? status;

  static List<TabItem> tabItemsList = [
    TabItem(stateMachine: "HOME_interactivity", artboard: "HOME"),
    TabItem(stateMachine: "SEARCH_Interactivity", artboard: "SEARCH"),
    TabItem(stateMachine: "TIMER_Interactivity", artboard: "TIMER"),
    TabItem(stateMachine: "STAR_Interactivity", artboard: "LIKE/STAR"),
    TabItem(stateMachine: "USER_Interactivity", artboard: "USER"),
  ];
}