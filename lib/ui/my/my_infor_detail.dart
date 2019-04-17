import 'package:flutter/material.dart';
import 'package:flutter_app/bean/my_infor_data.dart';
import 'package:flutter_app/http/request_api.dart';
import 'package:flutter_app/utils/config_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:flutter_app/widget/infor_title.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyInforDetail extends StatefulWidget {
  @override
  _MyInforDetailState createState() => _MyInforDetailState();
}

class _MyInforDetailState extends State<MyInforDetail> {
  MyInformation _myInformation;

  @override
  void initState() {
    super.initState();
    _getUserInforDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的资料'),
      ),
      body: ListView(
        children: <Widget>[
          InforTitle(
            '头像',
            rightImg: _myInformation?.portrait,
          ),
          InforTitle(
            '昵称',
            rightText: _myInformation?.name,
          ),
          InforTitle(
            '加入时间',
            rightText: _myInformation?.joinTime,
          ),
          InforTitle(
            '所在地区',
            rightText: _myInformation?.city,
          ),
          InforTitle(
            '开发平台',
            rightText: _myInformation?.platforms?.toString(),
          ),
          InforTitle(
            '专长领域',
            rightText: _myInformation?.expertise?.toString(),
          ),
          InforTitle(
            '个性签名',
            subText: " 这个人很懒,啥也没有",
          ),
          Divider(
            height: 2,
            color: Color(ColorUtils.c_cccccc),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(ColorUtils.c_ff0000),
                onPressed: () {
                  DataUtils.clearLoginInfor().then((b) {
                    Navigator.pop(context,true);
                  });
                },
                child: Text(
                  '退出登录',
                  style: TextStyle(color: Color(ColorUtils.c_ffffff)),
                )),
          )
        ],
      ),
    );
  }

  void _getUserInforDetail() {
    RequestApi.getUserInfor().then((infor) {
      _myInformation = infor;
      setState(() {});
    });
  }
}
