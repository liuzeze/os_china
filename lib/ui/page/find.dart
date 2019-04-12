import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  List<IconData> _icon;
  List<String> _title;

  @override
  void initState() {
    super.initState();
    _icon = [
      Icons.language,
      Icons.laptop_windows,
      Icons.map,
      Icons.repeat,
      Icons.whatshot,
      Icons.wc,
      Icons.wb_cloudy,
      Icons.watch_later,
    ];
    _title = [
      '开源众包',
      '开源软件',
      '码云推荐',
      '代码片段',
      '扫一扫',
      '摇一摇',
      '附近的程序员',
      '线下活动',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //状态栏字体颜色
        leading: null,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
         '发现',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text(_title[index]),
                leading: Icon(_icon[index]),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: _title.length),
    );
  }
}
