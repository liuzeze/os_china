import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  String _url;
  String titleName;
  int id;
  int favorite;

  WebViewPage(this._url,
      {this.id, this.favorite = -1, this.titleName = '开源中国'});

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
    if (widget.favorite != -1) {
      list.add(GestureDetector(
        child:
            Icon(widget.favorite == 1 ? Icons.favorite : Icons.favorite_border),
        onTap: () {
          RequestApi.getAddFavorite(widget.id, widget.favorite).then((map) {
            if (map['error'] == '200') {
              widget.favorite == 1 ? widget.favorite = 0 : widget.favorite = 1;
              setState(() {});
            }
          });
        },
      ));
    }
    return list;
  }
}
