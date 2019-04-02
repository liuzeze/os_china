import 'package:flutter/material.dart';

void main() => runApp(new DialogWidget());

class DialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "弹框",
      home: DialogHomeWidget(),
    );
  }
}

class DialogHomeWidget extends StatefulWidget {
  @override
  _DialogHomeWidgetState createState() => _DialogHomeWidgetState();
}

class _DialogHomeWidgetState extends State<DialogHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SimpleDialog(
            title: Text('弹框'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('按钮1'),
                onPressed: () {

                },
              ),
              SimpleDialogOption(
                child: Text('按钮2'),
                onPressed: () {

                },
              ),
            ],
          ),
          RaisedButton(
              child: Text('删除按钮'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[Text('删除'), Text('删除后不可恢复')],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                              },
                              child: Text('删除')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                              },
                              child: Text('取消')),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
  }
}
