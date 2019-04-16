import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';

class SensorPager extends StatefulWidget {
  @override
  _SensorPagerState createState() => _SensorPagerState();
}

class _SensorPagerState extends State<SensorPager> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AeyriumSensor.sensorEvents.listen((SensorEvent event) {
      //do something with the event , values expressed in radians
      print("Pitch ${event.pitch} and Roll ${event.roll}");

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
            Text('摇一摇'),
          ],
        ),
      ),
    );
  }
}
