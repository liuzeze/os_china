import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AlignWidget(),
    ));

class AlignWidget extends StatefulWidget {
  @override
  _AlignWidgetState createState() => _AlignWidgetState();
}

class _AlignWidgetState extends State<AlignWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 100,
          width: 100,
          color: Color(0xffff0000),
        ),
      ),
    );
  }
}
