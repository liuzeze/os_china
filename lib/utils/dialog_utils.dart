import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void showAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('我是一个dialog'),
              RaisedButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
      },
    );
  }

  static void closrDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
