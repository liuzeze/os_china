import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AnimationOne(),
    ));

class AnimationOne extends StatefulWidget {
  @override
  _AnimationOneState createState() => _AnimationOneState();
}

class _AnimationOneState extends State<AnimationOne>
    with TickerProviderStateMixin {
  var _currentValue = 100.0;
  AnimationController _animController;
  Animation _animtion;

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..reverse();
    _animtion = Tween<double>(begin:100.0, end: 200.0).animate(_animController)
      ..addListener(() {
        setState(() {
          _currentValue = _animtion.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animController.reverse();
        } else if (status == AnimationStatus.forward) {
          _animController.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _animController.forward();
      }),
      body: Center(
        child: Container(
          width: _currentValue,
          height: _currentValue,
          color: Colors.blue,
          child: Text('$_currentValue'),
        ),
      ),
    );
  }
}
