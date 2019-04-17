import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/commont_lists.dart';
import 'package:flutter_app/bean/message_list.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/ui/tweet/tweet_detail.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:page_transition/page_transition.dart';

class MessageListsWidget extends StatefulWidget {
  @override
  _MessageListsWidgetState createState() => _MessageListsWidgetState();
}

class _MessageListsWidgetState extends State<MessageListsWidget>
    with SingleTickerProviderStateMixin {
  List<MessageList> _messageList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getmessageList(_pageNum);
        }
      });
    getmessageList(_pageNum);
  }

  void getmessageList(int pageNum) {
    RequestApi.getMessageList(pageNum).then((newslists) {
      if (mounted) {
        setState(() {
          if (pageNum == 1) {
            _messageList.clear();
          }
          if (newslists != null) {
            _messageList.addAll(newslists);
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
        title: Text('私信列表'),
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: _messageList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == _messageList.length) {
              if (_messageList.length == 0) {
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
              var bean = _messageList[index];
              return GestureDetector(
                  onTap: () {}, child: buildItemColumn(bean));
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
          await getmessageList(_pageNum);
        },
      ),
    );
  }

  Widget buildItemColumn(MessageList bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: SizeUtils.px_75,
                height: SizeUtils.px_75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(bean?.portrait),
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
                      '${bean?.friendname}',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(ColorUtils.c_111111),
                        fontSize: SizeUtils.px_30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${bean?.pubDate}',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(ColorUtils.c_666666),
                        fontSize: SizeUtils.px_25,
                      ),
                    ),
                    Text(
                      '${bean?.content}',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(ColorUtils.c_111111),
                        fontSize: SizeUtils.px_30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildRow(IconData icon, String s) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: SizeUtils.px_35,
          color: Color(ColorUtils.c_666666),
        ),
        SizedBox(
          width: SizeUtils.px_10,
        ),
        Text(
          s,
          maxLines: 2,
          style: TextStyle(
            color: Color(ColorUtils.c_666666),
            fontSize: SizeUtils.px_25,
          ),
        ),
      ],
    );
  }
}
