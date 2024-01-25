import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class SecondaryLoader extends StatelessWidget{
  String? loadingText = "Loading Item. Please Wait";
  SecondaryLoader({this.loadingText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitWave(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                ),
              );
            },
          ),
          SizedBox(height: 30,),
          Text("$loadingText", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
          ))
        ],
      ),
    );
  }

}