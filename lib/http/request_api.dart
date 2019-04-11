import 'dart:async';

import 'package:flutter_app/global/constant.dart';
import 'package:flutter_app/http/HttpUtils.dart';
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
}
