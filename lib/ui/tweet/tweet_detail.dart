import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tweet_detail.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/tweet/commont_list.dart';
import 'package:flutter_app/utils/config_utils.dart';

class TweetDetailWidget extends StatefulWidget {
  int tweetId;

  TweetDetailWidget(this.tweetId);

  @override
  _TweetDetailWidgetState createState() => _TweetDetailWidgetState();
}

class _TweetDetailWidgetState extends State<TweetDetailWidget> {
  TweetDetailBean _tweetDetailBean;

  @override
  void initState() {
    super.initState();
    RequestApi.getTweetDetail(widget.tweetId).then((bean) {
      setState(() {
        _tweetDetailBean = bean;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹详情'),
      ),
      body: ListView(
        children: children(),
      ),
    );
  }

  List<Widget> children() {
    var list = <Widget>[
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Container(
              width: SizeUtils.px_75,
              height: SizeUtils.px_75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(_tweetDetailBean?.portrait ?? ''),
                ),
              ),
            ),
            SizedBox(
              width: SizeUtils.px_20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${_tweetDetailBean?.author}',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(ColorUtils.c_111111),
                    fontSize: SizeUtils.px_30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_tweetDetailBean?.pubDate}',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(ColorUtils.c_666666),
                    fontSize: SizeUtils.px_25,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ];

    list.add(Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Text(_tweetDetailBean?.body ?? ""),
    ));

    if (_tweetDetailBean?.imgSmall != null) {
      list.add(Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(15.0),
        child: Image.network(
          _tweetDetailBean?.imgSmall,
          height: SizeUtils.px_300,
          width: SizeUtils.px_300,
        ),
      ));
    }

    list.add(SizedBox(
      height: 10,
    ));
    list.add(Divider(
      height: 0,
    ));
    list.add(Container(
      padding: EdgeInsets.all(8),
      color: Color(ColorUtils.c_cccccc),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Center(child: Text('赞(0)'))),
              Expanded(
                child: Center(
                  child: Text('评论(${_tweetDetailBean?.commentCount})'),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
    list.add(Divider(
      height: 0,
    ));
    list.add(CommontListsWidget(
        _tweetDetailBean?.id, _tweetDetailBean?.commentCount));

    return list;
  }
}
