import 'package:flutter/material.dart';
import 'package:flutter_app/bean/my_infor_data.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/login_webview.dart';
import 'package:flutter_app/ui/page/my_infor_detail.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class MyHeadwidget extends StatefulWidget {
  @override
  _MyHeadwidgetState createState() => _MyHeadwidgetState();
}

class _MyHeadwidgetState extends State<MyHeadwidget> {
  String _userName = '点击登录';
  String _userAvatar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _login();
    DataUtils.getUserName().then((s) {
      if (s != null) {
        _userName = s;
        if (mounted) {
          setState(() {});
        }
      }
    });
    DataUtils.getUserAvatar().then((s) {
      if (s != null) {
        _userAvatar = s;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  void _login() {
    RequestApi.getOpenapiUser().then((loginInfor) {
      setState(() {
        _userName = loginInfor.name;
        _userAvatar = loginInfor.avatar;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.px_300,
      color: Color(ColorUtils.c_63ca6c),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                DataUtils.isLogin().then((b) {
                  if (b) {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: MyInforDetail(),
                            type: PageTransitionType.rightToLeftWithFade));
                  } else {
                    Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: LoginWebView()))
                        .then((statue) {
                      if (statue == "success") {
                        _login();
                      }
                    });
                  }
                });
              },
              child: Container(
                width: SizeUtils.px_100,
                height: SizeUtils.px_100,
                margin: EdgeInsets.only(bottom: SizeUtils.px_10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: SizeUtils.px_5,
                        color: Color(ColorUtils.c_ffffff)),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _userAvatar != null
                            ? NetworkImage(_userAvatar)
                            : AssetImage(
                                'assets/images/ic_avatar_default.png'))),
              ),
            ),
            Text(
              _userName,
              style: TextStyle(color: Color(ColorUtils.c_ffffff)),
            )
          ],
        ),
      ),
    );
  }
}
