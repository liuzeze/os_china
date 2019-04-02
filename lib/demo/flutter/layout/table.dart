import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: TableWidget(),
    ));

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Table(
            border: TableBorder.all(color: Color(0xffff0000), width: 2),
            defaultColumnWidth: FixedColumnWidth(60.0),
            children: [
              TableRow(children: [
                Text('姓名'),
                Text('年龄'),
                Text('性别'),
                Text('籍贯'),
              ]),
              TableRow(children: [
                Text('刘泽'),
                Text('29'),
                Text('男'),
                Text('河北'),
              ]),
              TableRow(children: [
                Text('刘泽'),
                Text('29'),
                Text('男'),
                Text('河北'),
              ]),
              TableRow(children: [
                Text('刘泽'),
                Text('29'),
                Text('男'),
                Text('河北'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
