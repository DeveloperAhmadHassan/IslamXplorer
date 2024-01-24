import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/values/colors.dart';

class FullScreenLoader{
  static void openLoadingDialog(String text, String animation){
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_)=>WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Container(
            height:double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30,),
                Text("$text", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3),
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none
                ))
              ],
            ),
          ),
        )
    );
  }

  static void stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}