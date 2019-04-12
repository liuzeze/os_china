import 'package:flutter/material.dart';
import 'package:flutter_app/utils/config_utils.dart';

class InforTitle extends StatelessWidget {
  final String _leftText;
  final String subText;
  final String rightText;
  final String rightImg;

  InforTitle(this._leftText, {this.subText, this.rightText, this.rightImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(color: Color(ColorUtils.c_cccccc), width: 0.5))),
      padding: EdgeInsets.all(SizeUtils.px_30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getTitleChild(),
      ),
    );
  }

  List<Widget> getTitleChild() {
    var list = <Widget>[
      Text(
        _leftText,
        style: TextStyle(color: Color(ColorUtils.c_333333)),
      ),
    ];
    if (subText != null) {
      list.add(
        Text(
          subText,
          style: TextStyle(color: Color(ColorUtils.c_666666)),
        ),
      );
    }
    if (rightText != null) {
      list.add(
        Text(
          rightText,
          style: TextStyle(color: Color(ColorUtils.c_666666)),
        ),
      );
    }
    if (rightImg != null) {
      list.add(Container(
        width: SizeUtils.px_100,
        height: SizeUtils.px_100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(rightImg),
          ),
        ),
      ));
    }

    return list;
  }
}
