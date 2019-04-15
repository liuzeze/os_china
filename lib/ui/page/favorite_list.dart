import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/commont_lists.dart';
import 'package:flutter_app/bean/favorite_list.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/common_webview.dart';
import 'package:flutter_app/ui/page/tweet_detail.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:page_transition/page_transition.dart';

class FavoriteListsWidget extends StatefulWidget {
  FavoriteListsWidget();

  @override
  _FavoriteListsWidgetState createState() => _FavoriteListsWidgetState();
}

class _FavoriteListsWidgetState extends State<FavoriteListsWidget>
    with SingleTickerProviderStateMixin {
  List<FavoriteList> _favoriteList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getFavoriteList(_pageNum);
        }
      });
    getFavoriteList(_pageNum);
  }

  void getFavoriteList(int pageNum) {
    RequestApi.getFavoriteList(pageNum).then((newslists) {
      if (mounted) {
        setState(() {
          if (pageNum == 1) {
            _favoriteList.clear();
          }
          if (newslists != null) {
            _favoriteList.addAll(newslists);
          }
        });
      }
      _pageNum += 1;
    });
  }

  String body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏列表'),
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: _favoriteList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == _favoriteList.length) {
              if (_favoriteList.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('没有更多数据')),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            } else {
              var bean = _favoriteList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: WebViewPage(
                              bean.url,
                              favorite: 1,
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
          await getFavoriteList(_pageNum);
        },
      ),
    );
  }

  Widget buildItemColumn(FavoriteList bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: Color(ColorUtils.c_cccccc)),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Color(ColorUtils.c_ffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${getType(bean)}',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(ColorUtils.c_cccccc),
                      fontSize: SizeUtils.px_25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: SizeUtils.px_20,
              ),
              Expanded(
                child: Text(
                  '${bean?.title}',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(ColorUtils.c_111111),
                    fontSize: SizeUtils.px_30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String getType(FavoriteList bean) {
    // 	0-全部|1-软件|2-话题|3-博客|4-新闻|5代码|7-翻译
    switch (bean?.type) {
      case 0:
        return '';
      case 1:
        return '软件';
      case 2:
        return '话题';
      case 3:
        return '博客';
      case 4:
        return '新闻';
      case 5:
        return '代码';
      case 7:
        return '翻译';
        break;
    }
  }
}
