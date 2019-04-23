import 'package:flutter/rendering.dart';
import 'dart:ui' as ui show window;
import 'package:flutter/material.dart';

/**
 * dp 单位
 */
const double SCREEN_WIDTH = 360;

double getAdapterRatio() {
  return ui.window.physicalSize.width / SCREEN_WIDTH;
}

double getAdapterRatioRatio() {
  return getAdapterRatio() / ui.window.devicePixelRatio;
}

Size getScreenAdapterSize() {
  return Size(SCREEN_WIDTH, ui.window.physicalSize.height / getAdapterRatio());
}

//按照px来设置

class ScreenUtil {

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  ///设备的像素密度
  static double getpixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  ///当前设备宽度 dp
  static double getScreenWidthDp(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  ///当前设备高度 dp
  static double getScreenHeightDp(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///当前设备宽度 px
  static double getScreenWidthPx(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return queryData.size.width *
        queryData.devicePixelRatio;
  }

  ///当前设备高度 px
  static double getScreenHeightPx(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return queryData.size.height *
        queryData.devicePixelRatio;
  }

  ///状态栏高度 刘海屏会更高
  static double getStatusBarHeightPx(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return queryData.padding.top *
        queryData.devicePixelRatio;
  }
  ///底部安全区距离
  static double getBottomBarHeightPx(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return queryData.padding.bottom *
        queryData.devicePixelRatio;
  }



 /* ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  setWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(double height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;*/

}
