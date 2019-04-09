import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            images.addAll(List.generate(
                20,
                (index) =>
                    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg'));
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List images = [
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
    'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('wheelView 3D旋转'),
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  images.clear();
                  images.addAll(List.generate(
                      1,
                      (index) =>
                          'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg'));
                });
              });
            },
            child: ListWheelScrollView(
              controller: _scrollController,
              perspective: 0.005,
              diameterRatio: 3.0,
              itemExtent: MediaQuery.of(context).size.height * 0.2,
              children: images
                  .map((m) => Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.network(
                              m,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 30.0,
                              left: 30.0,
                              child: Text(
                                '天之道',
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 30.0),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}
