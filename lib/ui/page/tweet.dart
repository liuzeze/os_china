import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/news_list.dart' show Newslist;
import 'package:flutter_app/bean/tweet_list.dart';
import 'package:flutter_app/bean/wenda_list.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/common_webview.dart';
import 'package:flutter_app/ui/page/tweet_detail.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/utils/share_utils.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class Tweet extends StatefulWidget {
  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> with SingleTickerProviderStateMixin {
  List<Tweetlist> _tweetList = [];
  int _pageNum = 1;
  ScrollController _scrollController;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getWenDaList(_pageNum);
        }
      });
    getWenDaList(_pageNum);
  }

  void getWenDaList(int pageNum) {
    RequestApi.getTweetList(pageNum).then((newslists) {
      setState(() {
        if (pageNum == 1) {
          _tweetList.clear();
        }
        _tweetList.addAll(newslists);
      });
      _pageNum += 1;
    });
  }

  String body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //状态栏字体颜色
        leading: null,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          '动弹',
        ),
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: _tweetList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == _tweetList.length) {
              if (_tweetList.length == 0) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            } else {
              var bean = _tweetList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: TweetDetailWidget(
                              bean.id,
                            ),
                            type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: buildItemColumn(bean));
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Color(ColorUtils.c_666666),
            );
          },
        ),
        onRefresh: () async {
          _pageNum = 1;
          await getWenDaList(_pageNum);
        },
      ),
    );
  }

  Widget buildItemColumn(Tweetlist bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: SizeUtils.px_75,
                height: SizeUtils.px_75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(bean.portrait),
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
                    '${bean.author}',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(ColorUtils.c_111111),
                      fontSize: SizeUtils.px_30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${bean.pubDate}',
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
          SizedBox(
            height: SizeUtils.px_15,
          ),
          Text(
            '${bean.body}',
            maxLines: 2,
            style: TextStyle(
              color: Color(ColorUtils.c_111111),
              fontSize: SizeUtils.px_30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    ShareExtend.share("${bean?.body}", 'text');
                  },
                  child: buildRow(Icons.share, '转发')),
              GestureDetector(
                  onTap: () {
                    //弹框

                    showAlertDialog(context, bean);
                  },
                  child: buildRow(Icons.comment, '${bean.commentCount}')),
              GestureDetector(
                  onTap: () {}, child: buildRow(Icons.touch_app, '赞')),
            ],
          )
        ],
      ),
    );
  }

  Row buildRow(IconData icon, String s) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: SizeUtils.px_35,
          color: Color(ColorUtils.c_666666),
        ),
        SizedBox(
          width: SizeUtils.px_10,
        ),
        Text(
          s,
          maxLines: 2,
          style: TextStyle(
            color: Color(ColorUtils.c_666666),
            fontSize: SizeUtils.px_25,
          ),
        ),
      ],
    );
  }

  void showAlertDialog(BuildContext context, Tweetlist bean) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          padding: EdgeInsets.all(15),
          height: SizeUtils.px_400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '请输入评论内容',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '请输入你的评论内容',
                  helperText: '请输入你的评论内容',
                ),
                autofocus: false,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text('提交'),
                        onPressed: () {
                          if (_controller?.text?.length > 0) {
                            RequestApi.getPubCommont(
                                    bean?.id, _controller?.text)
                                .then((map) {
                              if (map['error'] == '200') {
                                _controller.clear();
                                Navigator.of(context).pop();
                              } else {
                                Fluttertoast.showToast(
                                    msg: map['error_description'] ?? '错误');
                              }
                            });
                          } else {
                            Fluttertoast.showToast(msg: '请输入内容');
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}
