//import 'dart:math'; //载入核心库

//import 'package:dio/dio.dart'; //载入第三方库

//import 'mylib1.dart' as lib1; //载入文件
//import 'mylib2.dart' as lib2; //如果两个库有冲突的标识符，可以为其中一个或两个库都指定前缀

//import 'mylib1.dart' as lib1 show Test; //只载入库的某些部分
//import 'mylib2.dart' as lib2 hide Test; //筛选掉库的某些部分

//import 'mylib1.dart' deferred as lazyLib; //延迟载入

//import 'mylib/mylib.dart';//载入自定义库

void main() {
  //使用核心库
//  print(sqrt(4));

  //调用第三方库
//  getHttp();

  //载入文件
//  var myLib1 = lib1.MyLib();
//  var myLib2 = lib2.MyLib();

  //选择性载入
//  var test = lib1.Test();
//  var lib = lib2.MyLib();

  //延迟载入
//  lazyLoad();

  //载入自定义库
//  printMyLib();
//  printUtil();
//  printTool();
}
//调用第三方库
//void getHttp() async {
//  try {
//    Response response = await Dio().get("https://www.baidu.com");
//    print(response);
//  } catch (e) {
//    print(e);
//  }
//}

//延迟载入
//可提高程序启动速度
//用在不常使用的功能
//用在载入时间过长的包
//lazyLoad() async {
//  await lazyLib.loadLibrary();
//  var t = lazyLib.Test();
//  t.test();
//}

