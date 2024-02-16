import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/models/searchResultItem.dart';

class BookmarkItem extends StatefulWidget{
  late IconData icon;
  late Color color;
  SearchResultItem item;

  BookmarkItem({super.key, required this.item}){
    if(item.sIsBookmarked){
      icon = Icons.bookmark;
      color = Colors.blue;
    } else {
      icon = Icons.bookmark_border_rounded;
      color = Colors.black;
    }
  }

  @override
  State<BookmarkItem> createState() => _BookmarkItemState();
}

class _BookmarkItemState extends State<BookmarkItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.item.sIsReported);
    return Container(
      child: IconButton(icon: Icon(widget.icon, color: widget.color), onPressed: () {
        if(widget.item.sIsBookmarked){
          toggleBookmarks(widget.item.sID, context);
        } else {
          toggleBookmarks(widget.item.sID, context);
        }
      }),
    );
  }

  void toggleBookmarks(String id, BuildContext context) async{
    UserDataController userDataController = UserDataController();
    if(widget.item.sIsBookmarked){
      var result = userDataController.removeBookmark(id);
      if(await result){
        setState(() {
          widget.item.updateBookmarkStatus(false);
          widget.icon = Icons.bookmark_border_rounded;
          widget.color = Colors.black;
        });
        Fluttertoast.showToast(
            msg: "Removed from Bookmarks!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    } else {
      var result = userDataController.addBookmark(id);
      if(await result){
        setState(() {
          widget.item.updateBookmarkStatus(true);
          widget.icon = Icons.bookmark;
          widget.color = Colors.blue;
        });
        Fluttertoast.showToast(
            msg: "Added to Bookmarks!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }
  }
}