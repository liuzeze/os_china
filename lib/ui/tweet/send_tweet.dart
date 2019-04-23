import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class SendTweet extends StatefulWidget {
  @override
  _SendTweetState createState() => _SendTweetState();
}

class _SendTweetState extends State<SendTweet> {
  List<File> imgUrlList = new List<File>();
  TextEditingController _controller = new TextEditingController();

  bool isLoad = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgUrlList.clear();
      imgUrlList.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布动弹'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              var imgUrlList2;
              if (imgUrlList.length > 0) {
                imgUrlList2 = imgUrlList[0];
              }
              setState(() {
                isLoad = true;
              });
              RequestApi.tweetPub(_controller.text.toString(), imgUrlList2)
                  .then((map) {
                if (map['error'] == '200') {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: map['error_description']);
                }
                setState(() {
                  isLoad = false;
                });
              }).catchError((e) {
                Fluttertoast.showToast(msg: e.toString());
                setState(() {
                  isLoad = false;
                });
              });
            },
            child: Container(padding: EdgeInsets.all(20), child: Text('发送')),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  scrollPadding: EdgeInsets.all(10),
                  maxLines: 6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: '请输入你的评论内容',
                  ),
                  maxLength: 160,
                  controller: _controller,
                  autofocus: false,
                ),
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6),
                    scrollDirection: Axis.vertical,
                    itemCount: imgUrlList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == imgUrlList.length) {
                        return InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: ScreenUtil.getScreenWidthDp(context)/ 3,
                          ),
                        );
                      } else {
                        return Image.file(
                          imgUrlList[index],
                        );
                      }
                    })
              ],
            ),
          ),
          Center(
            child: CupertinoActivityIndicator(
              radius: isLoad ? 20 : 1,
            ),
          ),
        ],
      ),
    );
  }
}
