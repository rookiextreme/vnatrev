import 'package:flutter/material.dart';

void displaySnack({required BuildContext context, label, func, withAction = false}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(label),
    action: withAction ? SnackBarAction(
      label: '',
      onPressed: () {
        func();
      },
    ) : null,
  ));
}