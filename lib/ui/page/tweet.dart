import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //状态栏字体颜色
        leading: null,
      centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          '动弹',
        ),
      ),
      body: Container(
        child: Text('Tweet'),
      ),
    );
  }
}
