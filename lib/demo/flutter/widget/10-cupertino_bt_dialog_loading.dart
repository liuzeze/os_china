import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new CupertinoWidget());

class CupertinoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ios 风格",
      home: CupertinoHome(),
    );
  }
}

class CupertinoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('按钮 ,弹框,loading'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CupertinoButton(
                  child: Text('ios按钮'),
                  onPressed: () {},
                  color: Colors.lightBlueAccent,
                ),
                CupertinoAlertDialog(
                  title: Text('ios风格弹框'),
                  content: SingleChildScrollView(child: Text('这是一个弹框')),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('确定')),
                    CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('取消'))
                  ],
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 30,
                ),
                CupertinoActivityIndicator(
                  radius: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
