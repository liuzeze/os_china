import 'package:flutter/material.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/login_webview.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHeadwidget extends StatefulWidget {
  @override
  _MyHeadwidgetState createState() => _MyHeadwidgetState();
}

class _MyHeadwidgetState extends State<MyHeadwidget> {
  void _login() {
    RequestApi.getOpenapiUser().then((map) {

      Fluttertoast.showToast(msg: map.toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.px_350,
      color: Color(ColorUtils.c_63ca6c),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                DataUtils.isLogin().then((b){
                  if (b) {
                    _login();
                  }else{
                    Navigator.push<String>(context,
                        MaterialPageRoute(builder: (context) {
                          return LoginWebView();
                        })).then((statue) {
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
                        image:
                            AssetImage('assets/images/ic_avatar_default.png'))),
              ),
            ),
            Text(
              '名字',
              style: TextStyle(color: Color(ColorUtils.c_ffffff)),
            )
          ],
        ),
      ),
    );
  }
}
