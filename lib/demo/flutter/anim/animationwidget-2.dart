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
    _animtion = Tween<double>(begin: 100.0, end: 200.0).animate(_animController)
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
      body: MyLogo(
        anim: _animtion,
      ),
    );
  }
}

class MyLogo extends AnimatedWidget {
  MyLogo({Key key, @required Animation anim}) : super(listenable: anim);

  final Tween<double> _rotateAnim = Tween<double>(begin: 0.0, end: 100.0);
  final Tween<double> _scaleAnim = Tween<double>(begin: 1.0, end: 10.0);

  @override
  Widget build(BuildContext context) {
    Animation anim = listenable;
    return Center(
      child: Transform.rotate(
        angle: _rotateAnim.evaluate(anim),
        child: Transform.scale(
          scale: _scaleAnim.evaluate(anim),
          child: Container(
            /*  width: anim.value,
            height: anim.value,*/
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
