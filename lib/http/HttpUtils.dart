import 'dart:io';
import 'package:dio/dio.dart';

class HttpUtils {

 static Dio mDio;

  // 工厂模式
  factory HttpUtils() => _getInstance();

  static HttpUtils get instance => _getInstance();
  static HttpUtils _instance;

  HttpUtils._internal() {
    // 初始化
    mDio = new Dio(); // 使用默认配置

// 配置dio实例
    mDio.options.baseUrl = "https://www.xx.com/api";
    mDio.options.connectTimeout = 5000; //5s
    mDio.options.receiveTimeout = 3000;
  }

  static HttpUtils _getInstance() {
    if (_instance == null) {
      _instance = new HttpUtils._internal();
    }
    return _instance;
  }


  static sendReq() async {
    Response response;

    response = await mDio.get("/test?id=12&name=wendu");
    print(response.data.toString());
// 请求参数也可以通过对象传递，上面的代码等同于：
    response =
    await mDio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
    print(response.data.toString());
  }
}
