import 'package:flutter/material.dart';
import 'package:flutter_app/bean/news_list.dart' show Newslist;
import 'package:flutter_app/bean/wenda_list.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/common_webview.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class WenDaList extends StatefulWidget {
  @override
  _WenDaListState createState() => _WenDaListState();
}

class _WenDaListState extends State<WenDaList>
    with SingleTickerProviderStateMixin {
  List<PostList> _wenDasList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

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
    RequestApi.getWDList(pageNum).then((newslists) {
      setState(() {
        if (pageNum == 1) {
          _wenDasList.clear();
        }
        _wenDasList.addAll(newslists);
      });
      _pageNum += 1;
    });
  }
String body="";
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.separated(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _wenDasList.length + 1,
        itemBuilder: (BuildContext context, int index) {
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
                    body=bean.body;
                    if (mounted) {
                      setState(() {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: WebViewPage(
                                  bean.url,
                                  titleName: bean.title,
                                ),
                                type: PageTransitionType.rightToLeftWithFade));
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
    );
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
