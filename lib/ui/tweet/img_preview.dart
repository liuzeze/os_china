import 'package:flutter/cupertino.dart';
import 'package:zoomable_image/zoomable_image.dart';

class ImgPreView extends StatefulWidget {
  List<String> imgUrlList;
  int index=0;

  ImgPreView(this.imgUrlList, this.index);

  @override
  _ImgPreViewState createState() => _ImgPreViewState();
}

class _ImgPreViewState extends State<ImgPreView> {
//
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: FixedExtentScrollPhysics(),
        onPageChanged: (_) {
          setState(() {
            widget.index = _;
          });
        },
        controller: PageController(initialPage: widget.index),
        itemCount: widget.imgUrlList.length,
        itemBuilder: (context, index) {
          return ZoomableImage(
              new NetworkImage(widget.imgUrlList[widget.index]));
        });
  }
}
