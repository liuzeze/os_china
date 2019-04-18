import 'dart:async';

import 'package:flutter/services.dart';

class FltToast {
  static const MethodChannel _channel =
      const MethodChannel('flt_toast');

  static Future<bool>  showToast(String text) async{
    Map<String, dynamic> map = <String, dynamic>{
      'text': text,

    };
    bool res=await _channel.invokeMethod('showToast',map);
    return res;
  }

  static Future<bool>  fromHtml(String text) async{
    Map<String, dynamic> map = <String, dynamic>{
      'text': text,

    };
    bool res=await _channel.invokeMethod('fromHtml',map);
    return res;
  }
}
