import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';

class SensorPager extends StatefulWidget {
  @override
  _SensorPagerState createState() => _SensorPagerState();
}

class _SensorPagerState extends State<SensorPager> {
  int _currentIndex = 0;
  static const int SHAKE_TIMEOUT = 500;
  static const double SHAKE_THRESHOLD = 3.25;
  var _lastTime = 0;
  bool isShaked = false;
  StreamSubscription _streamSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if ((now - _lastTime) > SHAKE_TIMEOUT) {
        var x = event.x;
        var y = event.y;
        var z = event.z;
        double acce = sqrt(x * x + y * y + z * z) - 9.8; //g
        if (acce > SHAKE_THRESHOLD) {
          //手机晃动了
          Vibration.vibrate();
          _lastTime = now;
          if (!mounted) return;
          setState(() {
            isShaked = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('摇一摇'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              isShaked=false;
            });
          },
          selectedItemColor: Color(ColorUtils.c_111111),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.sentiment_dissatisfied),
                title: Text('摇一摇'),
                activeIcon: Icon(Icons.sentiment_satisfied)),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite),
                title: Text('看一看'),
                icon: Icon(Icons.favorite_border))
          ]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: NetworkImage(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1555414374509&di=db307939c36195413d7f0f7955ae9420&imgtype=0&src=http%3A%2F%2Fmat1.gtimg.com%2Fhb%2F000oneday%2Fyiy3.gif')),
            Text(!isShaked ? '摇一摇' : '中奖了'),
          ],
        ),
      ),
    );
  }
}
