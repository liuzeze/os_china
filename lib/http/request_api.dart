import 'dart:async';

import 'package:flutter_app/bean/my_infor_data.dart';
import 'package:flutter_app/global/constant.dart';
import 'package:flutter_app/http/HttpUtils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestApi {
  /// 获取Token
  static Future<Map<String, dynamic>> getOauth2Token(String code) async {
    Map<String, String> map = {
      "client_id": AppUrl.CLIENT_ID,
      "client_secret": AppUrl.CLIENT_SECRET,
      "grant_type": 'authorization_code',
      "redirect_uri": AppUrl.REDIRECT_URI,
      "code": code,
      "dataType": 'json',
    };
    return await HttpUtils.get(AppUrl.OAUTH2_TOKEN, params: map);
  }

  /// 获取登陆信息
  static Future<LoginInfor> getOpenapiUser() async {
    return await DataUtils.getToken().then((token) {
      return {
        "access_token": token,
        "dataType": 'json',
      };
    }).then((map) async {
      return await HttpUtils.get(AppUrl.OPENAPI_USER, params: map).then((map) {
        var loginInfor = LoginInfor.fromJson(map);
        DataUtils.saveLoginInfor(loginInfor);
        return loginInfor;
      });
    });
  }

  /// 获取用户详情
  static Future<MyInformation> getUserInfor() async {
    return await DataUtils.getToken().then((token) {
      return {
        "access_token": token,
        "dataType": 'json',
      };
    }).then((map) async {
      return await HttpUtils.get(AppUrl.MY_INFORMATION, params: map)
          .then((map) {
        var loginInfor = MyInformation.fromJson(map);
        return loginInfor;
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    });
  }
}
