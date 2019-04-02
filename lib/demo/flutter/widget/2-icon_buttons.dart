import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('text示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.accessibility),
              SizedBox(
                height: 30,
              ),
              IconButton(
                icon: Icon(Icons.http),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('raisedButton'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('FlatButton'),
                onPressed: () {},
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.build),
                  label: Text('FlatButton.icon'))
            ],
          ),
        ),
      ),
    );
  }
}
