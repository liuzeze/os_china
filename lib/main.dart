import 'package:flutter/material.dart';
import 'MyListWidget.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "列表demo" ,
      theme: ThemeData.light(),
      home: MyListWidget(),
    );
  }
}
