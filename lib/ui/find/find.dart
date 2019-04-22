import 'package:flutter/material.dart';
import 'package:flutter_app/ui/common_webview.dart';
import 'package:flutter_app/ui/find/sensor_page.dart';
import 'package:flutter_app/utils/flt_toast.dart';
import 'package:page_transition/page_transition.dart';

import 'package:barcode_scan/barcode_scan.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  List<IconData> _icon;
  List<String> _title;

  @override
  void initState() {
    super.initState();
    _icon = [
      Icons.language,
      Icons.laptop_windows,
      Icons.map,
      Icons.repeat,
      Icons.whatshot,
      Icons.wc,
      Icons.wb_cloudy,
      Icons.watch_later,
    ];
    _title = [
      '开源众包',
      '开源软件',
      '码云推荐',
      '代码片段',
      '扫一扫',
      '摇一摇',
      '职业生涯',
      '线下活动',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //状态栏字体颜色
        leading: null,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          '发现',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                child: ListTile(
                  title: Text(_title[index]),
                  leading: Icon(_icon[index]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    String url = "";
                    switch (index) {
                      case 0:
                        url = 'https://zb.oschina.net/';
                        break;
                      case 1:
                        url = 'https://www.oschina.net/project';
                        break;
                      case 2:
                        url = 'https://gitee.com/?from=osc-top';
                        break;
                      case 3:
                        url = 'https://gitee.com/explore';
                        break;
                      case 4:
                        BarcodeScanner.scan().then((s) {
                          FltToast.showToast("扫描内容" + s);
                        });
                        break;
                      case 5:
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SensorPager(),
                                type: PageTransitionType.rightToLeftWithFade));
                        break;
                      case 6:
                        url = 'https://www.oschina.net/question?catalog=100';
                        break;
                      case 7:
                        url =
                            'https://www.oschina.net/event?tab=latest&city=%E5%85%A8%E5%9B%BD&time=all';
                        break;
                    }
                    if (index == 4 || index == 5) {
                      return;
                    }

                    Navigator.push(
                        context,
                        PageTransition(
                            child: WebViewPage(
                              url,
                              titleName: _title[index],
                            ),
                            type: PageTransitionType.rightToLeftWithFade));
                  },
                ),
              ),
          separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
          itemCount: _title.length),
    );
  }
}
