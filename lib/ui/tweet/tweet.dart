import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tweet_list.dart';
import 'package:flutter_app/eventbus/event_bus.dart';
import 'package:flutter_app/eventbus/login_infor_event.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/my/login_webview.dart';
import 'package:flutter_app/ui/tweet/img_preview.dart';
import 'package:flutter_app/ui/tweet/tweet_detail.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_extend/share_extend.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Tweet extends StatefulWidget {
  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Tweetlist> _tweetList = [];
  int _pageNum = 1;
  ScrollController _scrollController;
  TextEditingController _controller = TextEditingController();
  bool _isLogin;

  @override
  void initState() {
    super.initState();
    DataUtils.isLogin().then((b) {
      if (mounted) {
        setState(() {
          _isLogin = b;
          if (_isLogin) {
            getWenDaList(_pageNum);
          }
        });
      }
    });
    eventBus.on<LoginEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      if (mounted) {
        setState(() {
          _isLogin = true;
          getWenDaList(_pageNum);
        });
      }
    });
    eventBus.on<LogoEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      if (mounted) {
        setState(() {
          _isLogin = false;
        });
      }
    });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getWenDaList(_pageNum);
        }
      });
  }

  void getWenDaList(int pageNum) {
    RequestApi.getTweetList(pageNum).then((newslists) {
      if (mounted) {
        setState(() {
          if (pageNum == 1) {
            _tweetList.clear();
          }
          _tweetList.addAll(newslists);
        });
        _pageNum += 1;
      }
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
      body: _isLogin == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : (_isLogin
              ? RefreshIndicator(
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
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
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
                )
              : Center(
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color(ColorUtils.c_666666),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: LoginWebView()));
                      },
                      child: Text(
                        '登录',
                        style: TextStyle(color: Color(ColorUtils.c_ffffff)),
                      )),
                )),
    );
  }



  Widget buildItemColumn(Tweetlist bean) {
    String _imgSmall = bean.imgSmall;
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
    var children2 = <Widget>[
      Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(bean.portrait),
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
      HtmlWidget(bean?.body ?? ""),

    ];

    if (imgUrlList.length > 0) {
      children2.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6),
            scrollDirection: Axis.vertical,
            itemCount: imgUrlList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ImgPreView(imgUrlList,index)));
                },
                child: Image.network(
                  imgUrlList[index],
                ),
              );
            }),
      ));
    }
    children2.add(
      Divider(
        height: 25,
      ),
    );
    children2.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
            onTap: () {
              ShareExtend.share("${bean.body}", 'text');
            },
            child: buildRow(Icons.share, '转发')),
        InkWell(
            onTap: () {
              //弹框
              showAlertDialog(context, bean);
            },
            child: buildRow(Icons.comment, '${bean.commentCount}')),
        InkWell(onTap: () {}, child: buildRow(Icons.touch_app, '赞')),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children2,
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
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          height: SizeUtils.px_600,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '请输入评论内容',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                scrollPadding: EdgeInsets.all(10),
                maxLines: 6,
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: '请输入你的评论内容',
                ),
                autofocus: false,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
