import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareItem extends StatefulWidget{
  late IconData icon;
  late Color color;
  ShareItem({super.key}): icon = Icons.share_outlined, color = Colors.black;

  @override
  State<ShareItem> createState() => _ShareItemState();
}

class _ShareItemState extends State<ShareItem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(widget.icon, color: widget.color,), onPressed: () {
      var result = share();
    });
  }

  Future<bool> share() async{
    final result = await Share.shareWithResult("https://play.google.com/store/apps/details?id=com.islamxplorer.islamxplorer_flutter&pcampaignid=web_share");
    if(result.status == ShareResultStatus.success){
      setState(() {
        widget.icon = Icons.share;
        widget.color = Colors.green;
      });
      return true;
    } else {
      return false;
    }
  }
}