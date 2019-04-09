import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';

class BottomNavigationBarView {
  final String title;
  final String icon;
  final String activieIcon;
  final BottomNavigationBarItem bottomNavigationBarItem;

  BottomNavigationBarView(
      {@required this.title, @required this.icon, @required this.activieIcon})
      : assert(title != null),
        assert(icon != null),
        assert(activieIcon != null),
        bottomNavigationBarItem = BottomNavigationBarItem(
            icon: Image.asset(icon,width: SizeUtils.px_30,height: SizeUtils.px_30,),
            title: Text(title),
            activeIcon: Image.asset(activieIcon,width: SizeUtils.px_30,height: SizeUtils.px_30,));
}
