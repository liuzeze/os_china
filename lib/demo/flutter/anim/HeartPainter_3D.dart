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
          ..repeat();
    _animtion = Tween<double>(begin: 0, end: 1).animate(_animController)
      ..addListener(() {
        setState(() {});
      });
  }

  void animListener(status) {
    if (status == AnimationStatus.completed) {
      _animController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animController.forward();
    }
  }

  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心跳'),
      ),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (detail) {
            _offset += detail.delta;
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(_offset.dy*0.002)
              ..rotateY(_offset.dx*0.002),
            child: CustomPaint(
              size: Size(120, 120),
              painter: HeartPainter(),
            ),
          ),
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
