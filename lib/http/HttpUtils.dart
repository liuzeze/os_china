import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/global/constant.dart';

class HttpUtils {
  static Dio mDio = Dio(BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      baseUrl: AppUrl.BASE_URL,
      responseType: ResponseType.json))
    ..interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions request) {
      print('正在 request==${request.uri}');
      return request;
    }, onResponse: (Response response) {
      print('正在 response==${response.data}');
      return response;
    }, onError: (DioError e) {
      print('出错了');
      return e;
    }));

  static _proxyClient() {
    (mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        // android emuldator ip = 10.0.2.2
        return "PROXY 10.0.2.2:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  static Future<Map> get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    //_proxyClient();
    Response<Map> response = await mDio.get<Map>(
      url,
      queryParameters: params,
    );
    return response.data;
  }

  static Future<Map> uploadFile(
    String url, {
    FormData params,
  }) async {
    //_proxyClient();

    Response<Map> response = await mDio.post(url, data: params);

    return response.data;
  }

  static Future<Map> post(
    String url, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    // _proxyClient();
    Response<Map> response = await mDio.post<Map>(
      url,
      data: data,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }
}
