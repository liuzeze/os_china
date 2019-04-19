import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/commont_lists.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CommontListsWidget extends StatefulWidget {
  int tweetId;
  int commentCount;

  CommontListsWidget(this.tweetId, this.commentCount);

  @override
  _CommontListsWidgetState createState() => _CommontListsWidgetState();
}

class _CommontListsWidgetState extends State<CommontListsWidget>
    with SingleTickerProviderStateMixin {
  List<CommentList> _commontList = [];
  int _pageNum = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getCommontList(_pageNum);
        }
      });
    getCommontList(_pageNum);
  }

  void getCommontList(int pageNum) {
    RequestApi.getCommontList(widget.tweetId, pageNum).then((newslists) {
      if (mounted) {
        setState(() {
          if (pageNum == 1) {
            _commontList.clear();
          }
          if (newslists != null) {
            _commontList.addAll(newslists);
          }
        });
      }
      _pageNum += 1;
    });
  }

  String body = "";

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.separated(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _commontList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _commontList.length) {
            if (_commontList.length == widget.commentCount) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('没有更多数据')),
              );
            }
            if (_commontList.length == 0) {
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
            var bean = _commontList[index];
            return GestureDetector(
                onTap: () {
                },
                child: buildItemColumn(bean));
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
        await getCommontList(_pageNum);
      },
    );
  }

  Widget buildItemColumn(CommentList bean) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: SizeUtils.px_75,
                height: SizeUtils.px_75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(bean?.commentPortrait),
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
                      '${bean?.commentAuthor}',
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
                    HtmlWidget(bean?.content),

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
