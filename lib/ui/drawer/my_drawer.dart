import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_app/ui/drawer/abort.dart';
import 'package:flutter_app/ui/tweet/send_tweet.dart';
import 'package:flutter_app/ui/drawer/setting.dart';
import 'package:flutter_app/ui/drawer/tweet_balck_house.dart';
import 'package:flutter_app/utils/config_utils.dart';

class MyDrawer extends StatelessWidget {
  final String imagePath;
  final List titleList;
  final List imgList;

  MyDrawer(
      {Key key,
      @required this.imagePath,
      @required this.titleList,
      @required this.imgList})
      : assert(imagePath != null),
        assert(titleList != null),
        assert(imgList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: titleList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image(
              fit: BoxFit.fill,
              image: AssetImage(imagePath),
              height: SizeUtils.px_400,
            );
          } else {
            return ListTile(
              leading: Icon(imgList[index - 1]),
              title: Text(titleList[index - 1]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                switch (index) {
                  case 1:
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: SendTweet()));

                    break;
                  case 2:
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: TweetBlackHouse()));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: Abort()));
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: Setting()));
                    break;
                }
              },
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
          );
        },
      ),
    );
  }
}
