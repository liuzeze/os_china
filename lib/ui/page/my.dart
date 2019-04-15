import 'package:flutter/material.dart';
import 'package:flutter_app/ui/page/favorite_list.dart';
import 'package:flutter_app/ui/page/message_list.dart';
import 'package:flutter_app/ui/page/my_head_view.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

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
      '收藏列表',
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
      padding: EdgeInsets.only(top: 0.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return MyHeadwidget();
        } else {
          index -= 1;
          return ListTile(
            title: Text(myTitle[index]),
            onTap: () {
              DataUtils.isLogin().then((b) {
                if (b) {
                  switch (index) {
                    case 0:
                      Navigator.push(
                          context,
                          PageTransition(
                              child: FavoriteListsWidget(),
                              type: PageTransitionType.rightToLeftWithFade));
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          PageTransition(
                              child: MessageListsWidget(),
                              type: PageTransitionType.rightToLeftWithFade));
                      break;
                    default:
                      Fluttertoast.showToast(msg: myTitle[index]);
                      break;
                  }
                } else {}
              });
            },
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.contact_mail),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1,);
      },
      itemCount: myTitle.length + 1,
    );
  }
}
