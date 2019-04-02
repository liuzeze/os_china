import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new CupertinoWidget());

class CupertinoWidget extends StatefulWidget {
  @override
  _CupertinoWidgetState createState() => _CupertinoWidgetState();
}

class _CupertinoWidgetState extends State<CupertinoWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "iosdemo",
      home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled), title: Text('添加')),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book), title: Text('看书')),
          ]),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (content) {
                switch (index) {
                  case 0:
                    return CupertinoAddWidget();
                    break;
                  case 1:
                    return CupertinoBookWidget();
                    break;
                }
              },
            );
          }),
    );
  }
}

class CupertinoAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.back),
          middle: Text('添加'),
          trailing: Icon(CupertinoIcons.search),
        ),
        child: Center(
          child: Text('添加'),
        ));
  }
}

class CupertinoBookWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.back),
          middle: Text('看书'),
          trailing: Icon(CupertinoIcons.search),
        ),
        child: Center(

          child: Text('看书'),
        ));
  }
}
