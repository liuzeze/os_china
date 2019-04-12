import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  String _url;
  String titleName;

  WebViewPage(this._url, {this.titleName = '开源中国'});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  FlutterWebviewPlugin _flutterWebviewPlugin;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Row(
          children: appBarTitle(),
        ),
      ),
      url: widget._url,
      withZoom: true,
      withJavascript: true,
    );
  }

  List<Widget> appBarTitle() {
    var list = <Widget>[
      Expanded(
        child: Text(
          widget.titleName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(width: SizeUtils.px_20),
    ];
    if (isLoading) {
      list.add(CupertinoActivityIndicator());
    }
    return list;
  }
}
