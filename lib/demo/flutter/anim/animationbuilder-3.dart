import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AnimWidget(),
    ));

class AnimWidget extends StatefulWidget {
  @override
  _AnimWidgetState createState() => _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget> with TickerProviderStateMixin {
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
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animtion = Tween<double>(begin: -1, end: 0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {
          _currentValue = _animtion.value;
        });
      })
      ..addStatusListener(animListener);
  }

  void animListener(status) {
    if (status == AnimationStatus.completed) {
      _animController.removeStatusListener(animListener);
      _animController.reset();
      _animtion = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animController, curve: Curves.fastOutSlowIn));
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _animController.forward();
      }),
      body: Center(
        child: AnimatedBuilder(
            animation: _animtion,
            builder: (context, child) {
              return Transform(
                child: Container(width: 200, height: 200, child: FlutterLogo()),
                transform: Matrix4.translationValues(
                    _screenWidth * _animtion.value, 0, 0),
              );
            }),
      ),
    );
  }
}
