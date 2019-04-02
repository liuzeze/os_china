import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HeartWidget(),
    ));

class HeartWidget extends StatefulWidget {
  @override
  _HeartWidgetState createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget>
    with TickerProviderStateMixin {
  AnimationController _animController;
  Animation _animtion;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..forward();
    _animtion = Tween<double>(begin: 80.0, end: 100.0).animate(_animController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener(animListener);
  }

  void animListener(status) {
    if (status == AnimationStatus.completed) {
      _animController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心跳'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(_animtion.value, _animtion.value),
          painter: HeartPainter(),
        ),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    paint
      ..color = Color(0xffff0000)
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
