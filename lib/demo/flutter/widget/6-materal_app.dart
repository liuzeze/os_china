import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/demo/flutter/widget/5-form.dart';

void main() => runApp(new MateralWidget());

class MateralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MD 风格',
        routes: {"/newPager": (context) => LoginWidget()},
        home: HomePager());
  }
}

class HomePager extends StatefulWidget {
  @override
  _HomePagerState createState() => _HomePagerState();
}

class _HomePagerState extends State<HomePager> {
  int _currentIndex = 0;
  var _pageListWidget = [Text("主页"), Text("通讯录"), Text("订单"), Text("我的")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MD 主题'),
        //居中
        centerTitle: true,
        //图标
        leading: Icon(Icons.star),
        //阴影
        elevation: 0.0,
        actions: <Widget>[
          Icon(Icons.search),
          Icon(Icons.more_horiz),
        ],
      ),
      body: Center(
        child: _pageListWidget.elementAt(_currentIndex),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.access_alarm),
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.red,
          tooltip: '长按',
//          shape: RoundedRectangleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, "/newPager");
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('主页')),
          BottomNavigationBarItem(icon: Icon(Icons.save), title: Text('通讯录')),
          BottomNavigationBarItem(icon: Icon(Icons.print), title: Text('订单')),
          BottomNavigationBarItem(icon: Icon(Icons.launch), title: Text('我的')),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
