import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: GestureWidget(),
    ));

class GestureWidget extends StatelessWidget {
  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Center(
        child: GestureDetector(
          onTap: () {
            _scaffoldkey.currentState
                .showSnackBar(SnackBar(content: Text('点击')));
          },
          onDoubleTap: () {
            _scaffoldkey.currentState
                .showSnackBar(SnackBar(content: Text('双击')));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Text(
              '按钮',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
