import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../main/utils/AppWidget.dart';

class HistoryListButton extends StatefulWidget {
  var textContent;

  //   var icon;
  VoidCallback onPressed;

  HistoryListButton({
    required this.textContent,
    required this.onPressed,
    //   @required this.icon,
  });

  @override
  HistoryListButtonState createState() => HistoryListButtonState();
}

// ignore: camel_case_types
class HistoryListButtonState extends State<HistoryListButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: boxDecoration(bgColor: Colors.redAccent, radius: 16),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(widget.textContent, style: boldTextStyle(color: white)).center(),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent),
                width: 35,
                height: 35,
                child: Icon(Icons.arrow_forward, color: Colors.white, size: 20).paddingAll(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}