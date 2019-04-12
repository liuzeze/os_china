import 'package:flutter/material.dart';
import 'package:flutter_app/ui/page/my_head_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  List<String> myTitle;

  @override
  void initState() {
    super.initState();
    myTitle = [
      '我的消息',
      '阅读记录',
      '我的博客',
      '我的问答',
      '我的活动',
      '我的团队',
      '邀请好友',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return MyHeadwidget();
        } else {
          index -= 1;
          return ListTile(
            title: Text(myTitle[index]),
            onTap: () {
              Fluttertoast.showToast(msg: myTitle[index]);
            },
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.contact_mail),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: myTitle.length + 1,
    );
  }
}
