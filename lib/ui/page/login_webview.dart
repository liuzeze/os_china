import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/constant.dart';
import 'package:flutter_app/http/HttpUtils.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginWebView extends StatefulWidget {
  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  FlutterWebviewPlugin _flutterWebviewPlugin;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin = FlutterWebviewPlugin();
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      //https://github.com/liuzeze?code=GM7aqk&state=

      if (url != null && url.length > 0 && url.contains('?code=')) {
        String code = url.split('?')[1].split('&')[0].split('=')[1];
        RequestApi.getOauth2Token(code).then((response) {
          DataUtils.saveTokenInfor(response);
          Navigator.pop(context, "success");
          DataUtils.isLogin();
        }).catchError((e) {
          print('initState  = ===== '+e.toString());
        });
       /* Map<String, String> map = {
          "client_id": AppUrl.CLIENT_ID,
          "client_secret": AppUrl.CLIENT_SECRET,
          "grant_type": 'authorization_code',
          "redirect_uri": AppUrl.REDIRECT_URI,
          "code": code,
          "dataType": 'json',
        };
        HttpUtils.get(AppUrl.OAUTH2_TOKEN, params: map).then((response) {
          DataUtils.saveTokenInfor(response);
          Navigator.pop(context, "success");
          DataUtils.isLogin();
        }).catchError((e) {
          print('initState  = ===== '+e.toString());
        });
*/

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //GET /authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb HTTP/1.1
    return WebviewScaffold(
      url: AppUrl.BASE_URL +
          AppUrl.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=${AppUrl.CLIENT_ID}&redirect_uri=${AppUrl.REDIRECT_URI}',
      withJavascript: true,
      withZoom: true,
      withLocalStorage: true,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Row(
          children: appBarTitle(),
        ),
      ),
    );
  }

  List<Widget> appBarTitle() {
    var list = <Widget>[
      Text('登陆'),
      SizedBox(width: SizeUtils.px_20),
    ];
    if (isLoading) {
      list.add(CupertinoActivityIndicator());
    }
    return list;
  }
}
