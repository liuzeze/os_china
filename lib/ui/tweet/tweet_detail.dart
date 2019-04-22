import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tweet_detail.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/tweet/commont_list.dart';
import 'package:flutter_app/ui/tweet/img_preview.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
            ),
          ],
        ),
      ),
    ];

    list.add(Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: HtmlWidget(_tweetDetailBean?.body ?? ""),
    ));

    String _imgSmall = _tweetDetailBean?.imgSmall;
    List<String> imgUrlList = new List<String>();
    if (_imgSmall != null && _imgSmall.length > 0) {
      List<String> list = _imgSmall.split(",");
      print('list: $list');
      for (String s in list) {
        //！！
        if (s.startsWith('https://static.oschina.net/uploads/space/https')) {
          s = s.replaceAll('https://static.oschina.net/uploads/space/', '');
        }
        imgUrlList.add(s);
      }
    }

    if (imgUrlList.length > 0) {
      list.add(Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6),
            scrollDirection: Axis.vertical,
            itemCount: imgUrlList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ImgPreView(imgUrlList, index)));
                },
                child: Image.network(
                  imgUrlList[index],
                ),
              );
            }),
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
    list.add(
        CommontListsWidget(widget.tweetId, _tweetDetailBean?.commentCount));

    return list;
  }


}
