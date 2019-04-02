import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('text示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'text使用案例 ,的价格哈接口上的干哈接口的规划局考试大纲还觉得黄金卡好贵收到货撒金龟换酒后视镜的客观化科技好四大皆空更好看 ',
                maxLines: 1,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                    text: 'textgjdgasdjkg',
                    style: TextStyle(color: Colors.red).apply(),
                    children: <TextSpan>[
                      TextSpan(text: '121345654654'),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = "http://www.baidu.com";
                              if (await canLaunch(url)) {
                                launch(url);
                              } else {
                                throw ('请求地址{$url}');
                              }
                            },
                          text: '百度',
                          style: TextStyle(
                              color: Colors.yellow,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.dashed)),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
