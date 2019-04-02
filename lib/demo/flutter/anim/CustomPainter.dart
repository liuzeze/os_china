import 'package:flutter/material.dart';
import 'package:flutter_app/demo/flutter/anim/HeartPainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自定义画笔',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: new Scaffold(
          body: CustomPaints(),
        ));
  }
}

class CustomPaints extends StatefulWidget {
  @override
  _CustomPaintState createState() => _CustomPaintState();
}

class _CustomPaintState extends State<CustomPaints> {
  List<Offset> list = new List();

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        GestureDetector(
          ///手势 想要控制手势 直接包裹widget即可
            ///按下
          onPanDown: (DragDownDetails details) {
            RenderBox box = context.findRenderObject();
            Offset offset = box.globalToLocal(details.globalPosition);
            print(offset.toString());
            setState(() {///定义一个数组 用来收集点击屏幕的地方
              list.add(offset);
            });
          },
        ),
        getList(),
      ],
    );
  }


  Stack getList() {
    return new Stack(
      children: _buildItem(),
    );
  }


  ///构建Stack布局的子childern,点击多少下就显示多少个♥布局
  List<Positioned> _buildItem() {
    List<Positioned> lists = new List();
    if (list.length != 0) {
      for (int i = 0; i < list.length; i++) {
        Offset offset = list[i];
        lists.add(Positioned(
		///这里要减去画笔的宽度 坐标才相对准确
          top: offset.dy-25,
          left: offset.dx-20,
          child: CustomPaint(
            size: Size(30, 30),
            painter: HeartPainter(),
          ),
        ));
      }
      return lists;
    } else {
      return lists;
      // return new Positioned();
    }
  }
}


///定义一个♥ 这里是赛贝尔曲线画成的，具体百度把 这个♥是百度抄的
class lovePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = true
      ..strokeWidth = 20
      ..strokeJoin = StrokeJoin.bevel; //定义画笔

    Path path = new Path();
    var width = 50;
    var height = 80;
    path.moveTo(width / 2, height / 4);
    path.cubicTo((width * 6) / 7, height / 9, (width * 13) / 13,
        (height * 2) / 5, width / 2, (height * 7) / 12);
    canvas.drawPath(path, paint);

    Path path2 = new Path();
    path2.moveTo(width / 2, height / 4);
    path2.cubicTo(width / 7, height / 9, width / 21, (height * 2) / 5,
        width / 2, (height * 7) / 12);
    canvas.drawPath(path2, paint);
  }

  //刷新布局的时候 告诉flutter需要重新绘制
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
