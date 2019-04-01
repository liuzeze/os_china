import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: StackWidget(),
    ));

class StackWidget extends StatefulWidget {
  @override
  _StackWidgetState createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //buildPositionedStack()
//          buildAlignmentStack(),
          buildIndexStack(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          _index = Random().nextInt(2) % 2;
        });
      }),
    );
  }

  Widget buildIndexStack() {
    return Center(
      child: IndexedStack(
        index: _index,
        alignment: Alignment(1.2, -1.2),
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Color(0xff0000ff),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffff0000),
          ),
        ],
      ),
    );
  }

  Widget buildAlignmentStack() {
    return Center(
      child: Stack(
        alignment: Alignment(1.2, -1.2),
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Color(0xff0000ff),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffff0000),
          ),
        ],
      ),
    );
  }

  Stack buildPositionedStack() {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          color: Color(0xff0000ff),
        ),
        Text('sdgdg'),
        Positioned(
            bottom: 50,
            right: 50,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xffff0000),
            ))
      ],
    );
  }
}
