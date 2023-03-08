import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void simple_alert(BuildContext context, String title, String desc,
    AlertType type, String button_text, Function onP) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          button_text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          onP();
        },
        width: 120,
      )
    ],
  ).show();
}
