import 'package:flutter/material.dart';
import 'package:flutter_app/bean/news_list.dart' show Newslist;
import 'package:flutter_app/bean/wenda_list.dart';
import 'package:flutter_app/eventbus/event_bus.dart';
import 'package:flutter_app/eventbus/login_infor_event.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/common_webview.dart';
import 'package:flutter_app/ui/my/login_webview.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

class WenDaList extends StatefulWidget {
  @override
  _WenDaListState createState() => _WenDaListState();
}

class _WenDaListState extends State<WenDaList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<PostList> _wenDasList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

  VideoPlayerController _controller;
  String url = 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this.url)

      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getWenDaList(_pageNum);
        }
      });

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
  }

  void getWenDaList(int pageNum) {
    RequestApi.getWDList(pageNum).then((newslists) {
      setState(() {
        if (pageNum == 1) {
          _wenDasList.clear();
          _controller.play();
        }
        _wenDasList.addAll(newslists);
      });
      _pageNum += 1;
    });
  }

  String body = "";
  bool _isLogin;

  @override
  Widget build(BuildContext context) {
    return _isLogin == null
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : (_isLogin
            ? RefreshIndicator(
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: _wenDasList.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Center(
                          child: _controller.value.initialized
                              // 加载成功
                              ? new AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : new Container());
                    }
                    index--;
                    if (index == _wenDasList.length) {
                      if (_wenDasList.length == 0) {
                        return null;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else {
                      var bean = _wenDasList[index];
                      return GestureDetector(
                          onTap: () {
                            RequestApi.getWDDetail(bean.id).then((bean) {
                              body = bean.body;
                              if (mounted) {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: WebViewPage(
                                            bean.url,
                                            titleName: bean.title,
                                          ),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                });
                              }
                            });
                          },
                          child: buildItemColumn(bean));
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1,
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
              ));
  }

  Widget buildItemColumn(PostList bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${bean.title}',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(ColorUtils.c_111111),
                    fontSize: SizeUtils.px_30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${bean.title}',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(ColorUtils.c_666666),
                    fontSize: SizeUtils.px_25,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.px_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '@ ${bean.author + " " + bean.pubDate}',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(ColorUtils.c_666666),
                        fontSize: SizeUtils.px_20,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.comment,
                          size: SizeUtils.px_20,
                          color: Color(ColorUtils.c_666666),
                        ),
                        SizedBox(
                          width: SizeUtils.px_10,
                        ),
                        Text(
                          '${bean.viewCount}',
                          maxLines: 2,
                          style: TextStyle(
                            color: Color(ColorUtils.c_666666),
                            fontSize: SizeUtils.px_20,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
