import 'package:flutter/material.dart';
import 'package:flutter_app/ui/page/bottom_navigation_bar_view.dart';
import 'package:flutter_app/ui/page/find.dart';
import 'package:flutter_app/ui/page/my.dart';
import 'package:flutter_app/ui/drawer/my_drawer.dart';
import 'package:flutter_app/ui/page/news.dart';
import 'package:flutter_app/ui/page/tweet.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/flt_toast.dart';

class HomePager extends StatefulWidget {
  @override
  _HomePagerState createState() => _HomePagerState();
}

class _HomePagerState extends State<HomePager> {
  List<BottomNavigationBarView> _navigitionItems;
  List<Widget> _pageViews;
  List<String> _navigationText;
  int _currenntIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    //标题
    //图片
    getBottomNavigitors();
    _pageController = PageController(initialPage: _currenntIndex);
  }

  void getBottomNavigitors() {
    _navigationText = ['资讯', '动弹', '发现', '我的'];

    //图片
    _navigitionItems = [
      BottomNavigationBarView(
          title: '资讯',
          icon: 'assets/images/ic_nav_news_normal.png',
          activieIcon: 'assets/images/ic_nav_news_actived.png'),
      BottomNavigationBarView(
          title: '动弹',
          icon: 'assets/images/ic_nav_tweet_normal.png',
          activieIcon: 'assets/images/ic_nav_tweet_actived.png'),
      BottomNavigationBarView(
          title: '发现',
          icon: 'assets/images/ic_nav_discover_normal.png',
          activieIcon: 'assets/images/ic_nav_discover_actived.png'),
      BottomNavigationBarView(
          title: '我的',
          icon: 'assets/images/ic_nav_my_normal.png',
          activieIcon: 'assets/images/ic_nav_my_pressed.png'),
    ];
    _pageViews = [
      News(),
      Tweet(),
      Find(),
      My(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currenntIndex = index;
            });
          },
          itemCount: _pageViews.length,
          itemBuilder: (context, index) {
            return _pageViews[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: _currenntIndex,
        fixedColor: Color(ColorUtils.c_63ca6c),
        type: BottomNavigationBarType.fixed,
        items: _navigitionItems
            .map((view) => view.bottomNavigationBarItem)
            .toList(),
        onTap: (index) {
          setState(() {
            _currenntIndex = index;
          });
          _pageController.jumpToPage(_currenntIndex);
        },
      ),
      drawer: MyDrawer(
        imagePath: 'assets/images/cover_img.jpg',
        imgList: [Icons.send, Icons.home, Icons.label, Icons.settings],
        titleList: ['发布动弹', '动弹小黑屋', '关于', '设置'],
      ),
    );
  }
}
