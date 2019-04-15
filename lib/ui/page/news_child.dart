import 'package:flutter/material.dart';
import 'package:flutter_app/bean/news_list.dart' show Newslist;
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/page/common_webview.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class NewsChild extends StatefulWidget {
  @override
  _NewsChildState createState() => _NewsChildState();
}

class _NewsChildState extends State<NewsChild>
    with SingleTickerProviderStateMixin {
  var data2 = [
    BannerDataBean(
        title: '冬天雪景',
        url:
            'http://img.jituwang.com/uploads/allimg/150109/258940-15010922123023.jpg'),
    BannerDataBean(
        title: '掘金小册',
        url: 'https://b-gold-cdn.xitu.io/v3/static/img/android.fef4da1.png'),
    BannerDataBean(
        title: '注意：Java 中的泛型信息是编译时的，泛型信息在运行时是不纯在的。。',
        url: 'http://pic.nipic.com/2008-02-21/2008221193244277_2.jpg'),
    BannerDataBean(
        title: 'Flutter的设计思想就是完全的widget化。',
        url: 'http://thumb102.hellorf.com/preview/115044886.jpg'),
  ];

  List<Newslist> _newsList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getNewsList(_pageNum);
        }
      });
    getNewsList(_pageNum);
  }

  void getNewsList(int pageNum) {
    RequestApi.getNewsList(pageNum).then((newslists) {
      setState(() {
        if (pageNum == 1) {
          _newsList.clear();
        }
        _newsList.addAll(newslists);
      });
      _pageNum += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.separated(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _newsList.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return buildBannerView();
          } else if (index == _newsList.length + 1) {
            if (_newsList.length == 0) {
              return null;
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          } else {
            var bean = _newsList[index - 1];
            return GestureDetector(
                onTap: () {
                  RequestApi.getNewsDetail(bean.id).then((bean) {
                    if (mounted) {
                      setState(() {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: WebViewPage(
                                  bean.url,
                                  id:bean.id,
                                  favorite:bean.favorite,
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
        await getNewsList(_pageNum);
      },
    );
  }

  Widget buildItemColumn(Newslist bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
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
                    '${bean.commentCount}',
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
    );
  }

  Widget buildBannerView() {
    return BannerView(
      indicatorColor: ColorUtils.c_63ca6c,
      indicatorSelectColor: ColorUtils.c_ff0000,
      indicatorAlignmentPos: MainAxisAlignment.end,
      indicatorSize: SizeUtils.px_5,
      onBannerClickListener: (index, itemData) {},
      data: data2,
      buildTitle: (int index, itemData) {
        return Text(itemData.title);
      },
      buildItem: (int index, itemData) {
        return Container(
          child: Image.network(
            itemData.url,
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}

class BannerDataBean extends Object {
  String url;
  String title;

  BannerDataBean({this.url, this.title});
}
