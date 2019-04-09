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
  Animation<double> _animation;
  AnimationController _animationController;
  bool reversed = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: pi / 2, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _doAnim() {
    reversed ? _animationController.reverse() : _animationController.forward();
    reversed = !reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _doAnim,
                  child: IndexedStack(
                    children: <Widget>[
                      CardOne(),
                      CardTwo(),
                    ],
                    alignment: Alignment.center,
                    index: _animationController.value < 0.5 ? 0 : 1, //0~1
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200.0,
        height: 200.0,
        child: CustomPaint(
          painter: HeartPainter(Color(0xff00ff00)),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200.0,
        height: 200.0,
        child: CustomPaint(
          painter: HeartPainter(Color(0xffff0000)),
        ),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  var color2 = Color(0xffff0000);

  HeartPainter(this.color2);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    paint
      ..color = color2
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
