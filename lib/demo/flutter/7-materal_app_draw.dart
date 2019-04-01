import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/demo/flutter/8-dialog.dart';
import 'package:flutter_app/demo/flutter/9-card.dart';

void main() => runApp(new MateralWidget());

class MateralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MD 风格',
        routes: {"/newPager": (context) =>CardWidget()},
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
      drawer: buildDrawer(),
    );
  }

  /**
   * 侧滑
   */
  Drawer buildDrawer() {
    return Drawer(
//        elevation: 30,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "刘泽",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              '835052259@qq.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://img5.duitang.com/uploads/item/201411/18/20141118201614_8Bjax.thumb.700_0.jpeg"),
            ),
            otherAccountsPictures: <Widget>[Icon(Icons.camera)],
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg"))),
          ),
          ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text('定时器'),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('搜索'),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('收藏'),
          ),
          AboutListTile(
            child: Text('关于'),
            icon: Icon(Icons.add_box),
            applicationName: "版本升级",
            applicationVersion: '1.0.0',
            applicationIcon: Icon(Icons.launch),
            applicationLegalese: '描述',
            aboutBoxChildren: <Widget>[
              Text('按钮1'),
              Text('按钮2'),
              Text('按钮3'),
            ],
          )
        ],
      ),
    );
  }
}
