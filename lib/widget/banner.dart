import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';

typedef void OnBannerClickListener<D>(int index, D itemData);
typedef void OnBannerSelectListener<D>(int index, D itemData);
typedef Widget BannerItemView<D>(int index, D itemData);
typedef Widget BannerTitleView<D>(int index, D itemData);

var BannerCount = 0x7fffffff;

class BannerView<T> extends StatefulWidget {
  final OnBannerClickListener<T> onBannerClickListener;
  final OnBannerSelectListener<T> onBannerSelectListener;

  final int delayTime;
  final int scrollTime;
  final double height;
  final List<T> data;
  final int indicatorBg;
  final int indicatorColor;
  final int indicatorSelectColor;
  final MainAxisAlignment indicatorAlignmentPos;
  final BannerItemView<T> buildItem;
  final BannerTitleView<T> buildTitle;

  BannerView({
    Key key,
    @required this.data,
    @required this.buildItem,
    this.buildTitle,
    this.onBannerSelectListener,
    this.onBannerClickListener,
    this.delayTime = 3,
    this.scrollTime = 200,
    this.height = 200.0,
    this.indicatorBg = 0x55111111,
    this.indicatorColor = 0xcccccccc,
    this.indicatorSelectColor = 0x33333333,
    this.indicatorAlignmentPos = MainAxisAlignment.center,
  })  : assert(data != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
  PageController _pageController;

  Timer timer;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    if (widget.data.length < 2) {
      BannerCount = widget.data.length;
    }
    _currentIndex = widget.data.length > 1 ? (BannerCount ~/ 2) : 0;
    _pageController = new PageController(initialPage: _currentIndex);
    resetTimer();
  }

  resetTimer() {
    if (widget.data.length < 2) return;
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime),
        (Timer timer) {
      if (_pageController.positions.isNotEmpty) {
        int index = _pageController.page.toInt() + 1;
        _pageController.animateToPage(index == 3 ? 0 : index,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.linear);
      }
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  List<Widget> _getIndicators() {
    return List.generate(widget.data.length, (index) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: SizeUtils.px_5,
              backgroundColor: _currentIndex % widget.data.length == index
                  ? Color(widget.indicatorSelectColor)
                  : Color(widget.indicatorColor),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthscreen = MediaQuery.of(context).size.width;
    return new SizedBox(
      height: widget.height,
      child: widget.data.length == 0
          ? null
          : GestureDetector(
              onTap: () {
                widget.onBannerClickListener(_currentIndex % widget.data.length,
                    widget.data[_currentIndex % widget.data.length]);
              },
              onTapDown: (details) {
                clearTimer();
              },
              onTapUp: (details) {
                resetTimer();
              },
              onTapCancel: () {
                resetTimer();
              },
              child: Stack(
                children: <Widget>[
                  PageView.builder(
                    onPageChanged: (index) {
                      widget.onBannerClickListener(index % widget.data.length,
                          widget.data[index % widget.data.length]);
                      setState(() {
                        _currentIndex = index;
                      });
                      if (widget.data.length < 2) {
                        clearTimer();
                      }
                    },
                    controller: _pageController,
                    physics: PageScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return widget.buildItem(
                          index, widget.data[index % widget.data.length]);
                    },
                    itemCount: widget.data.length < 2
                        ? widget.data.length
                        : BannerCount,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: widthscreen,
                            child: widget.buildTitle != null
                                ? widget.buildTitle(
                                    _currentIndex,
                                    widget.data[
                                        _currentIndex % widget.data.length])
                                : null,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: widthscreen,
                            color: Color(widget.indicatorBg),
                            child: Row(
                              mainAxisAlignment: widget.indicatorAlignmentPos,
                              children: _getIndicators(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
