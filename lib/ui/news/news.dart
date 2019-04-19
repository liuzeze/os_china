import 'package:flutter/material.dart';
import 'package:flutter_app/ui/news/news_child.dart';
import 'package:flutter_app/ui/news/news_wenda.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/widget/banner.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(

          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('资讯'),
              SizedBox(
                height: 9,
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
        bottom: TabBar(
          //isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: "新闻"),
            Tab(text: "问答"),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        NewsChild(),
        WenDaList(),
      ]),
    );
  }

}
